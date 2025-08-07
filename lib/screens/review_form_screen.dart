import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/book.dart';
import '../models/review.dart';

class ReviewFormScreen extends StatefulWidget {
  final Book book;
  final Review? review;
  const ReviewFormScreen({super.key, required this.book, this.review});

  @override
  State<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.review?.content ?? '');
  }

  Future<void> _save() async {
    if (widget.review == null) {
      await DatabaseHelper.instance.insertReview(
        Review(bookId: widget.book.id!, content: _controller.text),
      );
    } else {
      await DatabaseHelper.instance.updateReview(
        Review(
          id: widget.review!.id,
          bookId: widget.book.id!,
          content: _controller.text,
          isLiked: widget.review!.isLiked,
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.review == null ? 'Add Review' : 'Edit Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Review'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
