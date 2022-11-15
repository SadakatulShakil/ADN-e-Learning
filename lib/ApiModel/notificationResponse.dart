class NotificationResponse {
  List<Messages>? messages;

  NotificationResponse({this.messages});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  int? useridfrom;
  int? useridto;
  String? subject;
  String? text;
  String? fullmessage;
  int? fullmessageformat;
  String? fullmessagehtml;
  String? smallmessage;
  int? notification;
  String? contexturl;
  String? contexturlname;
  int? timecreated;
  String? usertofullname;
  String? userfromfullname;
  String? component;
  String? eventtype;
  String? customdata;

  Messages(
      {this.id,
        this.useridfrom,
        this.useridto,
        this.subject,
        this.text,
        this.fullmessage,
        this.fullmessageformat,
        this.fullmessagehtml,
        this.smallmessage,
        this.notification,
        this.contexturl,
        this.contexturlname,
        this.timecreated,
        this.usertofullname,
        this.userfromfullname,
        this.component,
        this.eventtype,
        this.customdata});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    useridfrom = json['useridfrom'];
    useridto = json['useridto'];
    subject = json['subject'];
    text = json['text'];
    fullmessage = json['fullmessage'];
    fullmessageformat = json['fullmessageformat'];
    fullmessagehtml = json['fullmessagehtml'];
    smallmessage = json['smallmessage'];
    notification = json['notification'];
    contexturl = json['contexturl'];
    contexturlname = json['contexturlname'];
    timecreated = json['timecreated'];
    usertofullname = json['usertofullname'];
    userfromfullname = json['userfromfullname'];
    component = json['component'];
    eventtype = json['eventtype'];
    customdata = json['customdata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['useridfrom'] = this.useridfrom;
    data['useridto'] = this.useridto;
    data['subject'] = this.subject;
    data['text'] = this.text;
    data['fullmessage'] = this.fullmessage;
    data['fullmessageformat'] = this.fullmessageformat;
    data['fullmessagehtml'] = this.fullmessagehtml;
    data['smallmessage'] = this.smallmessage;
    data['notification'] = this.notification;
    data['contexturl'] = this.contexturl;
    data['contexturlname'] = this.contexturlname;
    data['timecreated'] = this.timecreated;
    data['usertofullname'] = this.usertofullname;
    data['userfromfullname'] = this.userfromfullname;
    data['component'] = this.component;
    data['eventtype'] = this.eventtype;
    data['customdata'] = this.customdata;
    return data;
  }
}