class User{
  String id;
  String uid;
  String email;
  String name;
  String password;

  User(this.id, this.uid, {required this.name, required this.email, required this.password});

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        uid = res["uid"],
        email = res["email"],
        name = res["name"],
        password = res["password"];
  Map<String, Object?> toMap(){
    return{
      'id' : id,
      'email': email,
      'name': name,
      'password': password
    };
  }
}