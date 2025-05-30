import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  TaskModel(
      {this.receiver,
      this.description,
      this.title,
      this.setDate,
      this.setTime,
      this.sender,
      this.comment,
      this.assigned,
      this.image,
      this.location,
      this.id,
      this.time,
      this.closeTime,
      this.status,
      this.sendTo,
      this.isFading,
      this.emailSender,
      this.profileImageSender,
      this.positionSender,
      this.resolusi,
      this.iconDepartement,
      this.typeReport,
      this.isValueable,
      this.subscriberToken,
      this.isPriority,
      this.registeredTask,
      this.from});

  String? receiver;
  String? description;
  String? iconDepartement;
  String? title;
  String? setDate;
  String? setTime;
  String? sender;
  String? emailSender;
  String? profileImageSender;
  String? positionSender;
  List<dynamic>? comment;
  List<String>? assigned;
  List<String>? registeredTask;
  List<String>? subscriberToken;
  List<dynamic>? image;
  String? location;
  String? id;
  Timestamp? time;
  String? closeTime;
  String? status;
  bool? isFading;
  String? sendTo;
  String? from;
  bool? isPriority;
  String? typeReport;
  String? resolusi;
  bool? isValueable;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        receiver: json["receiver"],
        isPriority: json["isPriority"] ?? false,
        isValueable: json["isValueable"] ?? false, // Default ke false
        iconDepartement: json["iconDepartement"] ?? "",
        resolusi: json["resolusi"] ?? "",
        description: json["description"] ?? "",
        title: json["title"] ?? "",
        emailSender: json["emailSender"] ?? "",
        profileImageSender: json["profileImageSender"] ?? "",
        positionSender: json["positionSender"] ?? "",
        setDate: json["setDate"] ?? "",
        setTime: json["setTime"] ?? "",
        sender: json["sender"] ?? "",
        typeReport: json["typeReport"] ?? "",
        comment: json["comment"] == null
            ? []
            : List<dynamic>.from(json["comment"].map((x) => x)),
        assigned: json["assigned"] == null
            ? []
            : List<String>.from(json["assigned"].map((x) => x)),
        registeredTask: json["registeredTask"] == null
            ? []
            : List<String>.from(json["registeredTask"].map((x) => x)),
        subscriberToken: json["subscriberToken"] == null
            ? []
            : List<String>.from(json["subscriberToken"].map((x) => x)),
        image: json["image"] == null
            ? []
            : List<dynamic>.from(json["image"].map((x) => x)),
        location: json["location"] ?? "",
        id: json["id"] ?? "",
        time: json["time"] is Timestamp
            ? json["time"]
            : Timestamp.fromMillisecondsSinceEpoch(
                json["time"]?.millisecondsSinceEpoch ?? 0),
        closeTime: json["closeTime"] ?? "",
        status: json["status"] ?? "",
        sendTo: json["sendTo"] ?? "",
        isFading: json["isFading"], // Default ke true
        from: json["from"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "receiver": receiver,
        "isValueable": isValueable,
        "emailSender": emailSender,
        "typeReport": typeReport,
        "iconDepartement": iconDepartement,
        "profileImageSender": profileImageSender,
        "positionSender": positionSender,
        "description": description,
        "title": title,
        "setDate": setDate,
        "setTime": setTime,
        "sender": sender,
        "from": from,
        "isPriority": isPriority ?? false,
        "resolusi": resolusi,
        "comment":
            comment == null ? [] : List<dynamic>.from(comment!.map((x) => x)),
        "assigned":
            assigned == null ? [] : List<dynamic>.from(assigned!.map((x) => x)),
        "registeredTask": registeredTask == null
            ? []
            : List<dynamic>.from(registeredTask!.map((x) => x)),
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "subscriberToken": subscriberToken == null
            ? []
            : List<dynamic>.from(subscriberToken!.map((x) => x)),
        "location": location,
        "id": id,
        "time": time?.toDate().toIso8601String(),
        "closeTime": closeTime,
        "status": status,
        "isFading": isFading,
        "sendTo": sendTo,
      };
}
