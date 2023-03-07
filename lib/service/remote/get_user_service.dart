import 'package:dio/dio.dart';
import 'package:news/models/user_models.dart';

class GetUsersService {
  static Future<dynamic> getUsers() async {
    try {
      Response response =
          await Dio().get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
      } else {
        return response.statusMessage.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}