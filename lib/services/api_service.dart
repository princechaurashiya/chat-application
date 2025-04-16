import 'dart:convert';
import 'dart:html' as html;

import 'package:http/http.dart' as http;

class ApiService {
  //static const String baseUrl = "http://localhost:3000";
  static const String baseUrl = "https://api-ss5j.onrender.com";
  static const String baseUrl2 = "https://chatapp-backend-e1px.onrender.com";

  /// ✅ Reusable POST Request with Optional Auth
  static Future<Map<String, dynamic>?> postRequest(
    String endpoint,
    Map<String, dynamic> data, {
    String? token,
  }) async {
    final Uri url = Uri.parse("$baseUrl/$endpoint");
    print("🔹 Sending POST Request to: $url");

    // Get token from localStorage if not provided
    token ??= html.window.localStorage['auth_key'];
    print("🔹 Using Token: ${token ?? "No Token Provided"}");

    try {
      final headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      print("🔹 API Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : {};
      } else {
        print("❌ Request failed with status: ${response.statusCode}");
        return {
          "error": "Request failed with status: ${response.statusCode}",
          "status_code": response.statusCode,
        };
      }
    } catch (e) {
      print("❌ POST Request Failed: $e");
      return {"error": "Something went wrong: $e"};
    }
  }

  //get fun with auth and header
  static Future<dynamic> getRequest(String endpoint, {String? token}) async {
    if (endpoint.startsWith('m')) {
      final url = Uri.parse('$baseUrl2/$endpoint');
    } else {
      final url = Uri.parse('$baseUrl/$endpoint');
      print(url.toString());
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token', // ✅ THIS LINE
      };

      print("🔗 Sending GET Request to: $url");
      print("🔐 Using Headers: $headers");

      try {
        final response = await http.get(url, headers: headers);
        print("🔹 Response Code: ${response.statusCode}");

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          return {
            "error": "Request failed with status: ${response.statusCode}",
            "status_code": response.statusCode,
          };
        }
      } catch (e) {
        print("❌ Exception in GET request: $e");
        return null;
      }
    }
  }
  // get fun without header

  static Future<dynamic> getRequestNoHeader(String endpoint) async {
    // 👇 Smart URL selection based on endpoint
    final Uri url =
        endpoint.startsWith('m')
            ? Uri.parse('$baseUrl2/$endpoint')
            : Uri.parse('$baseUrl/$endpoint');

    print("🔗 Sending GET Request to: $url");

    try {
      // 👇 No headers
      final response = await http.get(url);
      print("🔹 Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.toString());
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Request failed with status: ${response.statusCode}",
          "status_code": response.statusCode,
        };
      }
    } catch (e) {
      print("❌ Exception in GET request: $e");
      return null;
    }
  }
}
