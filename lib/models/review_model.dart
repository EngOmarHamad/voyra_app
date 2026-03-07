class ReviewModel {
  final String userName;
  final double rating;
  final String comment;
  final String userImage;
  final String date;

  ReviewModel({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.userImage,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['userName'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      userImage: json['userImage'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'userImage': userImage,
      'date': date,
    };
  }
}
