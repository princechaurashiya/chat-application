class LoginModel {
  final String name;
  final String email;
  final String password;

  LoginModel({required this.name, required this.email, required this.password});

  // Convert model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "password": password};
  }
}
