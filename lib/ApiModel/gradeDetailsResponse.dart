class GradeDetailsResponse {
  List<Usergrades>? usergrades;

  GradeDetailsResponse({this.usergrades});

  GradeDetailsResponse.fromJson(Map<String, dynamic> json) {
    if (json['usergrades'] != null) {
      usergrades = <Usergrades>[];
      json['usergrades'].forEach((v) {
        usergrades!.add(new Usergrades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.usergrades != null) {
      data['usergrades'] = this.usergrades!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Usergrades {
  int? courseid;
  String? courseidnumber;
  int? userid;
  String? userfullname;
  String? useridnumber;
  int? maxdepth;
  List<Gradeitems>? gradeitems;

  Usergrades(
      {this.courseid,
        this.courseidnumber,
        this.userid,
        this.userfullname,
        this.useridnumber,
        this.maxdepth,
        this.gradeitems});

  Usergrades.fromJson(Map<String, dynamic> json) {
    courseid = json['courseid'];
    courseidnumber = json['courseidnumber'];
    userid = json['userid'];
    userfullname = json['userfullname'];
    useridnumber = json['useridnumber'];
    maxdepth = json['maxdepth'];
    if (json['gradeitems'] != null) {
      gradeitems = <Gradeitems>[];
      json['gradeitems'].forEach((v) {
        gradeitems!.add(new Gradeitems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseid'] = this.courseid;
    data['courseidnumber'] = this.courseidnumber;
    data['userid'] = this.userid;
    data['userfullname'] = this.userfullname;
    data['useridnumber'] = this.useridnumber;
    data['maxdepth'] = this.maxdepth;
    if (this.gradeitems != null) {
      data['gradeitems'] = this.gradeitems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gradeitems {
  int? id;
  String? itemname;
  String? itemtype;
  String? itemmodule;
  int? iteminstance;
  int? itemnumber;
  String? idnumber;
  int? categoryid;
  int? outcomeid;
  int? scaleid;
  int? locked;
  int? cmid;
  dynamic weightraw;
  String? weightformatted;
  dynamic graderaw;
  int? gradedatesubmitted;
  int? gradedategraded;
  bool? gradehiddenbydate;
  bool? gradeneedsupdate;
  bool? gradeishidden;
  bool? gradeislocked;
  bool? gradeisoverridden;
  String? gradeformatted;
  int? grademin;
  int? grademax;
  String? rangeformatted;
  String? percentageformatted;
  String? feedback;
  int? feedbackformat;

  Gradeitems(
      {this.id,
        this.itemname,
        this.itemtype,
        this.itemmodule,
        this.iteminstance,
        this.itemnumber,
        this.idnumber,
        this.categoryid,
        this.outcomeid,
        this.scaleid,
        this.locked,
        this.cmid,
        this.weightraw,
        this.weightformatted,
        this.graderaw,
        this.gradedatesubmitted,
        this.gradedategraded,
        this.gradehiddenbydate,
        this.gradeneedsupdate,
        this.gradeishidden,
        this.gradeislocked,
        this.gradeisoverridden,
        this.gradeformatted,
        this.grademin,
        this.grademax,
        this.rangeformatted,
        this.percentageformatted,
        this.feedback,
        this.feedbackformat});

  Gradeitems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemname = json['itemname'];
    itemtype = json['itemtype'];
    itemmodule = json['itemmodule'];
    iteminstance = json['iteminstance'];
    itemnumber = json['itemnumber'];
    idnumber = json['idnumber'];
    categoryid = json['categoryid'];
    outcomeid = json['outcomeid'];
    scaleid = json['scaleid'];
    locked = json['locked'];
    cmid = json['cmid'];
    weightraw = json['weightraw'];
    weightformatted = json['weightformatted'];
    graderaw = json['graderaw'];
    gradedatesubmitted = json['gradedatesubmitted'];
    gradedategraded = json['gradedategraded'];
    gradehiddenbydate = json['gradehiddenbydate'];
    gradeneedsupdate = json['gradeneedsupdate'];
    gradeishidden = json['gradeishidden'];
    gradeislocked = json['gradeislocked'];
    gradeisoverridden = json['gradeisoverridden'];
    gradeformatted = json['gradeformatted'];
    grademin = json['grademin'];
    grademax = json['grademax'];
    rangeformatted = json['rangeformatted'];
    percentageformatted = json['percentageformatted'];
    feedback = json['feedback'];
    feedbackformat = json['feedbackformat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemname'] = this.itemname;
    data['itemtype'] = this.itemtype;
    data['itemmodule'] = this.itemmodule;
    data['iteminstance'] = this.iteminstance;
    data['itemnumber'] = this.itemnumber;
    data['idnumber'] = this.idnumber;
    data['categoryid'] = this.categoryid;
    data['outcomeid'] = this.outcomeid;
    data['scaleid'] = this.scaleid;
    data['locked'] = this.locked;
    data['cmid'] = this.cmid;
    data['weightraw'] = this.weightraw;
    data['weightformatted'] = this.weightformatted;
    data['graderaw'] = this.graderaw;
    data['gradedatesubmitted'] = this.gradedatesubmitted;
    data['gradedategraded'] = this.gradedategraded;
    data['gradehiddenbydate'] = this.gradehiddenbydate;
    data['gradeneedsupdate'] = this.gradeneedsupdate;
    data['gradeishidden'] = this.gradeishidden;
    data['gradeislocked'] = this.gradeislocked;
    data['gradeisoverridden'] = this.gradeisoverridden;
    data['gradeformatted'] = this.gradeformatted;
    data['grademin'] = this.grademin;
    data['grademax'] = this.grademax;
    data['rangeformatted'] = this.rangeformatted;
    data['percentageformatted'] = this.percentageformatted;
    data['feedback'] = this.feedback;
    data['feedbackformat'] = this.feedbackformat;
    return data;
  }
}