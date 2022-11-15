class MonthlyCalendarEventsResponse {
  String? url;
  int? courseid;
  int? categoryid;
  String? filterSelector;
  List<Weeks>? weeks;

  MonthlyCalendarEventsResponse(
      {this.url,
        this.courseid,
        this.categoryid,
        this.filterSelector,
        this.weeks});

  MonthlyCalendarEventsResponse.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    courseid = json['courseid'];
    categoryid = json['categoryid'];
    filterSelector = json['filter_selector'];
    if (json['weeks'] != null) {
      weeks = <Weeks>[];
      json['weeks'].forEach((v) {
        weeks!.add(new Weeks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['courseid'] = this.courseid;
    data['categoryid'] = this.categoryid;
    data['filter_selector'] = this.filterSelector;
    if (this.weeks != null) {
      data['weeks'] = this.weeks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weeks {
  List<int>? prepadding;
  List<Days>? days;

  Weeks({this.prepadding, this.days});

  Weeks.fromJson(Map<String, dynamic> json) {
    prepadding = json['prepadding'].cast<int>();
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(new Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prepadding'] = this.prepadding;
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  int? seconds;
  int? minutes;
  int? hours;
  int? mday;
  int? wday;
  int? year;
  int? yday;
  bool? istoday;
  bool? isweekend;
  int? timestamp;
  int? neweventtimestamp;
  String? viewdaylink;
  String? viewdaylinktitle;
  List<Events>? events;
  bool? hasevents;
  List<String>? calendareventtypes;
  int? previousperiod;
  int? nextperiod;
  String? navigation;
  bool? haslastdayofevent;
  String? popovertitle;
  String? daytitle;

  Days(
      {this.seconds,
        this.minutes,
        this.hours,
        this.mday,
        this.wday,
        this.year,
        this.yday,
        this.istoday,
        this.isweekend,
        this.timestamp,
        this.neweventtimestamp,
        this.viewdaylink,
        this.viewdaylinktitle,
        this.events,
        this.hasevents,
        this.calendareventtypes,
        this.previousperiod,
        this.nextperiod,
        this.navigation,
        this.haslastdayofevent,
        this.popovertitle,
        this.daytitle});

  Days.fromJson(Map<String, dynamic> json) {
    seconds = json['seconds'];
    minutes = json['minutes'];
    hours = json['hours'];
    mday = json['mday'];
    wday = json['wday'];
    year = json['year'];
    yday = json['yday'];
    istoday = json['istoday'];
    isweekend = json['isweekend'];
    timestamp = json['timestamp'];
    neweventtimestamp = json['neweventtimestamp'];
    viewdaylink = json['viewdaylink'];
    viewdaylinktitle = json['viewdaylinktitle'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    hasevents = json['hasevents'];
    calendareventtypes = json['calendareventtypes'].cast<String>();
    previousperiod = json['previousperiod'];
    nextperiod = json['nextperiod'];
    navigation = json['navigation'];
    haslastdayofevent = json['haslastdayofevent'];
    popovertitle = json['popovertitle'];
    daytitle = json['daytitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seconds'] = this.seconds;
    data['minutes'] = this.minutes;
    data['hours'] = this.hours;
    data['mday'] = this.mday;
    data['wday'] = this.wday;
    data['year'] = this.year;
    data['yday'] = this.yday;
    data['istoday'] = this.istoday;
    data['isweekend'] = this.isweekend;
    data['timestamp'] = this.timestamp;
    data['neweventtimestamp'] = this.neweventtimestamp;
    data['viewdaylink'] = this.viewdaylink;
    data['viewdaylinktitle'] = this.viewdaylinktitle;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    data['hasevents'] = this.hasevents;
    data['calendareventtypes'] = this.calendareventtypes;
    data['previousperiod'] = this.previousperiod;
    data['nextperiod'] = this.nextperiod;
    data['navigation'] = this.navigation;
    data['haslastdayofevent'] = this.haslastdayofevent;
    data['popovertitle'] = this.popovertitle;
    data['daytitle'] = this.daytitle;
    return data;
  }
}

class Events {
  int? id;
  String? name;
  String? description;
  int? descriptionformat;
  String? location;
  int? categoryid;
  int? groupid;
  int? userid;
  int? repeatid;
  int? eventcount;
  String? component;
  String? modulename;
  int? instance;
  String? eventtype;
  int? timestart;
  int? timeduration;
  int? timesort;
  int? timeusermidnight;
  int? visible;
  int? timemodified;
  Icon? icon;
  Course? course;
  Subscription? subscription;
  bool? canedit;
  bool? candelete;
  String? deleteurl;
  String? editurl;
  String? viewurl;
  String? formattedtime;
  bool? isactionevent;
  bool? iscourseevent;
  bool? iscategoryevent;
  String? groupname;
  String? normalisedeventtype;
  String? normalisedeventtypetext;
  String? url;
  bool? islastday;
  String? popupname;
  bool? draggable;

  Events(
      {this.id,
        this.name,
        this.description,
        this.descriptionformat,
        this.location,
        this.categoryid,
        this.groupid,
        this.userid,
        this.repeatid,
        this.eventcount,
        this.component,
        this.modulename,
        this.instance,
        this.eventtype,
        this.timestart,
        this.timeduration,
        this.timesort,
        this.timeusermidnight,
        this.visible,
        this.timemodified,
        this.icon,
        this.course,
        this.subscription,
        this.canedit,
        this.candelete,
        this.deleteurl,
        this.editurl,
        this.viewurl,
        this.formattedtime,
        this.isactionevent,
        this.iscourseevent,
        this.iscategoryevent,
        this.groupname,
        this.normalisedeventtype,
        this.normalisedeventtypetext,
        this.url,
        this.islastday,
        this.popupname,
        this.draggable});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    descriptionformat = json['descriptionformat'];
    location = json['location'];
    categoryid = json['categoryid'];
    groupid = json['groupid'];
    userid = json['userid'];
    repeatid = json['repeatid'];
    eventcount = json['eventcount'];
    component = json['component'];
    modulename = json['modulename'];
    instance = json['instance'];
    eventtype = json['eventtype'];
    timestart = json['timestart'];
    timeduration = json['timeduration'];
    timesort = json['timesort'];
    timeusermidnight = json['timeusermidnight'];
    visible = json['visible'];
    timemodified = json['timemodified'];
    icon = json['icon'] != null ? new Icon.fromJson(json['icon']) : null;
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
    canedit = json['canedit'];
    candelete = json['candelete'];
    deleteurl = json['deleteurl'];
    editurl = json['editurl'];
    viewurl = json['viewurl'];
    formattedtime = json['formattedtime'];
    isactionevent = json['isactionevent'];
    iscourseevent = json['iscourseevent'];
    iscategoryevent = json['iscategoryevent'];
    groupname = json['groupname'];
    normalisedeventtype = json['normalisedeventtype'];
    normalisedeventtypetext = json['normalisedeventtypetext'];
    url = json['url'];
    islastday = json['islastday'];
    popupname = json['popupname'];
    draggable = json['draggable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['descriptionformat'] = this.descriptionformat;
    data['location'] = this.location;
    data['categoryid'] = this.categoryid;
    data['groupid'] = this.groupid;
    data['userid'] = this.userid;
    data['repeatid'] = this.repeatid;
    data['eventcount'] = this.eventcount;
    data['component'] = this.component;
    data['modulename'] = this.modulename;
    data['instance'] = this.instance;
    data['eventtype'] = this.eventtype;
    data['timestart'] = this.timestart;
    data['timeduration'] = this.timeduration;
    data['timesort'] = this.timesort;
    data['timeusermidnight'] = this.timeusermidnight;
    data['visible'] = this.visible;
    data['timemodified'] = this.timemodified;
    if (this.icon != null) {
      data['icon'] = this.icon!.toJson();
    }
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    data['canedit'] = this.canedit;
    data['candelete'] = this.candelete;
    data['deleteurl'] = this.deleteurl;
    data['editurl'] = this.editurl;
    data['viewurl'] = this.viewurl;
    data['formattedtime'] = this.formattedtime;
    data['isactionevent'] = this.isactionevent;
    data['iscourseevent'] = this.iscourseevent;
    data['iscategoryevent'] = this.iscategoryevent;
    data['groupname'] = this.groupname;
    data['normalisedeventtype'] = this.normalisedeventtype;
    data['normalisedeventtypetext'] = this.normalisedeventtypetext;
    data['url'] = this.url;
    data['islastday'] = this.islastday;
    data['popupname'] = this.popupname;
    data['draggable'] = this.draggable;
    return data;
  }
}

class Icon {
  String? key;
  String? component;
  String? alttext;

  Icon({this.key, this.component, this.alttext});

  Icon.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    component = json['component'];
    alttext = json['alttext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['component'] = this.component;
    data['alttext'] = this.alttext;
    return data;
  }
}

class Course {
  int? id;
  String? fullname;
  String? shortname;
  String? idnumber;
  String? summary;
  int? summaryformat;
  int? startdate;
  int? enddate;
  bool? visible;
  bool? showactivitydates;
  bool? showcompletionconditions;
  String? fullnamedisplay;
  String? viewurl;
  String? courseimage;
  int? progress;
  bool? hasprogress;
  bool? isfavourite;
  bool? hidden;
  bool? showshortname;
  String? coursecategory;

  Course(
      {this.id,
        this.fullname,
        this.shortname,
        this.idnumber,
        this.summary,
        this.summaryformat,
        this.startdate,
        this.enddate,
        this.visible,
        this.showactivitydates,
        this.showcompletionconditions,
        this.fullnamedisplay,
        this.viewurl,
        this.courseimage,
        this.progress,
        this.hasprogress,
        this.isfavourite,
        this.hidden,
        this.showshortname,
        this.coursecategory});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    shortname = json['shortname'];
    idnumber = json['idnumber'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    visible = json['visible'];
    showactivitydates = json['showactivitydates'];
    showcompletionconditions = json['showcompletionconditions'];
    fullnamedisplay = json['fullnamedisplay'];
    viewurl = json['viewurl'];
    courseimage = json['courseimage'];
    progress = json['progress'];
    hasprogress = json['hasprogress'];
    isfavourite = json['isfavourite'];
    hidden = json['hidden'];
    showshortname = json['showshortname'];
    coursecategory = json['coursecategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['shortname'] = this.shortname;
    data['idnumber'] = this.idnumber;
    data['summary'] = this.summary;
    data['summaryformat'] = this.summaryformat;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['visible'] = this.visible;
    data['showactivitydates'] = this.showactivitydates;
    data['showcompletionconditions'] = this.showcompletionconditions;
    data['fullnamedisplay'] = this.fullnamedisplay;
    data['viewurl'] = this.viewurl;
    data['courseimage'] = this.courseimage;
    data['progress'] = this.progress;
    data['hasprogress'] = this.hasprogress;
    data['isfavourite'] = this.isfavourite;
    data['hidden'] = this.hidden;
    data['showshortname'] = this.showshortname;
    data['coursecategory'] = this.coursecategory;
    return data;
  }
}

class Subscription {
  bool? displayeventsource;

  Subscription({this.displayeventsource});

  Subscription.fromJson(Map<String, dynamic> json) {
    displayeventsource = json['displayeventsource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayeventsource'] = this.displayeventsource;
    return data;
  }
}