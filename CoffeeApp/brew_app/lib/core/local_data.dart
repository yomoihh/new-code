// ==========================================
// 本地数据访问模块
// 职责：统一管理本地 JSON 文件和图片的读写路径
// ==========================================

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class LocalData {
  static String _root() =>
      Platform.environment['BREW_DATA_ROOT'] ?? Directory.current.path;

  static String dataPath(String file) => '${_root()}/data/$file';
  static String uploadPath(String file) => '${_root()}/uploads/$file';

  /// 读取本地 JSON 文件，文件不存在时返回 null
  static Future<Map<String, dynamic>?> readJson(String filename) async {
    try {
      final f = File(dataPath(filename));
      if (!await f.exists()) return null;
      return json.decode(await f.readAsString());
    } catch (_) {
      return null;
    }
  }

  /// 读取本地图片文件为字节数组，文件不存在或为空时返回 null
  static Future<Uint8List?> readImage(String filename) async {
    if (filename.isEmpty) return null;
    try {
      final f = File(uploadPath(filename));
      if (!await f.exists()) return null;
      return await f.readAsBytes();
    } catch (_) {
      return null;
    }
  }
}
