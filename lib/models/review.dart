class Review {
  final int? id;
  final int bookId;
  final String content;
  final bool isLiked;

  Review({this.id, required this.bookId, required this.content, this.isLiked = false});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'bookId': bookId,
      'content': content,
      'isLiked': isLiked ? 1 : 0,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as int?,
      bookId: map['bookId'] as int,
      content: map['content'] as String,
      isLiked: (map['isLiked'] ?? 0) == 1,
    );
  }
}
