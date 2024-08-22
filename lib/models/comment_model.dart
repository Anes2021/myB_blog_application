class CommentModel {
  final String id;
  final String userId;
  final DateTime date;
  final String username;
  final String description;

  CommentModel({
    required this.date,
    required this.id,
    required this.userId,
    required this.username,
    required this.description,
  });

  // Convert a BlogModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'description': description,
      "userId": userId,
      'date': date.toIso8601String(),
    };
  }

  // Create a BlogModel instance from a JSON map.
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      username: json['username'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date']),
      userId: json['userId'] as String,
    );
  }
}
