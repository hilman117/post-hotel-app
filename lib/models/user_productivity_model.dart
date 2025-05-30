class UserProductivityModel {
  String? userName;
  int? totalCreate;
  int? totalReceive;
  String? departement;

  UserProductivityModel(
      {required this.userName,
      required this.totalCreate,
      required this.totalReceive,
      this.departement});
}
