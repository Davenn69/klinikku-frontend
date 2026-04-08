import 'package:hive/hive.dart';
import 'package:klinikku/cores/constants/hive_boxes.dart';

class HiveHelper {
  static Future<void> openBoxes() async {
    await Future.wait<void>([Hive.openBox<String>(HiveBoxes.session)]);
  }

  static Future<void> clearBoxesFromDisk() async {
    await Hive.deleteFromDisk();
  }

  static Future<Box<String>> _getSessionBox() async {
    if (!Hive.isBoxOpen(HiveBoxes.session)) {
      await Hive.openBox<String>(HiveBoxes.session);
    }
    return Hive.box<String>(HiveBoxes.session);
  }

  static Future<void> saveSessionTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final sessionBox = await _getSessionBox();
    await sessionBox.put('access_token', accessToken);
    await sessionBox.put('refresh_token', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final sessionBox = await _getSessionBox();
    return sessionBox.get('access_token');
  }

  static Future<String?> getRefreshToken() async {
    final sessionBox = await _getSessionBox();
    return sessionBox.get('refresh_token');
  }

  static Future<void> clearSession() async {
    final sessionBox = await _getSessionBox();
    await sessionBox.clear();
  }
}
