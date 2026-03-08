class UserModel {
  String? email;
  String? mobile;
  String? photo;
  String? firstName;
  String? lastName;

  UserModel({
    this.email,
    this.mobile,
    this.photo,
    this.firstName,
    this.lastName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
    photo = json['photo'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mobile'] = mobile;
    data['photo'] = photo;
    data['lastName'] = firstName;
    data['firstName'] = lastName;
    return data;
  }
}
