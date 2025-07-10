import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/book.dart';
import '../models/review.dart';
import 'review_form_screen.dart';

class ReviewListScreen extends StatefulWidget {
  final Book book;
  const ReviewListScreen({super.key, required this.book});

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    final reviews = await DatabaseHelper.instance.getReviews(widget.book.id!);
    setState(() {
      _reviews = reviews;
    });
  }

  void _addReview() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewFormScreen(book: widget.book),
      ),
    );
    _loadReviews();
  }

  void _editReview(Review review) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewFormScreen(book: widget.book, review: review),
      ),
    );
    _loadReviews();
  }

  void _deleteReview(int id) async {
    await DatabaseHelper.instance.deleteReview(id);
    _loadReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reviews for ${widget.book.title}')),
      body: ListView.builder(
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          final review = _reviews[index];
          return ListTile(
            title: Text(review.content),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editReview(review),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteReview(review.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReview,
        child: const Icon(Icons.add),
      ),
    );
  }
}
