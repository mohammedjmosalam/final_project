class UserApp {
  final String idUser;
  final String name;
  final String email;
  final String password;
  final String birthday;
  final String gender;
  final String? imagePerson;
  UserApp({
    required this.idUser,
    required this.birthday,
    required this.email,
    required this.gender,
    required this.name,
    required this.password,
    this.imagePerson,
  });
  UserApp copyWith({
    String? name,
    String? imagePerson,
  }) =>
      UserApp(
          birthday: birthday,
          email: email,
          gender: gender,
          idUser: idUser,
          name: name ?? this.name,
          password: password,
          imagePerson: imagePerson ?? this.imagePerson);
  factory UserApp.fromJson(Map<String, dynamic> json) => UserApp(
        birthday: json['birthday'],
        email: json['email'],
        gender: json['gender'],
        name: json['name'],
        password: json['password'],
        imagePerson: json['imagePerson'],
        idUser: json['idUser'],
      );
  Map<String, dynamic> toJson() => {
        'birthday': birthday,
        'email': email,
        'gender': gender,
        'name': name,
        'password': password,
        'imagePerson': imagePerson,
        'idUser': idUser,
      };
}
