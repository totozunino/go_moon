class Moon {
  final String phase;
  final double ilumination;

  const Moon({
    required this.phase,
    required this.ilumination,
  });

  factory Moon.fromJson(Map<String, dynamic> json) {
    return Moon(
      phase: json['phase'],
      ilumination: json['ilumination'],
    );
  }
}
