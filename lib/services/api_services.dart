import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_bloc_project/model/user_model.dart';

class ApiServices {
  final String url = "https://fake-json-api.mock.beeceptor.com/users";

  //https://fake-json-api.mock.beeceptor.com/users?_page=1&_limit=10

  Future<List<UserModel>> fetchUserDetails(int page, int limit) async {
    try {
      final response =
          await http.get(Uri.parse("$url?_page=$page&_limit=$limit"));
      if (response.statusCode == 200) {
        final List<dynamic> datas = jsonDecode(response.body);
        return datas.map((data) => UserModel.fromJson(data)).toList();
      } else {
        print("data ${response.statusCode} }");
        throw Exception(
            ' Somthing went wrong Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(' Exception occur : $e');
    }
  }
}
