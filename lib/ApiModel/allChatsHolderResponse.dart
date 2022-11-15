class AllChatsHolderResponse {
  List<Conversations>? conversations;

  AllChatsHolderResponse({this.conversations});

  AllChatsHolderResponse.fromJson(Map<String, dynamic> json) {
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(new Conversations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conversations != null) {
      data['conversations'] =
          this.conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversations {
  int? id;
  String? name;
  String? subname;
  String? imageurl;
  int? type;
  int? membercount;
  bool? ismuted;
  bool? isfavourite;
  bool? isread;
  int? unreadcount;
  List<Members>? members;
  List<Messages>? messages;
  bool? candeletemessagesforallusers;

  Conversations(
      {this.id,
        this.name,
        this.subname,
        this.imageurl,
        this.type,
        this.membercount,
        this.ismuted,
        this.isfavourite,
        this.isread,
        this.unreadcount,
        this.members,
        this.messages,
        this.candeletemessagesforallusers});

  Conversations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subname = json['subname'];
    imageurl = json['imageurl'];
    type = json['type'];
    membercount = json['membercount'];
    ismuted = json['ismuted'];
    isfavourite = json['isfavourite'];
    isread = json['isread'];
    unreadcount = json['unreadcount'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    candeletemessagesforallusers = json['candeletemessagesforallusers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['subname'] = this.subname;
    data['imageurl'] = this.imageurl;
    data['type'] = this.type;
    data['membercount'] = this.membercount;
    data['ismuted'] = this.ismuted;
    data['isfavourite'] = this.isfavourite;
    data['isread'] = this.isread;
    data['unreadcount'] = this.unreadcount;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['candeletemessagesforallusers'] = this.candeletemessagesforallusers;
    return data;
  }
}

class Members {
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

  Members(
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

  Members.fromJson(Map<String, dynamic> json) {
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

class Messages {
  int? id;
  int? useridfrom;
  String? text;
  int? timecreated;

  Messages({this.id, this.useridfrom, this.text, this.timecreated});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    useridfrom = json['useridfrom'];
    text = json['text'];
    timecreated = json['timecreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['useridfrom'] = this.useridfrom;
    data['text'] = this.text;
    data['timecreated'] = this.timecreated;
    return data;
  }
}