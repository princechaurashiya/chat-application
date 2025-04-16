class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  // Convert model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
