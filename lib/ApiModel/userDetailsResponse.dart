class UserDetailsReponse {
  String? sitename;
  String? username;
  String? firstname;
  String? lastname;
  String? fullname;
  String? lang;
  int? userid;
  String? siteurl;
  String? userpictureurl;
  List<Functions>? functions;
  int? downloadfiles;
  int? uploadfiles;
  String? release;
  String? version;
  String? mobilecssurl;
  List<Advancedfeatures>? advancedfeatures;
  bool? usercanmanageownfiles;
  int? userquota;
  int? usermaxuploadfilesize;
  int? userhomepage;
  String? userprivateaccesskey;
  int? siteid;
  String? sitecalendartype;
  String? usercalendartype;
  bool? userissiteadmin;
  String? theme;

  UserDetailsReponse(
      {this.sitename,
        this.username,
        this.firstname,
        this.lastname,
        this.fullname,
        this.lang,
        this.userid,
        this.siteurl,
        this.userpictureurl,
        this.functions,
        this.downloadfiles,
        this.uploadfiles,
        this.release,
        this.version,
        this.mobilecssurl,
        this.advancedfeatures,
        this.usercanmanageownfiles,
        this.userquota,
        this.usermaxuploadfilesize,
        this.userhomepage,
        this.userprivateaccesskey,
        this.siteid,
        this.sitecalendartype,
        this.usercalendartype,
        this.userissiteadmin,
        this.theme});

  UserDetailsReponse.fromJson(Map<String, dynamic> json) {
    sitename = json['sitename'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    fullname = json['fullname'];
    lang = json['lang'];
    userid = json['userid'];
    siteurl = json['siteurl'];
    userpictureurl = json['userpictureurl'];
    if (json['functions'] != null) {
      functions = <Functions>[];
      json['functions'].forEach((v) {
        functions!.add(new Functions.fromJson(v));
      });
    }
    downloadfiles = json['downloadfiles'];
    uploadfiles = json['uploadfiles'];
    release = json['release'];
    version = json['version'];
    mobilecssurl = json['mobilecssurl'];
    if (json['advancedfeatures'] != null) {
      advancedfeatures = <Advancedfeatures>[];
      json['advancedfeatures'].forEach((v) {
        advancedfeatures!.add(new Advancedfeatures.fromJson(v));
      });
    }
    usercanmanageownfiles = json['usercanmanageownfiles'];
    userquota = json['userquota'];
    usermaxuploadfilesize = json['usermaxuploadfilesize'];
    userhomepage = json['userhomepage'];
    userprivateaccesskey = json['userprivateaccesskey'];
    siteid = json['siteid'];
    sitecalendartype = json['sitecalendartype'];
    usercalendartype = json['usercalendartype'];
    userissiteadmin = json['userissiteadmin'];
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sitename'] = this.sitename;
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['fullname'] = this.fullname;
    data['lang'] = this.lang;
    data['userid'] = this.userid;
    data['siteurl'] = this.siteurl;
    data['userpictureurl'] = this.userpictureurl;
    if (this.functions != null) {
      data['functions'] = this.functions!.map((v) => v.toJson()).toList();
    }
    data['downloadfiles'] = this.downloadfiles;
    data['uploadfiles'] = this.uploadfiles;
    data['release'] = this.release;
    data['version'] = this.version;
    data['mobilecssurl'] = this.mobilecssurl;
    if (this.advancedfeatures != null) {
      data['advancedfeatures'] =
          this.advancedfeatures!.map((v) => v.toJson()).toList();
    }
    data['usercanmanageownfiles'] = this.usercanmanageownfiles;
    data['userquota'] = this.userquota;
    data['usermaxuploadfilesize'] = this.usermaxuploadfilesize;
    data['userhomepage'] = this.userhomepage;
    data['userprivateaccesskey'] = this.userprivateaccesskey;
    data['siteid'] = this.siteid;
    data['sitecalendartype'] = this.sitecalendartype;
    data['usercalendartype'] = this.usercalendartype;
    data['userissiteadmin'] = this.userissiteadmin;
    data['theme'] = this.theme;
    return data;
  }
}

class Functions {
  String? name;
  String? version;

  Functions({this.name, this.version});

  Functions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['version'] = this.version;
    return data;
  }
}

class Advancedfeatures {
  String? name;
  int? value;

  Advancedfeatures({this.name, this.value});

  Advancedfeatures.fromJson(Map<String, dynamic> json) {
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