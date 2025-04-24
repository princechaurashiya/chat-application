import 'package:chat/controllers/login_controller.dart';
import 'package:chat/controllers/regi_page_controller.dart';
import 'package:flutter/material.dart';

Widget buildTextField(
  String hint,
  TextEditingController controller,
  String errorMsg, {
  bool isEmail = false,
}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    validator: (val) {
      if (val == null || val.trim().isEmpty) return errorMsg;
      if (isEmail && !val.contains('@')) return 'Invalid email';
      return null;
    },
  );
}

Widget buildPasswordField(
  String hint,
  TextEditingController controller,
  RegisterController regController, {
  bool confirm = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: regController.obscureText.value,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      suffixIcon: IconButton(
        icon: Icon(
          regController.obscureText.value
              ? Icons.visibility
              : Icons.visibility_off,
          color: Colors.white,
        ),
        onPressed: regController.toggleObscureText,
      ),
    ),
    validator: (val) {
      if (val == null || val.trim().isEmpty) {
        return 'Enter password';
      }
      if (val.length < 8) return 'Password must be 8+ characters';
      if (confirm && val != regController.passController.text) {
        return 'Passwords do not match';
      }
      return null;
    },
  );
}

Widget buildPasswordField1(
  String hint,
  TextEditingController controller,
  LoginController logController, {
  bool confirm = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: logController.obscureText.value,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      suffixIcon: IconButton(
        icon: Icon(
          logController.obscureText.value
              ? Icons.visibility
              : Icons.visibility_off,
          color: Colors.white,
        ),
        onPressed: logController.toggleObscureText,
      ),
    ),
    validator: (val) {
      if (val == null || val.trim().isEmpty) {
        return 'Enter password';
      }
      // if (val.length < 8) return 'Password must be 8+ characters';
      // if (confirm && val != regController.passController.text) {
      //   return 'Passwords do not match';
      // }
      return null;
    },
  );
}
