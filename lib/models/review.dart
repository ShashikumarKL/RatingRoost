class Review {
  final int? id;
  final int bookId;
  final String content;

  Review({this.id, required this.bookId, required this.content});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'bookId': bookId,
      'content': content,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as int?,
      bookId: map['bookId'] as int,
      content: map['content'] as String,
    );
  }
}
