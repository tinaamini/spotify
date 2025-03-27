class UserRegister {
  final String fullName;
  final String email;
  final String password;

  UserRegister({
    required this.fullName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'full_name': fullName,
    'email': email,
    'password': password,
  };
}

class UserResponse {
  final int id;
  final String fullName;
  final String email;
  final String password;

  UserResponse({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
    );
  }
}