class BlogModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List listOfLikes;

  BlogModel({
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
      'listOfLikes': listOfLikes,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Create a BlogModel instance from a JSON map.
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      listOfLikes: json["listOfLikes"] as List,
    );
  }
}
