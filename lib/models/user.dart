class User {
  String? sId;
  String? username;
  String? password;
  String? role;
  String? name;
  String? email;
  String? authData;


  User(
      {this.sId,
        this.username,
        this.password,
        this.role,
        this.email,
        this.name,
        this.authData
      });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    username = json['name'];
    role = json['role'];
    name = json['name'];
    email = json['name'];
    authData = json['authData'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    data['role'] = this.role;
    data['email'] = this.name;
    data['username'] = this.name;
    data['authData'] = this.authData;

    return data;
  }
}