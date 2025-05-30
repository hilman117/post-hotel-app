class PopularModel {
  String? itemName;
  int? total;
  int? closed;
  String? resolutionTime;
  String? ratePercent;
  String? departement;

  PopularModel(
      {required this.itemName,
      required this.total,
      this.closed,
      this.resolutionTime,
      this.ratePercent,
      this.departement});
}
