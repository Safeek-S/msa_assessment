// User class
class User {
  String? id;
  String? userName;
  String password;
  String email;
  bool? isDeactivated;

  User({
    this.id,
    this.userName,
    required this.password,
    required this.email,
    this.isDeactivated = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      isDeactivated: json['isDeactivated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'isDeactivated': isDeactivated ?? false,
    };
  }
}