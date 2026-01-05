import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:just_weding_software/model/captain_model.dart';
import 'package:just_weding_software/model/function_model.dart';

import '../model/menuitem_model.dart';
import '../model/order_history_model.dart';
import '../model/order_request_model.dart';

class ApiService {
  static const String baseUrl = "https://justwedding.in/JustWeddingProAppTest/WS";

  //1 Post LogIn
  static Future<http.Response> getLoginCustomer(String username,
      String password,)
  async {
    var url = Uri.parse("$baseUrl/loginclientuser/");
    var body = {"userName": username, "password": password};
    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
  }

  // 2 Get MenuCategory
  static Future<http.Response> getMenuCategory(int clientId) async {
    try {
      var url = Uri.parse("$baseUrl/getmenucategorybyclientid/$clientId/");

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

  // 3 FetchMenu
  Future<MenuItemModel> fetchMenu(dynamic eventId,
      dynamic functionId) async {
    final url = "https://justwedding.in/JustWeddingProAppTest/WS/geteventmenuplandetailsbyeventandfunctionid/471194/23266/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return MenuItemModel.fromJson(jsonData);
      } else {
        print("Server Error Detail: ${response.body}");
        throw Exception('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect: $e');
    }
  }

  // 4. fetch function

  Future<FunctionModel?> fetchFunction(dynamic clientUserId) async {
    var url = Uri.parse(
        "https://justwedding.in/WS/getfunctionmanagerassignbyclientId/$clientUserId/");

    try {
      debugPrint("Calling Function API: $url");
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['success'] == true) {
          return FunctionModel.fromJson(jsonData);
        } else {
          debugPrint("API Error: ${jsonData['msg']}");
          return null;
        }
      } else {
        debugPrint("Server Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception in fetchFunction: $e");
      return null;
    }
  }

  // 5 getTable
  Future<List<dynamic>?> getAssignedTables(int clientUserId, int eventId,
      int functionId) async {
    var url = Uri.parse(
        "$baseUrl/getmanagertableassignbyclientandfunctionid/$clientUserId/$eventId/$functionId/");

    try {
      debugPrint("Calling Table API with path: $url");
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data']['managerTableAssignDetails'];
        }
        else {
          debugPrint("API Error: ${jsonData['msg']}");
          return null;
        }
      }
      else {
        debugPrint("Server Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception in getAssignedTables: $e");
      return null;
    }
  }

  // 6 Create Captain

  static Future<CaptainModel?> addCaptain(Map<String, dynamic> data) async {
    try {
      var url = Uri.parse("$baseUrl/adduser/");
      final response = await http.post(url,
        headers: {"Content Type": "application/json"},
        body: jsonEncode(data),

      );
      if (response.statusCode == 200) {
        return CaptainModel.fromJson(jsonDecode(response.body));
      }
      else {
        debugPrint("Server Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception in addCaptain: $e");
      return null;
    }
  }

  // 7 Add orderTable

  Future<Map<String, dynamic>> addOrderTable(
      Map<String, dynamic> orderbody) async {
    final String orderUrl = "https://justwedding.in/JustWeddingProAppTest/WS/addordertable/";
    try {
      final response = await http.post(
        Uri.parse(orderUrl),
        headers: {"Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(orderbody),
      );
      debugPrint("Order Status Code: ${response.statusCode}");
      debugPrint("Order Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"msg": "Server Error ${response.statusCode}", "success": false};
      }
    } catch (e) {
      return {"msg": "Connection error :$e", "success": false};
    }
  }

  // 7 Add Feedback

  Future<Map<String, dynamic>> addFeedback(Map<String, dynamic> body) async {
    const feedbackUrl = "https://justwedding.in/JustWeddingProAppTest/WS/addfeedback/";
    try {
      final response = await http.post(
        Uri.parse(feedbackUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"msg": "Server Error ${response.statusCode}", "success": false};
      }
    }
    catch (e) {
      print('Exception in feedback:$e');
      return {"msg": "Connection error", "success": false};
    }
  }

  // 8 GetOrderHistoryByStatus

  Future<OrderHistoryModel?> getOrderHistoryByStatus(int clientUserId,
      int eventId, int functionId, String status) async {
    var url = Uri.parse(
        "$baseUrl/getordertablebystatusandeventandfunctionid/$clientUserId/$eventId/$functionId/$status/");
    print("Final API URL: $url");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return OrderHistoryModel.fromJson(jsonDecode(response.body));
      }
      else {
        debugPrint("Server Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception in getOrderHistoryByStatus: $e");
      return null;
    }
  }

  // 10 PostOrderStatusChange

  Future<Map<String, dynamic>?> changeOrderStatus(int orderId, String newStatus) async {
    const String url = "https://justwedding.in/JustWeddingProAppTest/WS/changeordertablestatus/";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "orderTableId": [orderId], // List format jaisa body mein manga hai
          "status": newStatus
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      debugPrint("Status API Error: $e");
      return null;
    }
  }
}

