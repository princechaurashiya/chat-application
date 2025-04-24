import 'dart:convert';
import 'dart:html' as html;

class AuthService {
  static const _tokenKey = 'auth_key';
  static const _userIdKey = 'user_id';
  static const _userNameKey = 'user_name'; // ✅ NEW

  /// Save JWT token, userId & userName
  static void saveToken(String token) {
    html.window.localStorage[_tokenKey] = token;
    print("🔐 Token saved to localStorage");

    final payload = decodeJwtPayload(token);

    // Save userId
    final userId = payload?['_id'] ?? payload?['id'];
    if (userId != null) {
      html.window.localStorage[_userIdKey] = userId.toString();
      print("🗃️ user_id saved to localStorage: $userId");
    } else {
      print("⚠️ user_id not found in token payload");
    }

    // ✅ Save userName
    final userName = payload?['name'] ?? payload?['username'];
    if (userName != null) {
      html.window.localStorage[_userNameKey] = userName.toString();
      print("📝 user_name saved to localStorage: $userName");
    } else {
      print("⚠️ user_name not found in token payload");
    }
  }

  /// Get stored JWT token
  static String? getToken() {
    final token = html.window.localStorage[_tokenKey];
    print("📦 Retrieved token: $token");
    return token;
  }

  /// Get userId from localStorage
  static String? getUserId() {
    final userId = html.window.localStorage[_userIdKey];
    print("👤 Retrieved user_id from localStorage: $userId");
    return userId;
  }

  /// ✅ Get userName from localStorage
  static String? getUserName() {
    final userName = html.window.localStorage[_userNameKey];
    print("👤 Retrieved user_name from localStorage: $userName");
    return userName;
  }

  /// Clear token, userId & userName (logout)
  static void clearToken() {
    html.window.localStorage.remove(_tokenKey);
    html.window.localStorage.remove(_userIdKey);
    html.window.localStorage.remove(_userNameKey); // ✅
    print("🚪 Token, user_id & user_name removed from localStorage");
  }

  /// Decode JWT payload
  static Map<String, dynamic>? decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        print("❌ Invalid JWT structure");
        return null;
      }

      final payload = parts[1];
      final normalized = base64.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = jsonDecode(decoded) as Map<String, dynamic>;

      print("🧾 Decoded JWT Payload: $payloadMap");
      return payloadMap;
    } catch (e) {
      print("❌ JWT decode error: $e");
      return null;
    }
  }
}
