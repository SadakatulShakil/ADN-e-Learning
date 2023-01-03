class ViewNotificationResponse {
  int? notificationid;

  ViewNotificationResponse({this.notificationid});

  ViewNotificationResponse.fromJson(Map<String, dynamic> json) {
    notificationid = json['notificationid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationid'] = this.notificationid;
    return data;
  }
}