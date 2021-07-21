part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final AppUser? user;
  final List<Post>? posts;
  final bool? isCurrentUser;
  final bool? isGridView;
  final bool? isFollowing;
  final ProfileStatus status;
  final Failure failure;

  const ProfileState({
    required this.posts,
    required this.isCurrentUser,
    required this.user,
    required this.isGridView,
    required this.isFollowing,
    required this.status,
    required this.failure,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      user: AppUser.empty,
      posts: [],
      isCurrentUser: false,
      isGridView: true,
      isFollowing: false,
      status: ProfileStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [
        user,
        posts,
        isCurrentUser,
        isGridView,
        isFollowing,
        status,
        failure,
      ];

  ProfileState copyWith({
    AppUser? user,
    List<Post>? posts,
    bool? isCurrentUser,
    bool? isGridView,
    bool? isFollowing,
    ProfileStatus? status,
    Failure? failure,
  }) {
    return ProfileState(
      user: user ?? this.user,
      posts: posts ?? this.posts,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      isGridView: isGridView ?? this.isGridView,
      isFollowing: isFollowing ?? this.isFollowing,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
