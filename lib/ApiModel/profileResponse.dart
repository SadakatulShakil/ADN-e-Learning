class ProfileResponse {
  int? id;
  String? username;
  String? fullname;
  String? email;
  String? department;
  int? firstaccess;
  int? lastaccess;
  String? auth;
  bool? suspended;
  bool? confirmed;
  String? lang;
  String? theme;
  String? timezone;
  int? mailformat;
  String? description;
  int? descriptionformat;
  String? city;
  String? profileimageurlsmall;
  String? profileimageurl;

  ProfileResponse(
      {this.id,
        this.username,
        this.fullname,
        this.email,
        this.department,
        this.firstaccess,
        this.lastaccess,
        this.auth,
        this.suspended,
        this.confirmed,
        this.lang,
        this.theme,
        this.timezone,
        this.mailformat,
        this.description,
        this.descriptionformat,
        this.city,
        this.profileimageurlsmall,
        this.profileimageurl});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    department = json['department'];
    firstaccess = json['firstaccess'];
    lastaccess = json['lastaccess'];
    auth = json['auth'];
    suspended = json['suspended'];
    confirmed = json['confirmed'];
    lang = json['lang'];
    theme = json['theme'];
    timezone = json['timezone'];
    mailformat = json['mailformat'];
    description = json['description'];
    descriptionformat = json['descriptionformat'];
    city = json['city'];
    profileimageurlsmall = json['profileimageurlsmall'];
    profileimageurl = json['profileimageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['department'] = this.department;
    data['firstaccess'] = this.firstaccess;
    data['lastaccess'] = this.lastaccess;
    data['auth'] = this.auth;
    data['suspended'] = this.suspended;
    data['confirmed'] = this.confirmed;
    data['lang'] = this.lang;
    data['theme'] = this.theme;
    data['timezone'] = this.timezone;
    data['mailformat'] = this.mailformat;
    data['description'] = this.description;
    data['descriptionformat'] = this.descriptionformat;
    data['city'] = this.city;
    data['profileimageurlsmall'] = this.profileimageurlsmall;
    data['profileimageurl'] = this.profileimageurl;
    return data;
  }
}

class Preferences {
  String? name;
  String? value;

  Preferences({this.name, this.value});

  Preferences.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}