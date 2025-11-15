import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/account_view.dart';
import 'package:vrc_avatar_manager/db/account.dart';
import 'package:vrc_avatar_manager/db/accounts_db.dart';
import 'package:vrc_avatar_manager/store.dart';
import 'package:vrc_avatar_manager/vrc_api.dart';
import 'package:collection/collection.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key, this.goAccount});

  final String? goAccount;

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  late final AccountsDb _accountsDb;

  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    _ensureDb().then((v) async {
      if (widget.goAccount != null) {
        await _login(widget.goAccount!);
      }
      _watchDb();
    });
  }

  Future<void> _ensureDb() async {
    _accountsDb = await AccountsDb.instance;
  }

  void _watchDb() {
    _accountsDb.watchAccounts(fireImmediately: true).listen((_) {
      _loadAccounts();
    });
  }

  Future<void> _loadAccounts() async {
    var accounts = await _accountsDb.getAll();
    setState(() {
      _accounts = accounts;
    });
  }

  Future<void> _createAccount() async {
    var account = Account()..name = "account";
    await _accountsDb.put(account);
  }

  Future<void> _editAccountName(Account account, String name) async {
    await _accountsDb.put(account..name = name);
  }

  Future<void> _login(String accountId) async {
    if (await _tryLogin(accountId)) return;
    await _gotoLogin(accountId);
  }

  Future<void> _logout(String accountId) async {
    await Store().deleteCredentials(accountId);
    await Store().deleteDefaultAccountId();
    var api = VrcApi.load(accountId);
    await api.logout();
    await VrcApi.clearCookies(accountId);
    _showInfo("Logged out");
  }

  Future<void> _askDelete(String accountId) async {
    var account = _accounts.firstWhereOrNull((a) => a.accountId == accountId);
    if (account == null) {
      return;
    }
    var res = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete account"),
        content: Text("Are you sure you want to delete ${account.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
    if (res == true) {
      await _delete(accountId);
    }
  }

  Future<void> _delete(String accountId) async {
    await _accountsDb.delete(accountId);
    _showInfo("Deleted account!");
  }

  Future<bool> _tryLogin(String accountId) async {
    var api = VrcApi.load(accountId);
    if (await api.checkValid()) {
      await Store().setDefaultAccountId(accountId);
      await _gotoAvatars(accountId);
      return true;
    }

    var credentials = await Store().getCredentials(accountId);
    if (credentials == null) {
      return false;
    }
    var (username, password) = credentials;
    var (res, err) = await api.vrchatDart.auth.login(
      username: username,
      password: password,
    );
    if (res == null) {
      return false;
    }
    await Store().setDefaultAccountId(accountId);
    _gotoAvatars(accountId);
    return true;
  }

  Future<void> _gotoLogin(String accountId) async {
    await Navigator.pushNamed(context, "/login", arguments: accountId);
  }

  Future<void> _gotoAvatars(String accountId) async {
    await Navigator.pushNamed(context, "/avatars", arguments: accountId);
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: const Color(0xFF0066FF),
      ),
    );
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
        title: const Text("Accounts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createAccount,
          ),
        ],
      ),
      body: Center(
          child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _accounts
              .map((account) => AccountView(
                    key: Key(account.id.toString()),
                    account: account,
                    onLogin: () => _login(account.accountId),
                    onLogout: () => _logout(account.accountId),
                    onDelete: () => _askDelete(account.accountId),
                    onChangeName: (name) => _editAccountName(account, name),
                  ))
              .toList(),
        ),
      )),
    );
  }
}
