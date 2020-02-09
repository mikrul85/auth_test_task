import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _loginToken;
  String _authToken;

  Future<void> login(String phone) async {
    final url = '/auth/login?phone=$phone';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        _loginToken = responseData['login_token'];
      }
      if (response.statusCode == 500) {
        throw (responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkPhone(String code) async {
    final url = '/auth/checkPhone?loginToken=$_loginToken&code=$code';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        _authToken = responseData['auth_token'];
      }
      if (response.statusCode == 500) {
        throw (responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
