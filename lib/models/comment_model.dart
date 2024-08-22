class CommentModel {
  final String id;
  final String date;
  final String username;
  final String description;

  CommentModel({
    required this.date,
    required this.id,
    required this.username,
    required this.description,
  });

  // Convert a BlogModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'description': description,
      'date': date,
    };
  }

  // Create a BlogModel instance from a JSON map.
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      username: json['username'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
    );
  }
}
