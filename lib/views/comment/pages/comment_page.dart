import 'package:aplikasi01/models/comment.dart';
import 'package:aplikasi01/views/comment/pages/comment_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi01/core/resources/colors.dart';

import '../../../repositories/databases/db_comment_repository.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _comments = [];
  final _dateFormat = DateFormat('dd MMM yyy');

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() async {
    final commentRepository = DbCommentRepository();
    final comments =
        await commentRepository.getCommentsByMomentId(widget.momentId);
    debugPrint('Loaded comments: $comments');
    setState(() {
      _comments = comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _comments
              .map((comment) => ListTile(
                    title: Text(comment.creator),
                    subtitle: Text(comment.content),
                    leading: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/150'),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'edit') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommentEntryPage(
                                selectedComment: comment,
                                onSaved: (updatedComment) {
                                  setState(() {
                                    final index = _comments.indexWhere(
                                        (c) => c.id == updatedComment.id);
                                    if (index != -1) {
                                      _comments[index] = updatedComment;
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        } else if (value == 'delete') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Comment'),
                              content: const Text(
                                  'Are you sure you want to delete this comment?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final commentRepository =
                                        DbCommentRepository();
                                    await commentRepository
                                        .deleteComment(comment.id);
                                    setState(() {
                                      _comments.removeWhere(
                                          (c) => c.id == comment.id);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_dateFormat.format(comment.createdAt)),
                          const Icon(Icons.more_vert, color: primaryColor),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CommentEntryPage(
              onSaved: (newComment) {
                setState(() {
                  _comments.add(newComment);
                });
              },
              selectedComment: null, //buat komen baru
            );
          }));
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
