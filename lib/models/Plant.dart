class Plant {
  late String Plant_Id;
  late String Plant_name;
  late DateTime Plant_date;

  factory Plant.fromJson(jsondata) {
    return Plant.fromJson(jsondata['Plant']);
  }
}
