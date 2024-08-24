class CommentModel {
  final String id;
  final String userId;
  final String username;
  final String description;
  final DateTime date;
  final String blogId;

  CommentModel({
    required this.date,
    required this.blogId,
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
      "blogId": blogId,
      'date': date.toIso8601String(),
    };
  }

  // Create a BlogModel instance from a JSON map.
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      username: json['username'] as String,
      blogId: json['blogId'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date']),
      userId: json['userId'] as String,
    );
  }
}
