import 'package:santander_app/models/user_model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiApp {
  static Future<UserModel> fetchUser(int id) async {
    var result = await http
        .get(Uri.parse("https://sdw-2023-prd.up.railway.app/users/1"));
    return UserModel.fromJson(result.body);
  }
}
