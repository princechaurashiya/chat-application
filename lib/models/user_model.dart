// class UserModel {
//   String name;
//   String email;
//   String password;
//   String confirmPassword;

//   UserModel({
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.confirmPassword,
//   });

//   // Convert JSON to Model
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       password: json['password'] ?? '',
//       confirmPassword: json['Cpassword'] ?? '',
//     );
//   }

//   // Convert Model to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "email": email,
//       "password": password,
//       "cpassword": confirmPassword,
//     };
//   }
// }

class UserModel {
  String? id; // User's ID (from _id in backend)
  String? name;
  String email;
  String password;
  //String confirmPassword;

  UserModel({
    this.id,
    this.name,
    required this.email,
    required this.password,
    //required this.confirmPassword,
  });

  // Convert JSON to Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString(), // ✅ use _id from backend
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      // confirmPassword: '', // usually not returned by API
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null)
        "_id": id, // Optional: only if backend accepts it on sending
      "name": name,
      "email": email,
      "password": password,
      // Don't send confirmPassword unless explicitly needed
    };
  }
}
