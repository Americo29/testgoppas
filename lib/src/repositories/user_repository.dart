import 'package:testgoppas/src/providers/api_services.dart';

class UserRepository {
  final _apiService = ApiService();

  // Future<Response> register(
  //     {@required String email, @required String password}) async {
  //   final result = await _apiService.registerUser(email, password);
  //   return result;
  // }

  Future<Response> getFieldRegister() async {
    final result = await _apiService.getFieldRegister();
    if (result.ok) {
      print(result.fieldregister);
    }
    return result;
  }

  Future<bool> takeToken() async {
    await Future.delayed(Duration(seconds: 3));
    return false;
  }

  // Future<bool> hasToken() async {
  //   final _prefs = await UserPrefs().initPrefs();
  //   final bool hastoken = await _prefs.hasToken;
  //   if (hastoken) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  //   // await Future.delayed(Duration(seconds: 2));
  // }
}
