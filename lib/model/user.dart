class User {
  final int? id;
  String name;
  String mail;
  String pass;
  String urlImage;

  User({
    this.id,
    required this.name,
    required this.mail,
    required this.pass,
    required this.urlImage,
  });

  // Tạo đối tượng User từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      mail: json['mail'],
      pass: json['pass'],
      urlImage: json['urlImage'],
    );
  }

  // Chuyển đối tượng User thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'mail': mail,
      'pass': pass,
      'urlImage': urlImage,
    };
  }
}
