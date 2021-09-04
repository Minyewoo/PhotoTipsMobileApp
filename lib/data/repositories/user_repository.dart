import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:photo_tips/data/network_exception.dart';

abstract class UserRepository {
  Future<String> fetchToken(String email, String password);
  Future<User> fetchUser(String token);
  Future<String> changePassword(String token, String oldPassword, String newPassword);
  Future<String> changeInfo(String token, String name, String email, String phoneNumber);
}

class ApiUserRepository implements UserRepository {
  @override
  Future<String> fetchToken(String email, String password) async {
    final response =
        await http.get('$apiLoginRoute?Email=$email&Password=$password');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else
      throw NetworkException();
  }

  @override
  Future<User> fetchUser(String token) async {
    final response = await http.get('$apiUserRoute?Token=$token');
    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(json.decode(response.body));
    } else
      throw NetworkException();
  }

  @override
  Future<String> changePassword(
      String token, String oldPassword, String newPassword) async {

    var data = {
      token: token,
      oldPassword: oldPassword,
      newPassword: newPassword
    };

    //final response = await http.get('$apiUserRoute?Token=$token');
    var dio = Dio();
    var response = await dio.put(
      apiUserUpdatePasswordRoute,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(data),
    );
    //http.p
    if (response.statusCode == 200) {
      return response.data['token'];
    } else
      throw NetworkException();
  }

  @override
  Future<String> changeInfo(
      String token, String name, String email, String phoneNumber) async {

    var data = Map<String, dynamic>();
    data.putIfAbsent('token', () => token);

    if(name != null && name != '')
      data.putIfAbsent('name', () => name);

    if(email != null && email != '')
      data.putIfAbsent('email', () => email);

    if(phoneNumber != null && phoneNumber != '')
      data.putIfAbsent('phoneNumber', () => phoneNumber);

    print(data);

    //final response = await http.get('$apiUserRoute?Token=$token');
    var dio = Dio();
    var response = await dio.put(
      apiUserUpdateInfoRoute,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return response.data['token'];
    } else
      throw Exception(response.statusMessage);
  }
}
