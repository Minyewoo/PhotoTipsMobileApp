import 'dart:convert';

import 'package:photo_tips/constants.dart';
import 'package:photo_tips/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:photo_tips/data/network_exception.dart';

abstract class AuthRepository {
  Future<String> fetchToken(String email, String password);
  Future<void> signUp(String name, String email, String password);
}

class ApiAuthRepository implements AuthRepository {
  @override
  Future<String> fetchToken(String email, String password) async {
    final response =
        await http.get('$apiLoginRoute?Email=$email&Password=$password');

    if (response.statusCode == 200) {
      return response.body;
    } else
      throw NetworkException();
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    final body = {
      "Name": name,
      "Email": email,
      "Password": password,
    };

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      '$apiRegisterRoute',
      body: json.encode(body),
      headers: headers,
    );
    
    if (response.statusCode != 200) throw NetworkException();
  }
}
