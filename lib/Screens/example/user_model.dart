class UserModel {
  UserModel({required this.firstName, required this.lastName, required this.profileImageUrl});
  String firstName;
  String lastName;
  String profileImageUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          profileImageUrl == other.profileImageUrl;

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ profileImageUrl.hashCode;
}

List<UserModel> listData = [
  UserModel(
    firstName: "Nash",
    lastName: "Ramdial",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/1035253589894197256/qNuF8w6e_400x400.jpg",
  ),
  UserModel(
    firstName: "Scott",
    lastName: "Stoll",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/997431887286030336/QinQPXjS_400x400.jpg",
  ),
  UserModel(
    firstName: "Simon",
    lastName: "Lightfoot",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/1017532253394624513/LgFqlJ4U_400x400.jpg",
  ),
  UserModel(
    firstName: "Jay",
    lastName: "Meijer",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/1000361976361611264/Ty8LbTKx_400x400.jpg",
  ),
  UserModel(
    firstName: "Mariano",
    lastName: "Zorrilla",
    profileImageUrl:
        "https://ca.slack-edge.com/TADUGCD9D-UC5F6HJ6T-gfbe5883d03f-1024",
  ),
];