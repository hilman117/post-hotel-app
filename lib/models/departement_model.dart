class Departement {
  Departement({
    this.departement,
    this.departementIcon,
    this.title,
    this.allowGroup,
    this.adminToken,
    this.isActive,
    this.isLocationControl,
    this.isMandatoryDescription,
    this.color,
    this.totalRequest,
    this.retentionDay,
    this.receivingUser,
  });

  bool? isActive;
  bool? isLocationControl;
  bool? isMandatoryDescription;
  String? departement;
  String? departementIcon;
  List<String>? title;
  List<String>? allowGroup;
  List<Map<String, dynamic>>? receivingUser;
  String? adminToken;
  int? totalRequest;
  int? retentionDay;
  String? color;

  factory Departement.fromJson(Map<String, dynamic> json) => Departement(
        departement: json["departement"],
        color: json["color"],
        isActive: json["isActive"],
        isLocationControl: json["isLocationControl"],
        isMandatoryDescription: json["isMandatoryDescription"],
        totalRequest: json["totalRequest"],
        retentionDay: json["retentionDay"],
        departementIcon: json["departementIcon"],
        title: List<String>.from(json["title"].map((x) => x)),
        allowGroup: List<String>.from(json["allowGroup"].map((x) => x)),
        receivingUser: json["receivingUser"] != null
            ? List<Map<String, dynamic>>.from(
                json["receivingUser"].map((x) => Map<String, dynamic>.from(x)))
            : [],
        adminToken: json["adminToken"],
      );

  Map<String, dynamic> toJson() => {
        "departement": departement,
        "color": color,
        "isActive": isActive,
        "isLocationControl": isLocationControl,
        "isMandatoryDescription": isMandatoryDescription,
        "totalRequest": totalRequest,
        "retentionDay": retentionDay,
        "departementIcon": departementIcon,
        "title": title == null ? [] : List<dynamic>.from(title!.map((x) => x)),
        "receivingUser": receivingUser != null
            ? List<dynamic>.from(receivingUser!.map((x) => x))
            : [],
        "allowGroup": allowGroup == null
            ? []
            : List<dynamic>.from(allowGroup!.map((x) => x)),
        "adminToken": adminToken,
      };
}
