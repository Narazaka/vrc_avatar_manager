import 'package:vrc_avatar_manager/prefs.dart';
import 'package:window_manager/window_manager.dart';

class GlobalWindowListener with WindowListener {
  @override
  void onWindowResized() async {
    super.onWindowResized();
    await _collectSizes();
  }

  @override
  void onWindowMoved() async {
    super.onWindowMoved();
    await _collectSizes();
  }

  @override
  void onWindowClose() async {
    await _collectSizes();
    super.onWindowClose();
  }

  @override
  void onWindowMaximize() async {
    super.onWindowMaximize();
    await _collectMaximized(true);
  }

  @override
  void onWindowUnmaximize() async {
    super.onWindowUnmaximize();
    await _collectMaximized(false);
  }

  Future<void> _collectSizes() async {
    final prefs = await Prefs.instance;
    await prefs.setWindowSize(await windowManager.getSize());
    await prefs.setWindowPosition(await windowManager.getPosition());
  }

  Future<void> _collectMaximized(bool maximized) async {
    final prefs = await Prefs.instance;
    await prefs.setWindowMaximized(maximized);
  }
}
