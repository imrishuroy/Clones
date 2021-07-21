import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:instagram/config/paths.dart';

import 'package:instagram/models/post.dart';
import 'package:instagram/models/comment.dart';
import 'package:instagram/repositories/post/base_post_repository.dart';
import 'package:meta/meta.dart';

class PostRepository extends BasePostRepository {
  final FirebaseFirestore _firebaseFirestore;

  PostRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createPost({@required Post? post}) async {
    await _firebaseFirestore.collection(Paths.posts).add(post!.toDocument());
  }

  @override
  Future<void> createComment({@required Comment? comment}) async {
    await _firebaseFirestore
        .collection(Paths.comments)
        .doc(comment?.postId)
        .collection(Paths.postComments)
        .add(comment!.toDocument());
  }

  @override
  Stream<List<Future<Post?>>> getUserPosts({@required String? userId}) {
    final _authorRef =
        FirebaseFirestore.instance.collection(Paths.posts).doc(userId);
    return _firebaseFirestore
        .collection(Paths.posts)
        // to query two fields we have to add composit indexes on firebase console
        .where('author', isEqualTo: _authorRef)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => Post.fromDocument(doc)).toList());
  }

  @override
  Stream<List<Future<Comment?>>> getUserComments({@required String? postId}) {
    return _firebaseFirestore
        .collection(Paths.comments)
        .doc(postId)
        .collection(Paths.postComments)
        .orderBy('date', descending: false)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => Comment.fromDocument(doc)).toList());
  }
}
