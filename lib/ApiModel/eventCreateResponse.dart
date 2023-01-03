class EventCreateResponse {
  List<Events>? events;

  EventCreateResponse({this.events});

  EventCreateResponse.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  int? id;
  String? name;
  String? description;
  int? format;
  int? courseid;
  int? groupid;
  int? userid;
  String? modulename;
  int? instance;
  String? eventtype;
  int? timestart;
  int? timeduration;
  int? visible;
  String? uuid;
  int? sequence;
  int? timemodified;
  int? subscriptionid;

  Events(
      {this.id,
        this.name,
        this.description,
        this.format,
        this.courseid,
        this.groupid,
        this.userid,
        this.modulename,
        this.instance,
        this.eventtype,
        this.timestart,
        this.timeduration,
        this.visible,
        this.uuid,
        this.sequence,
        this.timemodified,
        this.subscriptionid});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    format = json['format'];
    courseid = json['courseid'];
    groupid = json['groupid'];
    userid = json['userid'];
    modulename = json['modulename'];
    instance = json['instance'];
    eventtype = json['eventtype'];
    timestart = json['timestart'];
    timeduration = json['timeduration'];
    visible = json['visible'];
    uuid = json['uuid'];
    sequence = json['sequence'];
    timemodified = json['timemodified'];
    subscriptionid = json['subscriptionid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['format'] = this.format;
    data['courseid'] = this.courseid;
    data['groupid'] = this.groupid;
    data['userid'] = this.userid;
    data['modulename'] = this.modulename;
    data['instance'] = this.instance;
    data['eventtype'] = this.eventtype;
    data['timestart'] = this.timestart;
    data['timeduration'] = this.timeduration;
    data['visible'] = this.visible;
    data['uuid'] = this.uuid;
    data['sequence'] = this.sequence;
    data['timemodified'] = this.timemodified;
    data['subscriptionid'] = this.subscriptionid;
    return data;
  }
}