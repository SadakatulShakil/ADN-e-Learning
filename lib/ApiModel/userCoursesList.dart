class UserCoursesList {
  int? id;
  String? shortname;
  String? fullname;
  String? displayname;
  int? enrolledusercount;
  String? idnumber;
  int? visible;
  String? summary;
  int? summaryformat;
  String? format;
  bool? showgrades;
  String? lang;
  bool? enablecompletion;
  bool? completionhascriteria;
  bool? completionusertracked;
  int? category;
  dynamic progress;
  bool? completed;
  int? startdate;
  int? enddate;
  int? marker;
  int? lastaccess;
  bool? isfavourite;
  bool? hidden;
  List<Overviewfiles>? overviewfiles;
  bool? showactivitydates;
  bool? showcompletionconditions;

  UserCoursesList(
      {this.id,
        this.shortname,
        this.fullname,
        this.displayname,
        this.enrolledusercount,
        this.idnumber,
        this.visible,
        this.summary,
        this.summaryformat,
        this.format,
        this.showgrades,
        this.lang,
        this.enablecompletion,
        this.completionhascriteria,
        this.completionusertracked,
        this.category,
        this.progress,
        this.completed,
        this.startdate,
        this.enddate,
        this.marker,
        this.lastaccess,
        this.isfavourite,
        this.hidden,
        this.overviewfiles,
        this.showactivitydates,
        this.showcompletionconditions});

  UserCoursesList.fromJson(Map<String, dynamic> json) {
    print("hagu-------------------------"+json.toString());
    id = json['id'];
    shortname = json['shortname'];
    fullname = json['fullname'];
    displayname = json['displayname'];
    enrolledusercount = json['enrolledusercount'];
    idnumber = json['idnumber'];
    visible = json['visible'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    format = json['format'];
    showgrades = json['showgrades'];
    lang = json['lang'];
    enablecompletion = json['enablecompletion'];
    completionhascriteria = json['completionhascriteria'];
    completionusertracked = json['completionusertracked'];
    category = json['category'];
    progress = json['progress'];
    completed = json['completed'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    marker = json['marker'];
    lastaccess = json['lastaccess'];
    isfavourite = json['isfavourite'];
    hidden = json['hidden'];
    if (json['overviewfiles'] != null) {
      overviewfiles = <Overviewfiles>[];
      json['overviewfiles'].forEach((v) {
        overviewfiles!.add(new Overviewfiles.fromJson(v));
      });
    }
    showactivitydates = json['showactivitydates'];
    showcompletionconditions = json['showcompletionconditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shortname'] = this.shortname;
    data['fullname'] = this.fullname;
    data['displayname'] = this.displayname;
    data['enrolledusercount'] = this.enrolledusercount;
    data['idnumber'] = this.idnumber;
    data['visible'] = this.visible;
    data['summary'] = this.summary;
    data['summaryformat'] = this.summaryformat;
    data['format'] = this.format;
    data['showgrades'] = this.showgrades;
    data['lang'] = this.lang;
    data['enablecompletion'] = this.enablecompletion;
    data['completionhascriteria'] = this.completionhascriteria;
    data['completionusertracked'] = this.completionusertracked;
    data['category'] = this.category;
    data['progress'] = this.progress;
    data['completed'] = this.completed;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['marker'] = this.marker;
    data['lastaccess'] = this.lastaccess;
    data['isfavourite'] = this.isfavourite;
    data['hidden'] = this.hidden;
    if (this.overviewfiles != null) {
      data['overviewfiles'] =
          this.overviewfiles!.map((v) => v.toJson()).toList();
    }
    data['showactivitydates'] = this.showactivitydates;
    data['showcompletionconditions'] = this.showcompletionconditions;
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