class Static {
  late int death;
  late int treating;
  late int cases;
  late int recovered;

  Static({
    required this.death,
    required this.treating,
    required this.cases,
    required this.recovered,
  });

  Static.fromJson(Map<String, dynamic> json) {
    death = json['death'];
    treating = json['treating'];
    cases = json['cases'];
    recovered = json['recovered'];
  }
}
