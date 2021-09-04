import 'dart:convert';

import 'package:photo_tips/constants.dart';
import 'package:photo_tips/data/models/module.dart';
import 'package:http/http.dart' as http;
import 'package:photo_tips/data/network_exception.dart';

abstract class ModuleRepository {
  Future<List<Module>> fetchAllModules();
}

class ApiModuleRepository implements ModuleRepository {
  @override
  Future<List<Module>> fetchAllModules() async {
    final response = await http.get('$apiModuleRoute');
    if (response.statusCode == 200) {
      List<dynamic> modules = json.decode(response.body);
      return List.generate(
          modules.length, (index) => Module.fromJson(modules[index]));
    } else
      throw NetworkException();
  }
}
