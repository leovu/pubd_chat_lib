class User {
  Data? data;
  User({data});
  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  String? userName;
  String? fullName;
  String? email;
  String? phone;
  String? gender;
  int? dob;
  int? statusView;
  String? image;
  String? messageId;
  String? urlImageView;
  String? id;
  String? token;

  Data(
      {userName,
        fullName,
        email,
        phone,
        gender,
        dob,
        statusView,
        image,
        messageId,
        urlImageView,
        id,
        token});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    fullName = json['FullName'];
    email = json['Email'];
    phone = json['Phone'];
    gender = json['Gender'];
    dob = json['Dob'];
    statusView = json['StatusView'];
    image = json['Image'];
    messageId = json['MessageId'];
    urlImageView = json['UrlImageView'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = userName;
    data['FullName'] = fullName;
    data['Email'] = email;
    data['Phone'] = phone;
    data['Gender'] = gender;
    data['Dob'] = dob;
    data['StatusView'] = statusView;
    data['Image'] = image;
    data['MessageId'] = messageId;
    data['UrlImageView'] = urlImageView;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}