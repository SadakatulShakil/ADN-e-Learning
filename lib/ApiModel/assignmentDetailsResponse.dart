class AssignmentDetailsReponse {
  Lastattempt? lastattempt;
  Feedback? feedback;

  AssignmentDetailsReponse({this.lastattempt, this.feedback});

  AssignmentDetailsReponse.fromJson(Map<String, dynamic> json) {
    lastattempt = json['lastattempt'] != null
        ? new Lastattempt.fromJson(json['lastattempt'])
        : null;
    feedback = json['feedback'] != null
        ? new Feedback.fromJson(json['feedback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastattempt != null) {
      data['lastattempt'] = this.lastattempt!.toJson();
    }
    if (this.feedback != null) {
      data['feedback'] = this.feedback!.toJson();
    }
    return data;
  }
}

class Lastattempt {
  Submission? submission;
  bool? submissionsenabled;
  bool? locked;
  bool? graded;
  bool? canedit;
  bool? caneditowner;
  bool? cansubmit;
  bool? blindmarking;
  String? gradingstatus;
  List<int>? usergroups;

  Lastattempt(
      {this.submission,
        this.submissionsenabled,
        this.locked,
        this.graded,
        this.canedit,
        this.caneditowner,
        this.cansubmit,
        this.blindmarking,
        this.gradingstatus,
        this.usergroups});

  Lastattempt.fromJson(Map<String, dynamic> json) {
    submission = json['submission'] != null
        ? new Submission.fromJson(json['submission'])
        : null;
    submissionsenabled = json['submissionsenabled'];
    locked = json['locked'];
    graded = json['graded'];
    canedit = json['canedit'];
    caneditowner = json['caneditowner'];
    cansubmit = json['cansubmit'];
    blindmarking = json['blindmarking'];
    gradingstatus = json['gradingstatus'];
    usergroups = json['usergroups'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.submission != null) {
      data['submission'] = this.submission!.toJson();
    }
    data['submissionsenabled'] = this.submissionsenabled;
    data['locked'] = this.locked;
    data['graded'] = this.graded;
    data['canedit'] = this.canedit;
    data['caneditowner'] = this.caneditowner;
    data['cansubmit'] = this.cansubmit;
    data['blindmarking'] = this.blindmarking;
    data['gradingstatus'] = this.gradingstatus;
    data['usergroups'] = this.usergroups;
    return data;
  }
}

class Submission {
  int? id;
  int? userid;
  int? attemptnumber;
  int? timecreated;
  int? timemodified;
  String? status;
  int? groupid;
  int? assignment;
  int? latest;
  List<Plugins>? plugins;

  Submission(
      {this.id,
        this.userid,
        this.attemptnumber,
        this.timecreated,
        this.timemodified,
        this.status,
        this.groupid,
        this.assignment,
        this.latest,
        this.plugins});

  Submission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    attemptnumber = json['attemptnumber'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    status = json['status'];
    groupid = json['groupid'];
    assignment = json['assignment'];
    latest = json['latest'];
    if (json['plugins'] != null) {
      plugins = <Plugins>[];
      json['plugins'].forEach((v) {
        plugins!.add(new Plugins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['attemptnumber'] = this.attemptnumber;
    data['timecreated'] = this.timecreated;
    data['timemodified'] = this.timemodified;
    data['status'] = this.status;
    data['groupid'] = this.groupid;
    data['assignment'] = this.assignment;
    data['latest'] = this.latest;
    if (this.plugins != null) {
      data['plugins'] = this.plugins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plugins {
  String? type;
  String? name;
  List<Fileareas>? fileareas;
  List<Editorfields>? editorfields;

  Plugins({this.type, this.name, this.fileareas, this.editorfields});

  Plugins.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    if (json['fileareas'] != null) {
      fileareas = <Fileareas>[];
      json['fileareas'].forEach((v) {
        fileareas!.add(new Fileareas.fromJson(v));
      });
    }
    if (json['editorfields'] != null) {
      editorfields = <Editorfields>[];
      json['editorfields'].forEach((v) {
        editorfields!.add(new Editorfields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    if (this.fileareas != null) {
      data['fileareas'] = this.fileareas!.map((v) => v.toJson()).toList();
    }
    if (this.editorfields != null) {
      data['editorfields'] = this.editorfields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fileareas {
  String? area;
  List<Files>? files;

  Fileareas({this.area, this.files});

  Fileareas.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? filename;
  String? filepath;
  int? filesize;
  String? fileurl;
  int? timemodified;
  String? mimetype;
  bool? isexternalfile;

  Files(
      {this.filename,
        this.filepath,
        this.filesize,
        this.fileurl,
        this.timemodified,
        this.mimetype,
        this.isexternalfile});

  Files.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    filepath = json['filepath'];
    filesize = json['filesize'];
    fileurl = json['fileurl'];
    timemodified = json['timemodified'];
    mimetype = json['mimetype'];
    isexternalfile = json['isexternalfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['filepath'] = this.filepath;
    data['filesize'] = this.filesize;
    data['fileurl'] = this.fileurl;
    data['timemodified'] = this.timemodified;
    data['mimetype'] = this.mimetype;
    data['isexternalfile'] = this.isexternalfile;
    return data;
  }
}

class Editorfields {
  String? name;
  String? description;
  String? text;
  int? format;

  Editorfields({this.name, this.description, this.text, this.format});

  Editorfields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    text = json['text'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['text'] = this.text;
    data['format'] = this.format;
    return data;
  }
}

class Feedback {
  Grade? grade;
  String? gradefordisplay;
  int? gradeddate;
  List<Plugins>? plugins;

  Feedback({this.grade, this.gradefordisplay, this.gradeddate, this.plugins});

  Feedback.fromJson(Map<String, dynamic> json) {
    grade = json['grade'] != null ? new Grade.fromJson(json['grade']) : null;
    gradefordisplay = json['gradefordisplay'];
    gradeddate = json['gradeddate'];
    if (json['plugins'] != null) {
      plugins = <Plugins>[];
      json['plugins'].forEach((v) {
        plugins!.add(new Plugins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    data['gradefordisplay'] = this.gradefordisplay;
    data['gradeddate'] = this.gradeddate;
    if (this.plugins != null) {
      data['plugins'] = this.plugins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grade {
  int? id;
  int? assignment;
  int? userid;
  int? attemptnumber;
  int? timecreated;
  int? timemodified;
  int? grader;
  String? grade;

  Grade(
      {this.id,
        this.assignment,
        this.userid,
        this.attemptnumber,
        this.timecreated,
        this.timemodified,
        this.grader,
        this.grade});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignment = json['assignment'];
    userid = json['userid'];
    attemptnumber = json['attemptnumber'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    grader = json['grader'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assignment'] = this.assignment;
    data['userid'] = this.userid;
    data['attemptnumber'] = this.attemptnumber;
    data['timecreated'] = this.timecreated;
    data['timemodified'] = this.timemodified;
    data['grader'] = this.grader;
    data['grade'] = this.grade;
    return data;
  }
}