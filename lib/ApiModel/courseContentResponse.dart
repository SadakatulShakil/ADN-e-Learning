class CourseContent {
  List<Courses>? courses;

  CourseContent({this.courses});

  CourseContent.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? id;
  String? fullname;
  String? displayname;
  String? shortname;
  int? categoryid;
  String? categoryname;
  int? sortorder;
  String? summary;
  int? summaryformat;
  List<Overviewfiles>? overviewfiles;
  bool? showactivitydates;
  bool? showcompletionconditions;
  List<Contacts>? contacts;
  List<String>? enrollmentmethods;
  String? format;
  int? showgrades;
  int? newsitems;
  int? startdate;
  int? enddate;
  int? maxbytes;
  int? showreports;
  int? visible;
  int? groupmode;
  int? groupmodeforce;
  int? defaultgroupingid;
  int? enablecompletion;
  int? completionnotify;
  String? lang;
  String? theme;
  int? marker;
  List<Filters>? filters;
  List<Courseformatoptions>? courseformatoptions;

  Courses(
      {this.id,
        this.fullname,
        this.displayname,
        this.shortname,
        this.categoryid,
        this.categoryname,
        this.sortorder,
        this.summary,
        this.summaryformat,
        this.overviewfiles,
        this.showactivitydates,
        this.showcompletionconditions,
        this.contacts,
        this.enrollmentmethods,
        this.format,
        this.showgrades,
        this.newsitems,
        this.startdate,
        this.enddate,
        this.maxbytes,
        this.showreports,
        this.visible,
        this.groupmode,
        this.groupmodeforce,
        this.defaultgroupingid,
        this.enablecompletion,
        this.completionnotify,
        this.lang,
        this.theme,
        this.marker,
        this.filters,
        this.courseformatoptions});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    displayname = json['displayname'];
    shortname = json['shortname'];
    categoryid = json['categoryid'];
    categoryname = json['categoryname'];
    sortorder = json['sortorder'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    if (json['overviewfiles'] != null) {
      overviewfiles = <Overviewfiles>[];
      json['overviewfiles'].forEach((v) {
        overviewfiles!.add(new Overviewfiles.fromJson(v));
      });
    }
    showactivitydates = json['showactivitydates'];
    showcompletionconditions = json['showcompletionconditions'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
    enrollmentmethods = json['enrollmentmethods'].cast<String>();
    format = json['format'];
    showgrades = json['showgrades'];
    newsitems = json['newsitems'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    maxbytes = json['maxbytes'];
    showreports = json['showreports'];
    visible = json['visible'];
    groupmode = json['groupmode'];
    groupmodeforce = json['groupmodeforce'];
    defaultgroupingid = json['defaultgroupingid'];
    enablecompletion = json['enablecompletion'];
    completionnotify = json['completionnotify'];
    lang = json['lang'];
    theme = json['theme'];
    marker = json['marker'];
    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) {
        filters!.add(new Filters.fromJson(v));
      });
    }
    if (json['courseformatoptions'] != null) {
      courseformatoptions = <Courseformatoptions>[];
      json['courseformatoptions'].forEach((v) {
        courseformatoptions!.add(new Courseformatoptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['displayname'] = this.displayname;
    data['shortname'] = this.shortname;
    data['categoryid'] = this.categoryid;
    data['categoryname'] = this.categoryname;
    data['sortorder'] = this.sortorder;
    data['summary'] = this.summary;
    data['summaryformat'] = this.summaryformat;
    if (this.overviewfiles != null) {
      data['overviewfiles'] =
          this.overviewfiles!.map((v) => v.toJson()).toList();
    }
    data['showactivitydates'] = this.showactivitydates;
    data['showcompletionconditions'] = this.showcompletionconditions;
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    data['enrollmentmethods'] = this.enrollmentmethods;
    data['format'] = this.format;
    data['showgrades'] = this.showgrades;
    data['newsitems'] = this.newsitems;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['maxbytes'] = this.maxbytes;
    data['showreports'] = this.showreports;
    data['visible'] = this.visible;
    data['groupmode'] = this.groupmode;
    data['groupmodeforce'] = this.groupmodeforce;
    data['defaultgroupingid'] = this.defaultgroupingid;
    data['enablecompletion'] = this.enablecompletion;
    data['completionnotify'] = this.completionnotify;
    data['lang'] = this.lang;
    data['theme'] = this.theme;
    data['marker'] = this.marker;
    if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }
    if (this.courseformatoptions != null) {
      data['courseformatoptions'] =
          this.courseformatoptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Overviewfiles {
  String? filename;
  String? filepath;
  int? filesize;
  String? fileurl;
  int? timemodified;
  String? mimetype;

  Overviewfiles(
      {this.filename,
        this.filepath,
        this.filesize,
        this.fileurl,
        this.timemodified,
        this.mimetype});

  Overviewfiles.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    filepath = json['filepath'];
    filesize = json['filesize'];
    fileurl = json['fileurl'];
    timemodified = json['timemodified'];
    mimetype = json['mimetype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['filepath'] = this.filepath;
    data['filesize'] = this.filesize;
    data['fileurl'] = this.fileurl;
    data['timemodified'] = this.timemodified;
    data['mimetype'] = this.mimetype;
    return data;
  }
}

class Contacts {
  int? id;
  String? fullname;

  Contacts({this.id, this.fullname});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    return data;
  }
}

class Filters {
  String? filter;
  int? localstate;
  int? inheritedstate;

  Filters({this.filter, this.localstate, this.inheritedstate});

  Filters.fromJson(Map<String, dynamic> json) {
    filter = json['filter'];
    localstate = json['localstate'];
    inheritedstate = json['inheritedstate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter'] = this.filter;
    data['localstate'] = this.localstate;
    data['inheritedstate'] = this.inheritedstate;
    return data;
  }
}

class Courseformatoptions {
  String? name;
  int? value;

  Courseformatoptions({this.name, this.value});

  Courseformatoptions.fromJson(Map<String, dynamic> json) {
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