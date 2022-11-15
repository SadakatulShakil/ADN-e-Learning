class RecentCoursesList {
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
  int? timeaccess;
  bool? showshortname;
  String? coursecategory;

  RecentCoursesList(
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
        this.timeaccess,
        this.showshortname,
        this.coursecategory});

  RecentCoursesList.fromJson(Map<String, dynamic> json) {
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
    timeaccess = json['timeaccess'];
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
    data['timeaccess'] = this.timeaccess;
    data['showshortname'] = this.showshortname;
    data['coursecategory'] = this.coursecategory;
    return data;
  }
}