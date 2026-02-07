import 'package:farmhouse_app/views/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", user.id);
    await prefs.setString("firstName", user.firstName);
    await prefs.setString("lastName", user.lastName);
    await prefs.setString("email", user.email);
    await prefs.setString("phoneNumber", user.phoneNumber);
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("userId");

    if (id == null) return null;

    return UserModel(
      id: id,
      firstName: prefs.getString("firstName") ?? "",
      lastName: prefs.getString("lastName") ?? "",
      email: prefs.getString("email") ?? "",
      phoneNumber: prefs.getString("phoneNumber") ?? "",
    );
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
