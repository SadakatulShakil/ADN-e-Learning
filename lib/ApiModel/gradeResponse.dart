class GradeResponse {
  List<Grades>? grades;

  GradeResponse({this.grades});

  GradeResponse.fromJson(Map<String, dynamic> json) {
    if (json['grades'] != null) {
      grades = <Grades>[];
      json['grades'].forEach((v) {
        grades!.add(new Grades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.grades != null) {
      data['grades'] = this.grades!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grades {
  int? courseid;
  String? grade;
  String? rawgrade;

  Grades({this.courseid, this.grade, this.rawgrade});

  Grades.fromJson(Map<String, dynamic> json) {
    courseid = json['courseid'];
    grade = json['grade'];
    rawgrade = json['rawgrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseid'] = this.courseid;
    data['grade'] = this.grade;
    data['rawgrade'] = this.rawgrade;
    return data;
  }
}