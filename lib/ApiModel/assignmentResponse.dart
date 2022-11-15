class AssignmentResponse {
  List<Courses>? courses;
  List<Warnings>? warnings;

  AssignmentResponse({this.courses, this.warnings});

  AssignmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    if (json['warnings'] != null) {
      warnings = <Warnings>[];
      json['warnings'].forEach((v) {
        warnings!.add(new Warnings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    if (this.warnings != null) {
      data['warnings'] = this.warnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? id;
  String? fullname;
  String? shortname;
  int? timemodified;
  List<Assignments>? assignments;

  Courses(
      {this.id,
        this.fullname,
        this.shortname,
        this.timemodified,
        this.assignments});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    shortname = json['shortname'];
    timemodified = json['timemodified'];
    if (json['assignments'] != null) {
      assignments = <Assignments>[];
      json['assignments'].forEach((v) {
        assignments!.add(new Assignments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['shortname'] = this.shortname;
    data['timemodified'] = this.timemodified;
    if (this.assignments != null) {
      data['assignments'] = this.assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignments {
  int? id;
  int? cmid;
  int? course;
  String? name;
  int? nosubmissions;
  int? submissiondrafts;
  int? sendnotifications;
  int? sendlatenotifications;
  int? sendstudentnotifications;
  int? duedate;
  int? allowsubmissionsfromdate;
  int? grade;
  int? timemodified;
  int? completionsubmit;
  int? cutoffdate;
  int? gradingduedate;
  int? teamsubmission;
  int? requireallteammemberssubmit;
  int? teamsubmissiongroupingid;
  int? blindmarking;
  int? hidegrader;
  int? revealidentities;
  String? attemptreopenmethod;
  int? maxattempts;
  int? markingworkflow;
  int? markingallocation;
  int? requiresubmissionstatement;
  int? preventsubmissionnotingroup;
  List<Configs>? configs;
  String? intro;
  int? introformat;
  String? submissionstatement;
  int? submissionstatementformat;

  Assignments(
      {this.id,
        this.cmid,
        this.course,
        this.name,
        this.nosubmissions,
        this.submissiondrafts,
        this.sendnotifications,
        this.sendlatenotifications,
        this.sendstudentnotifications,
        this.duedate,
        this.allowsubmissionsfromdate,
        this.grade,
        this.timemodified,
        this.completionsubmit,
        this.cutoffdate,
        this.gradingduedate,
        this.teamsubmission,
        this.requireallteammemberssubmit,
        this.teamsubmissiongroupingid,
        this.blindmarking,
        this.hidegrader,
        this.revealidentities,
        this.attemptreopenmethod,
        this.maxattempts,
        this.markingworkflow,
        this.markingallocation,
        this.requiresubmissionstatement,
        this.preventsubmissionnotingroup,
        this.configs,
        this.intro,
        this.introformat,
        this.submissionstatement,
        this.submissionstatementformat});

  Assignments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cmid = json['cmid'];
    course = json['course'];
    name = json['name'];
    nosubmissions = json['nosubmissions'];
    submissiondrafts = json['submissiondrafts'];
    sendnotifications = json['sendnotifications'];
    sendlatenotifications = json['sendlatenotifications'];
    sendstudentnotifications = json['sendstudentnotifications'];
    duedate = json['duedate'];
    allowsubmissionsfromdate = json['allowsubmissionsfromdate'];
    grade = json['grade'];
    timemodified = json['timemodified'];
    completionsubmit = json['completionsubmit'];
    cutoffdate = json['cutoffdate'];
    gradingduedate = json['gradingduedate'];
    teamsubmission = json['teamsubmission'];
    requireallteammemberssubmit = json['requireallteammemberssubmit'];
    teamsubmissiongroupingid = json['teamsubmissiongroupingid'];
    blindmarking = json['blindmarking'];
    hidegrader = json['hidegrader'];
    revealidentities = json['revealidentities'];
    attemptreopenmethod = json['attemptreopenmethod'];
    maxattempts = json['maxattempts'];
    markingworkflow = json['markingworkflow'];
    markingallocation = json['markingallocation'];
    requiresubmissionstatement = json['requiresubmissionstatement'];
    preventsubmissionnotingroup = json['preventsubmissionnotingroup'];
    if (json['configs'] != null) {
      configs = <Configs>[];
      json['configs'].forEach((v) {
        configs!.add(new Configs.fromJson(v));
      });
    }
    intro = json['intro'];
    introformat = json['introformat'];
    submissionstatement = json['submissionstatement'];
    submissionstatementformat = json['submissionstatementformat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cmid'] = this.cmid;
    data['course'] = this.course;
    data['name'] = this.name;
    data['nosubmissions'] = this.nosubmissions;
    data['submissiondrafts'] = this.submissiondrafts;
    data['sendnotifications'] = this.sendnotifications;
    data['sendlatenotifications'] = this.sendlatenotifications;
    data['sendstudentnotifications'] = this.sendstudentnotifications;
    data['duedate'] = this.duedate;
    data['allowsubmissionsfromdate'] = this.allowsubmissionsfromdate;
    data['grade'] = this.grade;
    data['timemodified'] = this.timemodified;
    data['completionsubmit'] = this.completionsubmit;
    data['cutoffdate'] = this.cutoffdate;
    data['gradingduedate'] = this.gradingduedate;
    data['teamsubmission'] = this.teamsubmission;
    data['requireallteammemberssubmit'] = this.requireallteammemberssubmit;
    data['teamsubmissiongroupingid'] = this.teamsubmissiongroupingid;
    data['blindmarking'] = this.blindmarking;
    data['hidegrader'] = this.hidegrader;
    data['revealidentities'] = this.revealidentities;
    data['attemptreopenmethod'] = this.attemptreopenmethod;
    data['maxattempts'] = this.maxattempts;
    data['markingworkflow'] = this.markingworkflow;
    data['markingallocation'] = this.markingallocation;
    data['requiresubmissionstatement'] = this.requiresubmissionstatement;
    data['preventsubmissionnotingroup'] = this.preventsubmissionnotingroup;
    if (this.configs != null) {
      data['configs'] = this.configs!.map((v) => v.toJson()).toList();
    }
    data['intro'] = this.intro;
    data['introformat'] = this.introformat;
    data['submissionstatement'] = this.submissionstatement;
    data['submissionstatementformat'] = this.submissionstatementformat;
    return data;
  }
}

class Configs {
  String? plugin;
  String? subtype;
  String? name;
  String? value;

  Configs({this.plugin, this.subtype, this.name, this.value});

  Configs.fromJson(Map<String, dynamic> json) {
    plugin = json['plugin'];
    subtype = json['subtype'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plugin'] = this.plugin;
    data['subtype'] = this.subtype;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Warnings {
  String? item;
  int? itemid;
  String? warningcode;
  String? message;

  Warnings({this.item, this.itemid, this.warningcode, this.message});

  Warnings.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    itemid = json['itemid'];
    warningcode = json['warningcode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['itemid'] = this.itemid;
    data['warningcode'] = this.warningcode;
    data['message'] = this.message;
    return data;
  }
}