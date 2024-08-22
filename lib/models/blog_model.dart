class BlogModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List listOfLikes;
  final DateTime createdAt;

  BlogModel({
    required this.createdAt,
    required this.listOfLikes,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  // Convert a BlogModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'listOfLikes': listOfLikes,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  // Create a BlogModel instance from a JSON map.
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      listOfLikes: json["listOfLikes"] as List,
      description: json['description'] as String,
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
