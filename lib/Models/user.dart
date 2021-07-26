class User {
  final String name;
  final String played;
  final String won;
  final String rating;

  User({
    required this.name,
    required this.played,
    required this.won,
    required this.rating,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        played: json['played'],
        won: json['won'],
        rating: json['rating']);
  }
}
