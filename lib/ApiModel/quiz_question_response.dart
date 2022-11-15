class QuizQuestionResponse {
  Attempt? attempt;
  int? nextpage;
  List<Questions>? questions;

  QuizQuestionResponse({this.attempt, this.nextpage, this.questions});

  QuizQuestionResponse.fromJson(Map<String, dynamic> json) {
    attempt =
    json['attempt'] != null ? new Attempt.fromJson(json['attempt']) : null;
    nextpage = json['nextpage'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attempt != null) {
      data['attempt'] = this.attempt!.toJson();
    }
    data['nextpage'] = this.nextpage;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attempt {
  int? id;
  int? quiz;
  int? userid;
  int? attempt;
  int? uniqueid;
  String? layout;
  int? currentpage;
  int? preview;
  String? state;
  int? timestart;
  int? timefinish;
  int? timemodified;
  int? timemodifiedoffline;
  int? timecheckstate;

  Attempt(
      {this.id,
        this.quiz,
        this.userid,
        this.attempt,
        this.uniqueid,
        this.layout,
        this.currentpage,
        this.preview,
        this.state,
        this.timestart,
        this.timefinish,
        this.timemodified,
        this.timemodifiedoffline,
        this.timecheckstate});

  Attempt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quiz = json['quiz'];
    userid = json['userid'];
    attempt = json['attempt'];
    uniqueid = json['uniqueid'];
    layout = json['layout'];
    currentpage = json['currentpage'];
    preview = json['preview'];
    state = json['state'];
    timestart = json['timestart'];
    timefinish = json['timefinish'];
    timemodified = json['timemodified'];
    timemodifiedoffline = json['timemodifiedoffline'];
    timecheckstate = json['timecheckstate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quiz'] = this.quiz;
    data['userid'] = this.userid;
    data['attempt'] = this.attempt;
    data['uniqueid'] = this.uniqueid;
    data['layout'] = this.layout;
    data['currentpage'] = this.currentpage;
    data['preview'] = this.preview;
    data['state'] = this.state;
    data['timestart'] = this.timestart;
    data['timefinish'] = this.timefinish;
    data['timemodified'] = this.timemodified;
    data['timemodifiedoffline'] = this.timemodifiedoffline;
    data['timecheckstate'] = this.timecheckstate;
    return data;
  }
}

class Questions {
  int? slot;
  String? type;
  int? page;
  String? html;
  int? sequencecheck;
  int? lastactiontime;
  bool? hasautosavedstep;
  bool? flagged;
  int? number;
  String? status;
  bool? blockedbyprevious;
  int? maxmark;
  String? settings;

  Questions(
      {this.slot,
        this.type,
        this.page,
        this.html,
        this.sequencecheck,
        this.lastactiontime,
        this.hasautosavedstep,
        this.flagged,
        this.number,
        this.status,
        this.blockedbyprevious,
        this.maxmark,
        this.settings});

  Questions.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'];
    page = json['page'];
    html = json['html'];
    sequencecheck = json['sequencecheck'];
    lastactiontime = json['lastactiontime'];
    hasautosavedstep = json['hasautosavedstep'];
    flagged = json['flagged'];
    number = json['number'];
    status = json['status'];
    blockedbyprevious = json['blockedbyprevious'];
    maxmark = json['maxmark'];
    settings = json['settings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    data['type'] = this.type;
    data['page'] = this.page;
    data['html'] = this.html;
    data['sequencecheck'] = this.sequencecheck;
    data['lastactiontime'] = this.lastactiontime;
    data['hasautosavedstep'] = this.hasautosavedstep;
    data['flagged'] = this.flagged;
    data['number'] = this.number;
    data['status'] = this.status;
    data['blockedbyprevious'] = this.blockedbyprevious;
    data['maxmark'] = this.maxmark;
    data['settings'] = this.settings;
    return data;
  }
}