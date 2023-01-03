class CreateRequestResponse {
  Request? request;

  CreateRequestResponse({this.request});

  CreateRequestResponse.fromJson(Map<String, dynamic> json) {
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    return data;
  }
}

class Request {
  int? id;
  int? userid;
  int? requesteduserid;
  int? timecreated;

  Request({this.id, this.userid, this.requesteduserid, this.timecreated});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    requesteduserid = json['requesteduserid'];
    timecreated = json['timecreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['requesteduserid'] = this.requesteduserid;
    data['timecreated'] = this.timecreated;
    return data;
  }
}