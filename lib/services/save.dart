import 'package:shared_preferences/shared_preferences.dart';

class SaveService {
  static Future<dynamic> retrieve(String indexname) async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(indexname)) {
      return;
    }
    return prefs.getString('indexName')!;
  }

  static Future<void> save(String indexname, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(indexname, value);
  }

  static Future<void> clear(String indexname) async {
    save(indexname, "");
  }
}
