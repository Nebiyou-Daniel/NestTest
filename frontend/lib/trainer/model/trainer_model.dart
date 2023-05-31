class Trainer {
  // id
  final int id;
  final String name;
  final String bio;
  final double rating;
  final int numberOfTrainees;
  final String email;
  final String phoneNumber;

  Trainer({
    required this.id,
    required this.name,
    required this.bio,
    required this.rating,
    required this.numberOfTrainees,
    required this.email,
    required this.phoneNumber,
  });

  // from json
  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
      rating: json['rating'],
      numberOfTrainees: json['numberOfTrainees'],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
    );
  }
}