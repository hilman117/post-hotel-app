class LFChatModel {
  LFChatModel(
      {this.accepted,
      this.commentBody,
      this.commentId,
      this.time,
      this.imageComment,
      this.sender,
      this.senderemail});

  String? accepted;
  String? commentBody;
  String? commentId;
  List<String>? imageComment;
  String? sender;
  String? senderemail;
  String? time;

  factory LFChatModel.fromJson(Map<String, dynamic> json) => LFChatModel(
        accepted: json["accepted"],
        senderemail: json["senderemail"],
        sender: json["sender"],
        commentBody: json["commentBody"],
        commentId: json["commentId"],
        imageComment: List<String>.from(json["imageComment"].map((x) => x)),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "accepted": accepted,
        "senderemail": senderemail,
        "commentBody": commentBody,
        "commentId": commentId,
        "imageComment": imageComment == null
            ? []
            : List<String>.from(imageComment!.map((x) => x)),
        "time": time,
        "sender": sender,
      };
}
