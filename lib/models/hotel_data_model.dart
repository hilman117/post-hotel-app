class GeneralData {
  GeneralData({
    this.hotelName,
    this.hotelid,
    this.domain,
    this.hotelImage,
    this.location,
    this.createdAt,
    this.deptToStoreLF,
    this.departments,
    this.userGroup,
    this.telNumber,
    this.address,
    this.isChangePasswordAllow,
  });

  String? hotelName;
  String? hotelid;
  String? hotelImage;
  String? domain;
  String? address;
  String? telNumber;
  String? deptToStoreLF;
  bool? isChangePasswordAllow;
  DateTime? createdAt;
  List<String>? location;
  List<String>? userGroup;
  List<String>? departments;

  factory GeneralData.fromJson(Map<String, dynamic> json) => GeneralData(
        hotelName: json["hotelName"],
        telNumber: json["telNumber"],
        isChangePasswordAllow: json["isChangePasswordAllow"],
        hotelid: json["hotelid"],
        deptToStoreLF: json["deptToStoreLF"],
        domain: json["domain"],
        address: json["address"],
        createdAt: DateTime.parse(json["createdAt"]),
        hotelImage: json["hotelImage"],
        location: List<String>.from(json["location"].map((x) => x)),
        userGroup: List<String>.from(json["userGroup"].map((x) => x)),
        departments: List<String>.from(json["departments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "hotelName": hotelName,
        "telNumber": telNumber,
        "address": address,
        "isChangePasswordAllow": isChangePasswordAllow,
        "hotelid": hotelid,
        "hotelImage": hotelImage,
        "deptToStoreLF": deptToStoreLF,
        "domain": domain,
        "createdAt": createdAt!.toIso8601String(),
        "location":
            location == null ? [] : List<String>.from(location!.map((x) => x)),
        "userGroup": userGroup == null
            ? []
            : List<String>.from(userGroup!.map((x) => x)),
        "departments": departments == null
            ? []
            : List<String>.from(departments!.map((x) => x)),
      };
}
