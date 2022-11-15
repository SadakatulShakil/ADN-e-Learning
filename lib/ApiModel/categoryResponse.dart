class Categories {
  int? id;
  String? name;
  String? description;
  int? descriptionformat;
  int? parent;
  int? sortorder;
  int? coursecount;
  int? depth;
  String? path;

  Categories(
      {this.id,
        this.name,
        this.description,
        this.descriptionformat,
        this.parent,
        this.sortorder,
        this.coursecount,
        this.depth,
        this.path});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    descriptionformat = json['descriptionformat'];
    parent = json['parent'];
    sortorder = json['sortorder'];
    coursecount = json['coursecount'];
    depth = json['depth'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['descriptionformat'] = this.descriptionformat;
    data['parent'] = this.parent;
    data['sortorder'] = this.sortorder;
    data['coursecount'] = this.coursecount;
    data['depth'] = this.depth;
    data['path'] = this.path;
    return data;
  }
}