class FeedbackModel {
  String? category;
  String id;
  String? description;
  String? reporterName;
  String? title;
  String? userName;
  String? time;
  List<String>? likes;
  List<String>? dislikes;

  FeedbackModel(
      {this.category,
      required this.id,
      this.description,
      this.reporterName,
      this.title,
      this.time,
      this.userName,
      this.likes,
      this.dislikes});

  FeedbackModel copyWith({
    String? category,
    String? description,
    String? feedbackId,
    bool? isAnonymous,
    String? reporterName,
    String? title,
    String? username,
    String? id,
    List<String>? likes,
    List<String>? disLikes,
  }) =>
      FeedbackModel(
        category: category ?? this.category,
        description: description ?? this.description,
        reporterName: reporterName ?? this.reporterName,
        title: title ?? this.title,
        userName: username ?? userName,
        id: id ?? this.id,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
      );

  factory FeedbackModel.fromJson(dynamic json) => FeedbackModel(
        category: json["category"],
        id: json["id"],
        description: json["description"],
        reporterName: json["reporter_name"],
        title: json["title"],
        userName: json["user_name"],
        time: json["time"],
        likes: json["likes"] == null
            ? []
            : List<String>.from(json["likes"]!.map((x) => x)),
        dislikes: json["dislikes"] == null
            ? []
            : List<String>.from(json["dislikes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "time": time,
        "description": description,
        "reporter_name": reporterName,
        "title": title,
        "user_name": userName,
        "likes": likes == null ? [] : List<String>.from(likes!.map((x) => x)),
        "dislikes":
            dislikes == null ? [] : List<String>.from(dislikes!.map((x) => x)),
      };
}
