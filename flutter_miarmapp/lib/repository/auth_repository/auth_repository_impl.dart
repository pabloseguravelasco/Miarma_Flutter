import 'dart:convert';

import 'package:flutter_miarmapp/constants.dart';
import 'package:flutter_miarmapp/models/login_dto.dart';
import 'package:flutter_miarmapp/models/login_response.dart';
import 'package:http/http.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final response =
        await Future.delayed(const Duration(milliseconds: 4000), () {
      return _client.post(Uri.parse('${Constant.apiUrl}/auth/login'),
          headers: headers, body: jsonEncode(loginDto.toJson()));
    });
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }
}
