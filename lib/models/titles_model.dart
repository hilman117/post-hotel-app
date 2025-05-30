class TitlesModel {
  TitlesModel({this.title, this.family, this.iconDepartement});

  String? title;
  String? family;
  String? iconDepartement;

  factory TitlesModel.fromJson(Map<String, dynamic> json) => TitlesModel(
        title: json["title"],
        family: json["family"],
        iconDepartement: json["iconDepartement"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "iconDepartement": iconDepartement,
        "family": family,
      };
}
