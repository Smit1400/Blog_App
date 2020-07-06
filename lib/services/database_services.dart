import 'package:blog_app/models/post.dart';
import 'package:blog_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

abstract class DatabaseServices {
  Future<void> createPost(String uid, Post post);
  Future<void> deletePost(String uid, Post post);
  Stream<List<Post>> getAllPosts();
  Future<User> getUserData(String uid);
  Stream<List<Post>> getAllUsersPosts(String uid);
}

class Database implements DatabaseServices{

  Future<User> getUserData(String uid) async {
//    print(uid);
    String path = 'users/$uid/';
//    print(path);
    final reference = Firestore.instance.document(path);
    final data = await reference.get().then((value) => User.fromMap(value.data));
//    print(data.uid);
    return data;
  }

  Stream<List<Post>> getAllUsersPosts(String uid) {
    String path = "users/$uid/posts/";
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((e) => Post.fromMap(e.data)).toList());
  }

  Stream<List<Post>> getAllPosts() {
    String path = "posts/";
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((e) => Post.fromMap(e.data)).toList());
  }

  Future<void> createPost(String uid, Post post) async {
    try {
      String path = "users/$uid/posts/post_${post.datetime}";
      final reference = Firestore.instance.document(path);
      await reference.setData(post.toMap());
      String path2 = "posts/post_${post.datetime}";
      final reference2 = Firestore.instance.document(path2);
      await reference2.setData(post.toMap());
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        details: e.details,
      );
    }
  }

  Future<void> deletePost(String uid, Post post) async {
    try {
      String path = "users/$uid/posts/post_${post.datetime}";
      final reference = Firestore.instance.document(path);
      await reference.delete();
      String path2 = "posts/post_${post.datetime}";
      final reference2 = Firestore.instance.document(path2);
      await reference2.delete();
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        details: e.details,
      );
    }
  }

  Future<void> savePost(String uid, Post post) async {
    try {
      String path = "users/$uid/saved_posts/post_${post.datetime}";
      final reference = Firestore.instance.document(path);
      await reference.setData(post.toMap());
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        details: e.details,
      );
    }
  }

  Future<void> unsavePost(String uid, Post post) async {
    try {
      String path = "users/$uid/saved_posts/post_${post.datetime}";
      final reference = Firestore.instance.document(path);
      await reference.delete();
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        details: e.details,
      );
    }
  }
}
