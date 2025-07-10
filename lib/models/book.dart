class Book {
  final int? id;
  final String title;

  Book({this.id, required this.title});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'title': title};
    if (id != null) map['id'] = id;
    return map;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int?,
      title: map['title'] as String,
    );
  }
}
