
class CreateCustomerResponce{
  int id;
  String email;
  String first_name;
  String last_name;
  String role;
  String username;

  CreateCustomerResponce(this.id, this.email, this.first_name, this.last_name, this.role, this.username);

  CreateCustomerResponce.fromJson(Map<String, dynamic> json):
        id = json['id'],
        email = json['email'],
        first_name = json['first_name'],
        last_name = json['last_name'],
        role = json['role'],
        username = json['username']
  {}

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'role': role,
        'username': username,
      };
}

