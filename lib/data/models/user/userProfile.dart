class UserProfile {
  final int id;
  final String full_name;
  final String email;
  final String password;


  UserProfile({
    required this.id,
    required this.full_name,
    required this.email,
    required this.password,
});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      full_name: json['full_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }


}