class UserSingIn{
  final String email;
  final String password;

  UserSingIn({
    required this.email,
    required this.password,
});
  Map <String,dynamic> toJson() =>{
    'email':email,
    'password':password,
    'grant_type': 'password',
  };
}