import 'dart:developer';

import 'package:aplikasi01/core/helpers/database_helper.dart';
import 'package:aplikasi01/models/comment.dart';
import 'package:aplikasi01/repositories/contracts/abs_comment_repository.dart';

class DbCommentRepository extends AbsCommentRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Future<void> addComment(Comment comment) async {
    try {
      // akses database
      final db = await databaseHelper.database;
      //operasi insert
      await db.insert(
        DatabaseHelper.tableComments,
        comment.toMap(),
      );
    } catch (e) {
      log(e.toString(), name: "db_comment_repository:addComment");
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    try {
      final db = await databaseHelper.database;
      // Melakukan operasi delete
      await db.delete(
        DatabaseHelper.tableMoments,
        where: 'id = ?',
        whereArgs: [commentId],
      );
    } catch (e) {
      log(e.toString(), name: "db_comment_repository:deleteComment");
    }
  }

  @override
  Future<Comment?> getCommentById(String commentId) async {
    try {
      // Akses database
      final db = await databaseHelper.database;
      // Melakukan operasi select
      final result = await db.query(
        DatabaseHelper.tableComments,
        where: 'id = ?',
        whereArgs: [commentId],
      );
      if (result.isEmpty) {
        return null;
      } else {
        return Comment.fromMap(result.first);
      }
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:getCommentById');
      return null;
    }
  }

  @override
  Future<List<Comment>> getCommentsByMomentId(String momentId) async {
    try {
      final db = await databaseHelper.database;
      // Melakukan operasi select
      final result = await db.query(DatabaseHelper.tableMoments);
      // Mengembalikan hasil
      return result.map((e) => Comment.fromMap(e)).toList();
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:getAllComment');
      return [];
    }
  }

  @override
  Future<void> updateComment(Comment comment) async {
    try {
      // Akses database
      final db = await databaseHelper.database;
      // Melakukan operasi update
      await db.update(
        DatabaseHelper.tableMoments,
        comment.toMap(),
        where: 'id = ?',
        whereArgs: [comment.id],
      );
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:updateComment');
    }
  }
}
