import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://justcatering.in/JustWeddingProAppTest/WS";
 //1 Post LogIn
  static Future<http.Response> getLoginCustomer(
    String username,
    String password,
  ) async {
    var url = Uri.parse("$baseUrl/loginclientuser/");
    var body = {"userName": username, "password": password};
    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> getMenuCategory(int clientId) async {
    try {

      var url = Uri.parse("$baseUrl/getmenucategorybyclientid/400/");

      debugPrint("Calling API: $url");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      return response;
    } catch (e) {
      print("Network Error: $e");
      rethrow;
    }
  }

}
