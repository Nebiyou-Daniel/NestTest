class Trainer {
  final String name;
  final String speciality;
  final double rating;
  final int numberOfTrainees;
  final String email;
  final String phoneNumber;

  Trainer({
    required this.name,
    required this.speciality,
    required this.rating,
    required this.numberOfTrainees,
    required this.email,
    required this.phoneNumber,
  });

  // from json
  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      name: json['name'],
      speciality: json['speciality'],
      rating: json['rating'],
      numberOfTrainees: json['numberOfTrainees'],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
    );
  }
}