import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/blocs/auth/auth_bloc.dart';
import 'package:instagram/models/app_user.dart';

import 'package:instagram/models/failure.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/repositories/post/post_repository.dart';
import 'package:instagram/repositories/storage/storage_repository.dart';
import 'package:meta/meta.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostRepository _postRepository;

  final StorageRepository _storageRepository;
  final AuthBloc _authBloc;

  CreatePostCubit({
    required PostRepository postRepository,
    required StorageRepository storageRepository,
    required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _storageRepository = storageRepository,
        _authBloc = authBloc,
        super(CreatePostState.initial());

  void postImageChange(File? file) {
    emit(state.copyWith(postImage: file, status: CreatePostStatus.initial));
  }

  void captionChange(String caption) {
    emit(state.copyWith(caption: caption, status: CreatePostStatus.initial));
  }

  void submit() async {
    emit(state.copyWith(status: CreatePostStatus.submitting));
    try {
      // making a empty user only with id from auth bloc
      final author = AppUser.empty.copyWith(id: _authBloc.state.user?.uid);

      final postImageUrl =
          await _storageRepository.uploadPostImage(image: state.postImage!);
      final post = Post(
        author: author,
        imageUrl: postImageUrl,
        caption: state.caption,
        likes: 0,
        date: DateTime.now(),
      );
      await _postRepository.createPost(post: post);
      emit(state.copyWith(status: CreatePostStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: CreatePostStatus.error,
          failure: Failure(message: 'Unable to add your post, try agian! '),
        ),
      );
    }
  }

  void reset() {
    emit(CreatePostState.initial());
  }
}
