class Admen {
  final String username;

  Admen(this.username);

  factory Admen.fromJson(jsondata) {
    return Admen(jsondata['Users']);
  }
}
