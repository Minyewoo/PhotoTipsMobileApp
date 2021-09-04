import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/data/models/photo.dart';
import 'package:photo_tips/data/models/submission.dart';
import 'package:photo_tips/data/network_exception.dart';
import 'package:http/http.dart' as http;

abstract class SubmissionRepository {
  Future<List<Submission>> fetchSubmissions(String token);
  Future<void> submitPhoto(String token, String path, int moduleEntryId);
}

class ApiSubmissionRepository implements SubmissionRepository {
  @override
  Future<void> addPhoto(String token, String path) async {
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'UserToken': token,
      'File': await MultipartFile.fromFile(path),
    });
    var response = await dio.post(apiAddPhotoRoute, data: formData);
    if (response.statusCode == 200) {
    } else
      throw NetworkException();
  }

  @override
  Future<List<Photo>> fetchPhotos(String token) async {
    final response = await http.get('$apiGetPhotoRoute?UserToken=$token');
    if (response.statusCode == 200) {
      List<dynamic> photos = json.decode(response.body);
      return List.generate(
          photos.length, (index) => Photo.fromJson(photos[index]));
    } else
      throw NetworkException();
  }

  Future<void> deletePhoto(String id) async {
    Dio dio = Dio();
    var response = await dio.delete('$apiDeletePhotoRoute?PhotoId=$id');
    if (response.statusCode == 200) {
    } else
      throw NetworkException();
  }

  @override
  Future<List<Submission>> fetchSubmissions(String token) async {
    final response = await http.get('$apiGetSubmissionRoute?UserToken=$token');
    if (response.statusCode == 200) {
      List<dynamic> submissions = json.decode(response.body);
      return List.generate(submissions.length,
          (index) => Submission.fromJson(submissions[index]));
    } else
      throw NetworkException();
  }

  @override
  Future<void> submitPhoto(String token, String path, int moduleEntryId) async {
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'UserToken': token,
      'File': await MultipartFile.fromFile(path),
      'ModuleEntryId': token,
    });
    var response = await dio.post(apiCreateSubmissionRoute, data: formData);
    if (response.statusCode == 200) {
    } else
      throw NetworkException();
  }
}
