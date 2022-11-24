class SearchUsersResponse {
  int? id;
  String? fullname;
  String? profileimageurl;
  String? profileimageurlsmall;

  SearchUsersResponse(
      {this.id,
        this.fullname,
        this.profileimageurl,
        this.profileimageurlsmall});

  SearchUsersResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    profileimageurl = json['profileimageurl'];
    profileimageurlsmall = json['profileimageurlsmall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['profileimageurl'] = this.profileimageurl;
    data['profileimageurlsmall'] = this.profileimageurlsmall;
    return data;
  }
}