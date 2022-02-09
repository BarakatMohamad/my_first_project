class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  late String name;
  late String email;
  late String image;
  int? points;
  int? credit;
  late String token;
  late String phone;

  // UserData({
  //   required this.email,
  //   required this.name,
  //   required this.image,
  //   required this.points,
  //   required this.credit,
  //   required this.token,
  //   required this.id,
  //   required this.phone,
  // });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    phone = json['phone'];
    token = json['token'];
  }
}
