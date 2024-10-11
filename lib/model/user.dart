class userModel {
  final String? id;
  String name;
  String mail;
  String pass;
  String urlImage;

  userModel({
    this.id,
    required this.name,
    required this.mail,
    required this.pass,
    required this.urlImage,
  });

  // Chuyển đổi userModel thành Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'pass': pass,
      'urlImage': urlImage,
    };
  }

  // Tạo userModel từ Map
  factory userModel.fromMap(Map<String, dynamic> map) {
    return userModel(
      id: map['id'],
      name: map['name'] ?? '',
      mail: map['mail'] ?? '',
      pass: map['pass'] ?? '',
      urlImage: map['urlImage'] ?? '',
    );
  }

  // Tạo userModel từ JSON
  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel.fromMap(json);
  }

  // Chuyển đổi userModel thành JSON
  Map<String, dynamic> toJson() => toMap();
}