import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:rating_roost_flutter/db/database_helper.dart';
import 'package:rating_roost_flutter/models/book.dart';
import 'package:rating_roost_flutter/models/review.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('insert and fetch book and reviews', () async {
    final helper = DatabaseHelper.forTesting(inMemoryDatabasePath);

    final bookId = await helper.insertBook(Book(title: 'Test Book'));
    expect(bookId, greaterThan(0));

    final books = await helper.getBooks();
    expect(books.length, 1);
    expect(books.first.title, 'Test Book');

    final reviewId = await helper.insertReview(
      Review(bookId: books.first.id ?? bookId, content: 'Nice'),
    );
    expect(reviewId, greaterThan(0));

    final reviews = await helper.getReviews(bookId);
    expect(reviews.length, 1);
    expect(reviews.first.content, 'Nice');
  });
}
