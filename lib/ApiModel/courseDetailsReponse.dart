class CourseContentResponse {
  int? id;
  String? name;
  int? visible;
  String? summary;
  int? summaryformat;
  int? section;
  int? hiddenbynumsections;
  bool? uservisible;
  List<Modules>? modules;

  CourseContentResponse(
      {this.id,
        this.name,
        this.visible,
        this.summary,
        this.summaryformat,
        this.section,
        this.hiddenbynumsections,
        this.uservisible,
        this.modules});

  CourseContentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    visible = json['visible'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    section = json['section'];
    hiddenbynumsections = json['hiddenbynumsections'];
    uservisible = json['uservisible'];
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(new Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['visible'] = this.visible;
    data['summary'] = this.summary;
    data['summaryformat'] = this.summaryformat;
    data['section'] = this.section;
    data['hiddenbynumsections'] = this.hiddenbynumsections;
    data['uservisible'] = this.uservisible;
    if (this.modules != null) {
      data['modules'] = this.modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  int? id;
  String? url;
  String? name;
  int? instance;
  int? contextid;
  int? visible;
  bool? uservisible;
  int? visibleoncoursepage;
  String? modicon;
  String? modname;
  String? modplural;
  int? indent;
  String? onclick;
  String? afterlink;
  String? customdata;
  bool? noviewlink;
  int? completion;
  List<Dates>? dates;
  List<Contents>? contents;
  Contentsinfo? contentsinfo;
  Completiondata? completiondata;

  Modules(
      {this.id,
        this.url,
        this.name,
        this.instance,
        this.contextid,
        this.visible,
        this.uservisible,
        this.visibleoncoursepage,
        this.modicon,
        this.modname,
        this.modplural,
        this.indent,
        this.onclick,
        this.afterlink,
        this.customdata,
        this.noviewlink,
        this.completion,
        this.dates,
        this.contents,
        this.contentsinfo,
        this.completiondata});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    instance = json['instance'];
    contextid = json['contextid'];
    visible = json['visible'];
    uservisible = json['uservisible'];
    visibleoncoursepage = json['visibleoncoursepage'];
    modicon = json['modicon'];
    modname = json['modname'];
    modplural = json['modplural'];
    indent = json['indent'];
    onclick = json['onclick'];
    afterlink = json['afterlink'];
    customdata = json['customdata'];
    noviewlink = json['noviewlink'];
    completion = json['completion'];
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(new Dates.fromJson(v));
      });
    }
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(new Contents.fromJson(v));
      });
    }
    contentsinfo = json['contentsinfo'] != null
        ? new Contentsinfo.fromJson(json['contentsinfo'])
        : null;
    completiondata = json['completiondata'] != null
        ? new Completiondata.fromJson(json['completiondata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['instance'] = this.instance;
    data['contextid'] = this.contextid;
    data['visible'] = this.visible;
    data['uservisible'] = this.uservisible;
    data['visibleoncoursepage'] = this.visibleoncoursepage;
    data['modicon'] = this.modicon;
    data['modname'] = this.modname;
    data['modplural'] = this.modplural;
    data['indent'] = this.indent;
    data['onclick'] = this.onclick;
    data['afterlink'] = this.afterlink;
    data['customdata'] = this.customdata;
    data['noviewlink'] = this.noviewlink;
    data['completion'] = this.completion;
    if (this.dates != null) {
      data['dates'] = this.dates!.map((v) => v.toJson()).toList();
    }
    if (this.contents != null) {
      data['contents'] = this.contents!.map((v) => v.toJson()).toList();
    }
    if (this.contentsinfo != null) {
      data['contentsinfo'] = this.contentsinfo!.toJson();
    }
    if (this.completiondata != null) {
      data['completiondata'] = this.completiondata!.toJson();
    }
    return data;
  }
}

class Dates {
  String? label;
  int? timestamp;

  Dates({this.label, this.timestamp});

  Dates.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Contents {
  String? type;
  String? filename;
  String? filepath;
  int? filesize;
  String? fileurl;
  int? timecreated;
  int? timemodified;
  int? sortorder;
  String? mimetype;
  bool? isexternalfile;
  int? userid;
  String? author;
  String? license;

  Contents(
      {this.type,
        this.filename,
        this.filepath,
        this.filesize,
        this.fileurl,
        this.timecreated,
        this.timemodified,
        this.sortorder,
        this.mimetype,
        this.isexternalfile,
        this.userid,
        this.author,
        this.license});

  Contents.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    filename = json['filename'];
    filepath = json['filepath'];
    filesize = json['filesize'];
    fileurl = json['fileurl'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    sortorder = json['sortorder'];
    mimetype = json['mimetype'];
    isexternalfile = json['isexternalfile'];
    userid = json['userid'];
    author = json['author'];
    license = json['license'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['filename'] = this.filename;
    data['filepath'] = this.filepath;
    data['filesize'] = this.filesize;
    data['fileurl'] = this.fileurl;
    data['timecreated'] = this.timecreated;
    data['timemodified'] = this.timemodified;
    data['sortorder'] = this.sortorder;
    data['mimetype'] = this.mimetype;
    data['isexternalfile'] = this.isexternalfile;
    data['userid'] = this.userid;
    data['author'] = this.author;
    data['license'] = this.license;
    return data;
  }
}

class Contentsinfo {
  int? filescount;
  int? filessize;
  int? lastmodified;
  List<String>? mimetypes;
  String? repositorytype;

  Contentsinfo(
      {this.filescount,
        this.filessize,
        this.lastmodified,
        this.mimetypes,
        this.repositorytype});

  Contentsinfo.fromJson(Map<String, dynamic> json) {
    filescount = json['filescount'];
    filessize = json['filessize'];
    lastmodified = json['lastmodified'];
    mimetypes = json['mimetypes'].cast<String>();
    repositorytype = json['repositorytype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filescount'] = this.filescount;
    data['filessize'] = this.filessize;
    data['lastmodified'] = this.lastmodified;
    data['mimetypes'] = this.mimetypes;
    data['repositorytype'] = this.repositorytype;
    return data;
  }
}

class Completiondata {
  int? state;
  int? timecompleted;
  String? overrideby;
  bool? valueused;
  bool? hascompletion;
  bool? isautomatic;
  bool? istrackeduser;
  bool? uservisible;

  Completiondata(
      {this.state,
        this.timecompleted,
        this.overrideby,
        this.valueused,
        this.hascompletion,
        this.isautomatic,
        this.istrackeduser,
        this.uservisible});

  Completiondata.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    timecompleted = json['timecompleted'];
    overrideby = json['overrideby'];
    valueused = json['valueused'];
    hascompletion = json['hascompletion'];
    isautomatic = json['isautomatic'];
    istrackeduser = json['istrackeduser'];
    uservisible = json['uservisible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['timecompleted'] = this.timecompleted;
    data['overrideby'] = this.overrideby;
    data['valueused'] = this.valueused;
    data['hascompletion'] = this.hascompletion;
    data['isautomatic'] = this.isautomatic;
    data['istrackeduser'] = this.istrackeduser;
    data['uservisible'] = this.uservisible;
    return data;
  }
}