class Post {
  int userId;
  int id;
  String title;
  String body;
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });
  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }

  Map<String, dynamic> toJSON() =>
      {'id': id, 'userId': userId, "title": title, "body": body};
}
