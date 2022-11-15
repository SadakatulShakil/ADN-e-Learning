class ContactRequestResponse {
  int? id;
  String? fullname;
  String? profileurl;
  String? profileimageurl;
  String? profileimageurlsmall;
  bool? isonline;
  bool? showonlinestatus;
  bool? isblocked;
  bool? iscontact;
  bool? isdeleted;

  ContactRequestResponse(
      {this.id,
        this.fullname,
        this.profileurl,
        this.profileimageurl,
        this.profileimageurlsmall,
        this.isonline,
        this.showonlinestatus,
        this.isblocked,
        this.iscontact,
        this.isdeleted});

  ContactRequestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    profileurl = json['profileurl'];
    profileimageurl = json['profileimageurl'];
    profileimageurlsmall = json['profileimageurlsmall'];
    isonline = json['isonline'];
    showonlinestatus = json['showonlinestatus'];
    isblocked = json['isblocked'];
    iscontact = json['iscontact'];
    isdeleted = json['isdeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['profileurl'] = this.profileurl;
    data['profileimageurl'] = this.profileimageurl;
    data['profileimageurlsmall'] = this.profileimageurlsmall;
    data['isonline'] = this.isonline;
    data['showonlinestatus'] = this.showonlinestatus;
    data['isblocked'] = this.isblocked;
    data['iscontact'] = this.iscontact;
    data['isdeleted'] = this.isdeleted;
    return data;
  }
}