class QuizAccessInformation {
  bool? canattempt;
  bool? canmanage;
  bool? canpreview;
  bool? canreviewmyattempts;
  bool? canviewreports;
  List<String>? accessrules;
  List<String>? activerulenames;

  QuizAccessInformation(
      {this.canattempt,
        this.canmanage,
        this.canpreview,
        this.canreviewmyattempts,
        this.canviewreports,
        this.accessrules,
        this.activerulenames});

  QuizAccessInformation.fromJson(Map<String, dynamic> json) {
    canattempt = json['canattempt'];
    canmanage = json['canmanage'];
    canpreview = json['canpreview'];
    canreviewmyattempts = json['canreviewmyattempts'];
    canviewreports = json['canviewreports'];
    accessrules = json['accessrules'].cast<String>();
    activerulenames = json['activerulenames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canattempt'] = this.canattempt;
    data['canmanage'] = this.canmanage;
    data['canpreview'] = this.canpreview;
    data['canreviewmyattempts'] = this.canreviewmyattempts;
    data['canviewreports'] = this.canviewreports;
    data['accessrules'] = this.accessrules;
    data['activerulenames'] = this.activerulenames;
    return data;
  }
}