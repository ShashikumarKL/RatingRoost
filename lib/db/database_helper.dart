import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/book.dart';
import '../models/review.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'rating_roost.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE reviews(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookId INTEGER NOT NULL,
        content TEXT NOT NULL,
        FOREIGN KEY(bookId) REFERENCES books(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> insertBook(Book book) async {
    final db = await database;
    return await db.insert('books', book.toMap());
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final maps = await db.query('books');
    return maps.map((e) => Book.fromMap(e)).toList();
  }

  Future<int> insertReview(Review review) async {
    final db = await database;
    return await db.insert('reviews', review.toMap());
  }

  Future<List<Review>> getReviews(int bookId) async {
    final db = await database;
    final maps = await db.query('reviews', where: 'bookId = ?', whereArgs: [bookId]);
    return maps.map((e) => Review.fromMap(e)).toList();
  }

  Future<int> updateReview(Review review) async {
    final db = await database;
    return await db.update('reviews', review.toMap(), where: 'id = ?', whereArgs: [review.id]);
  }

  Future<int> deleteReview(int id) async {
    final db = await database;
    return await db.delete('reviews', where: 'id = ?', whereArgs: [id]);
  }
}
