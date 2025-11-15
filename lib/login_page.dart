import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrc_avatar_manager/store.dart';
import 'package:vrc_avatar_manager/vrc_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.accountId});

  final String accountId;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _restored = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _twoFactorController = TextEditingController();
  final _authTokenController = TextEditingController();
  bool _savePassword = false;

  VrcApi? _api;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    var credentials = await Store().getCredentials(widget.accountId);
    if (credentials != null) {
      var (username, password) = credentials;
      setState(() {
        _usernameController.text = username;
        _passwordController.text = password;
        _savePassword = true;
        _restored = true;
      });
    } else {
      setState(() {
        _restored = true;
      });
    }
  }

  void _loginByUsernamePassword() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      _showError("Username and password cannot be empty");
      return;
    }
    var api = VrcApi.load(widget.accountId);
    var (res, err) =
        await api.vrchatDart.auth.login(username: username, password: password);
    if (res == null) {
      print(err);
      _showError("Cannot login with that username/password");
      return;
    }
    var authResponse = res.data;
    if (authResponse.requiresTwoFactorAuth) {
      setState(() {
        _api = api;
      });
      return;
    }
    await Store().setDefaultAccountId(widget.accountId);
    if (_savePassword) {
      await Store().setCredentials(widget.accountId, username, password);
    }

    await Navigator.pushReplacementNamed(context, "/avatars",
        arguments: widget.accountId);
  }

  void _loginBy2FA() async {
    if (_api == null) {
      _showError("No API to login with 2FA");
      return;
    }
    var code = _twoFactorController.text;
    if (code.isEmpty) {
      _showError("2FA code cannot be empty");
      return;
    }
    _twoFactorController.text = "";
    var (res, err) = await _api!.vrchatDart.auth.verify2fa(code);
    if (res == null) {
      _showError("Cannot login with that 2FA code");
      return;
    }

    await Store().setDefaultAccountId(widget.accountId);
    await Navigator.pushReplacementNamed(context, "/avatars",
        arguments: widget.accountId);
  }

  void _cancel2FA() {
    setState(() {
      _api = null;
    });
  }

  void _loginByAuthToken() async {
    var authToken =
        RegExp(r"authcookie_[\w-]+").stringMatch(_authTokenController.text);
    if (authToken == null) {
      _showError("Invalid auth token");
      return;
    }
    var api = VrcApi.loadByAuthToken(widget.accountId, authToken);
    var checked = await api.checkValid();
    if (!checked) {
      _showError("Cannot login with that auth token");
      return;
    }

    await Store().setDefaultAccountId(widget.accountId);
    await Navigator.pushReplacementNamed(context, "/avatars",
        arguments: widget.accountId);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: const Color(0xFFFF6600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Login"),
      ),
      body: Center(
          child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login by username/password',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _usernameController,
              enabled: _restored && _api == null,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              onSubmitted: (value) => _loginByUsernamePassword(),
            ),
            TextField(
              controller: _passwordController,
              enabled: _restored && _api == null,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onSubmitted: (value) => _loginByUsernamePassword(),
            ),
            CheckboxListTile(
              enabled: _restored && _api == null,
              value: _savePassword,
              onChanged: (value) {
                setState(() {
                  _savePassword = value!;
                });
              },
              title: const Text("Save password"),
            ),
            if (_api != null)
              TextField(
                controller: _twoFactorController,
                decoration: const InputDecoration(
                  labelText: '2FA code',
                ),
                onSubmitted: (value) => _loginBy2FA(),
              ),
            ElevatedButton(
              onPressed: _api == null ? _loginByUsernamePassword : _loginBy2FA,
              child: const Text("Login"),
            ),
            if (_api != null)
              ElevatedButton(
                onPressed: _cancel2FA,
                child: const Text("Cancel 2FA"),
              ),
            const Divider(),
            const Text(
              'Login by auth token',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse("https://vrchat.com/home/login"));
                },
                child: const Text("VRChat login page")),
            TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse("https://vrchat.com/api/1/auth"));
                },
                child: const Text("VRChat auth token (after login)")),
            TextField(
              controller: _authTokenController,
              decoration: const InputDecoration(
                labelText: 'Auth token',
              ),
              onSubmitted: (value) => _loginByAuthToken(),
            ),
            ElevatedButton(
              onPressed: _loginByAuthToken,
              child: const Text("Login"),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text("アカウント情報入力の危険性について",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  Text("""本アプリはVRChatとは無関係の個人が提供しています。
VRChatのアカウント情報を入力することは、そのアプリにアカウントの全ての操作を行える権限を与え、またそのアプリの脆弱性がアカウントに影響することを意味します。
この危険性を考慮の上、アプリを信頼できる場合にのみ自己責任でご利用をお願い致します。（これは現行のVRChatの認証方式そのものによる問題なので、他のVRChat関連サービスにおいても同様にお気を付け下さい）""",
                      style: TextStyle(color: Colors.red)),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
