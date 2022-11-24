class BadgesResponse {
  List<Badges>? badges;

  BadgesResponse({this.badges});

  BadgesResponse.fromJson(Map<String, dynamic> json) {
    if (json['badges'] != null) {
      badges = <Badges>[];
      json['badges'].forEach((v) {
        badges!.add(new Badges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.badges != null) {
      data['badges'] = this.badges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Badges {
  int? id;
  String? name;
  String? description;
  int? timecreated;
  int? timemodified;
  int? usercreated;
  int? usermodified;
  String? issuername;
  String? issuerurl;
  String? issuercontact;
  int? expiredate;
  int? expireperiod;
  int? type;
  int? courseid;
  String? message;
  String? messagesubject;
  int? attachment;
  int? notification;
  int? status;
  int? issuedid;
  String? uniquehash;
  int? dateissued;
  int? dateexpire;
  int? visible;
  String? email;
  String? version;
  String? language;
  String? imageauthorname;
  String? imageauthoremail;
  String? imageauthorurl;
  String? imagecaption;
  String? badgeurl;

  Badges(
      {this.id,
        this.name,
        this.description,
        this.timecreated,
        this.timemodified,
        this.usercreated,
        this.usermodified,
        this.issuername,
        this.issuerurl,
        this.issuercontact,
        this.expiredate,
        this.expireperiod,
        this.type,
        this.courseid,
        this.message,
        this.messagesubject,
        this.attachment,
        this.notification,
        this.status,
        this.issuedid,
        this.uniquehash,
        this.dateissued,
        this.dateexpire,
        this.visible,
        this.email,
        this.version,
        this.language,
        this.imageauthorname,
        this.imageauthoremail,
        this.imageauthorurl,
        this.imagecaption,
        this.badgeurl});

  Badges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    usercreated = json['usercreated'];
    usermodified = json['usermodified'];
    issuername = json['issuername'];
    issuerurl = json['issuerurl'];
    issuercontact = json['issuercontact'];
    expiredate = json['expiredate'];
    expireperiod = json['expireperiod'];
    type = json['type'];
    courseid = json['courseid'];
    message = json['message'];
    messagesubject = json['messagesubject'];
    attachment = json['attachment'];
    notification = json['notification'];
    status = json['status'];
    issuedid = json['issuedid'];
    uniquehash = json['uniquehash'];
    dateissued = json['dateissued'];
    dateexpire = json['dateexpire'];
    visible = json['visible'];
    email = json['email'];
    version = json['version'];
    language = json['language'];
    imageauthorname = json['imageauthorname'];
    imageauthoremail = json['imageauthoremail'];
    imageauthorurl = json['imageauthorurl'];
    imagecaption = json['imagecaption'];
    badgeurl = json['badgeurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['timecreated'] = this.timecreated;
    data['timemodified'] = this.timemodified;
    data['usercreated'] = this.usercreated;
    data['usermodified'] = this.usermodified;
    data['issuername'] = this.issuername;
    data['issuerurl'] = this.issuerurl;
    data['issuercontact'] = this.issuercontact;
    data['expiredate'] = this.expiredate;
    data['expireperiod'] = this.expireperiod;
    data['type'] = this.type;
    data['courseid'] = this.courseid;
    data['message'] = this.message;
    data['messagesubject'] = this.messagesubject;
    data['attachment'] = this.attachment;
    data['notification'] = this.notification;
    data['status'] = this.status;
    data['issuedid'] = this.issuedid;
    data['uniquehash'] = this.uniquehash;
    data['dateissued'] = this.dateissued;
    data['dateexpire'] = this.dateexpire;
    data['visible'] = this.visible;
    data['email'] = this.email;
    data['version'] = this.version;
    data['language'] = this.language;
    data['imageauthorname'] = this.imageauthorname;
    data['imageauthoremail'] = this.imageauthoremail;
    data['imageauthorurl'] = this.imageauthorurl;
    data['imagecaption'] = this.imagecaption;
    data['badgeurl'] = this.badgeurl;
    return data;
  }
}