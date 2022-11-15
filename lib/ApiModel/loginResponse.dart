class LoginReponse {
  String? token;
  String? privatetoken;
  String? error;
  String? errorcode;

  LoginReponse({this.token, this.privatetoken, this.error, this.errorcode});

  LoginReponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    privatetoken = json['privatetoken'];
    error = json['error'];
    errorcode = json['errorcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['privatetoken'] = this.privatetoken;
    data['error'] = this.error;
    data['errorcode'] = this.errorcode;
    return data;
  }
}