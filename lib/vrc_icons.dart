import 'package:flutter/material.dart';

const double _platformIconSize = 28;
const double _platformIconSize2 = 56;
const double _performanceIconSize = 28;
// 表示サイズの2倍でデコード（高DPI用の余裕）
const int _platformIconCacheWidth = 56;
const int _platformIconCacheWidth2 = 112;
const int _performanceIconCacheWidth = 56;

class VrcIcons {
  static final pc = Image.asset(
    "assets/platform/pc.png",
    width: _platformIconSize,
    cacheWidth: _platformIconCacheWidth,
  );
  static final android = Image.asset(
    "assets/platform/android.png",
    width: _platformIconSize,
    cacheWidth: _platformIconCacheWidth,
  );
  static final crossPlatform = Image.asset(
    "assets/platform/cross_platform.png",
    width: _platformIconSize2,
    cacheWidth: _platformIconCacheWidth2,
  );
  static final excellent = Image.asset(
    "assets/performance/excellent.png",
    width: _performanceIconSize,
    cacheWidth: _performanceIconCacheWidth,
  );
  static final good = Image.asset(
    "assets/performance/good.png",
    width: _performanceIconSize,
    cacheWidth: _performanceIconCacheWidth,
  );
  static final medium = Image.asset(
    "assets/performance/medium.png",
    width: _performanceIconSize,
    cacheWidth: _performanceIconCacheWidth,
  );
  static final poor = Image.asset(
    "assets/performance/poor.png",
    width: _performanceIconSize,
    cacheWidth: _performanceIconCacheWidth,
  );
  static final verypoor = Image.asset(
    "assets/performance/verypoor.png",
    width: _performanceIconSize,
    cacheWidth: _performanceIconCacheWidth,
  );
  static final none = Image.asset(
    "assets/performance/none.png",
    width: _performanceIconSize,
    cacheWidth: _performanceIconCacheWidth,
  );
}
