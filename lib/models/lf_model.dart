class LfModel {
  LfModel(
      {this.image,
      this.receiver,
      this.description,
      this.nameItem,
      this.location,
      this.id,
      this.time,
      this.status,
      this.emailSender,
      this.founder,
      this.profileImageSender,
      this.positionSender});

  List<String>? image;
  String? receiver;
  String? description;
  String? nameItem;
  String? founder;
  String? emailSender;
  String? location;
  String? positionSender;
  String? id;
  String? profileImageSender;
  DateTime? time;
  String? status;

  factory LfModel.fromJson(Map<String, dynamic> json) => LfModel(
      image: List<String>.from(json["image"].map((x) => x)),
      profileImageSender: json["profileImageSender"],
      receiver: json["receiver"],
      description: json["description"],
      emailSender: json["emailSender"],
      location: json["location"],
      id: json["id"],
      positionSender: json["positionSender"],
      time: DateTime.parse(json["time"]),
      status: json["status"],
      founder: json['founder'],
      nameItem: json['nameItem']);

  Map<String, dynamic> toJson() => {
        "image":
            image == null ? null : List<dynamic>.from(image!.map((x) => x)),
        "profileImageSender": profileImageSender,
        "positionSender": positionSender,
        "receiver": receiver,
        "emailSender": emailSender,
        "description": description,
        "location": location,
        "id": id,
        "time": time!.toIso8601String(),
        "status": status,
        "founder": founder,
        "nameItem": nameItem,
      };
}
