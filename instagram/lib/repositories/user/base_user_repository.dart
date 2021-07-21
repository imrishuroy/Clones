import 'package:instagram/models/models.dart';

abstract class BaseUserRepository {
  Future<AppUser> getUserWithId({String userId});
  Future<void> updateUser({AppUser user});
  // Future<List<AppUser?>> searchUsers({String query});
  // void followUser({String userId, String followUserId});
  // void unfollowUser({String userId, String unfollowUserId});
  // Future<bool> isFollowing({String userId, String otherUserId});
}
