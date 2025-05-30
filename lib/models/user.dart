class UserDetails {
  String? userColor;
  String? email;
  String? name;
  String? position;
  String? hotel;
  String? location;
  String? profileImage;
  String? department;
  String? uid;
  String? hotelid;
  String? password;
  String? accountType;
  String? token;
  List<String>? userGroup;
  bool? receiveNotifWhenAccepted;
  bool? receiveNotifWhenClose;
  bool? isOnDuty;
  bool? sendChatNotif;
  bool? popUpNotif;
  bool? isActive;
  bool? isDashboardAllow;
  bool? isAllowLF;
  int? acceptRequest;
  int? closeRequest;
  int? createRequest;

  UserDetails({
    this.userColor,
    this.email,
    this.uid,
    this.hotelid,
    this.name,
    this.position,
    this.hotel,
    this.location,
    this.password,
    this.profileImage,
    this.department,
    this.receiveNotifWhenAccepted,
    this.receiveNotifWhenClose,
    this.acceptRequest,
    this.closeRequest,
    this.createRequest,
    this.isOnDuty,
    this.sendChatNotif,
    this.popUpNotif,
    this.isActive,
    this.isDashboardAllow,
    this.isAllowLF,
    this.accountType,
    this.token,
    this.userGroup,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        userColor: json['userColor'],
        email: json['email'],
        password: json['password'],
        name: json['name'],
        hotelid: json['hotelid'],
        uid: json['uid'],
        position: json['position'],
        hotel: json['hotel'],
        location: json['location'],
        isDashboardAllow: json['isDashboardAllow'],
        isAllowLF: json['isAllowLF'],
        profileImage: json['profileImage'],
        department: json['department'],
        receiveNotifWhenAccepted: json["ReceiveNotifWhenAccepted"],
        receiveNotifWhenClose: json["ReceiveNotifWhenClose"],
        acceptRequest: json["acceptRequest"],
        closeRequest: json["closeRequest"],
        createRequest: json["createRequest"],
        isOnDuty: json["isOnDuty"],
        sendChatNotif: json["sendChatNotif"] ?? false,
        popUpNotif: json["popUpNotif"],
        isActive: json["isActive"],
        accountType: json["accountType"],
        token: json["token"],
        userGroup: List<String>.from(json["userGroup"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'userColor': userColor,
        'email': email,
        'name': name,
        'password': password,
        'hotelid': hotelid,
        'uid': uid,
        'position': position,
        'isDashboardAllow': isDashboardAllow,
        'isAllowLF': isAllowLF,
        'hotel': hotel,
        'location': location,
        'profileImage': profileImage,
        'ReceiveNotifWhenAccepted': receiveNotifWhenAccepted,
        'ReceiveNotifWhenClose': receiveNotifWhenClose,
        'acceptRequest': acceptRequest,
        'closeRequest': closeRequest,
        'createRequest': createRequest,
        'sendChatNotif': sendChatNotif,
        'popUpNotif': popUpNotif ?? false,
        'isOnDuty': isOnDuty,
        'isActive': isActive,
        'department': department,
        'accountType': accountType,
        "token": token,
        "userGroup": userGroup == null
            ? []
            : List<dynamic>.from(userGroup!.map((x) => x)),
      };
}
