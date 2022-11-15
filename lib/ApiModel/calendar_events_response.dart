class CalendarEventsResponse {
  List<Events>? events;
  int? defaulteventcontext;
  String? filterSelector;
  int? courseid;
  int? categoryid;
  bool? isloggedin;
  Date? date;

  CalendarEventsResponse(
      {this.events,
        this.defaulteventcontext,
        this.filterSelector,
        this.courseid,
        this.categoryid,
        this.isloggedin,
        this.date});

  CalendarEventsResponse.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    defaulteventcontext = json['defaulteventcontext'];
    filterSelector = json['filter_selector'];
    courseid = json['courseid'];
    categoryid = json['categoryid'];
    isloggedin = json['isloggedin'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    data['defaulteventcontext'] = this.defaulteventcontext;
    data['filter_selector'] = this.filterSelector;
    data['courseid'] = this.courseid;
    data['categoryid'] = this.categoryid;
    data['isloggedin'] = this.isloggedin;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
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

class Date {
  int? seconds;
  int? minutes;
  int? hours;
  int? mday;
  int? wday;
  int? mon;
  int? year;
  int? yday;
  String? weekday;
  String? month;
  int? timestamp;

  Date(
      {this.seconds,
        this.minutes,
        this.hours,
        this.mday,
        this.wday,
        this.mon,
        this.year,
        this.yday,
        this.weekday,
        this.month,
        this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
    seconds = json['seconds'];
    minutes = json['minutes'];
    hours = json['hours'];
    mday = json['mday'];
    wday = json['wday'];
    mon = json['mon'];
    year = json['year'];
    yday = json['yday'];
    weekday = json['weekday'];
    month = json['month'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seconds'] = this.seconds;
    data['minutes'] = this.minutes;
    data['hours'] = this.hours;
    data['mday'] = this.mday;
    data['wday'] = this.wday;
    data['mon'] = this.mon;
    data['year'] = this.year;
    data['yday'] = this.yday;
    data['weekday'] = this.weekday;
    data['month'] = this.month;
    data['timestamp'] = this.timestamp;
    return data;
  }
}