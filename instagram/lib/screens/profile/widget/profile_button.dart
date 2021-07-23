import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/screens/edit_profile/edit_profile_screen.dart';
import 'package:instagram/screens/profile/bloc/profile_bloc.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pushNamed(
                EditProfileScreen.routeName,
                arguments: EditProfileScreenArgs(context: context)),
            child: const Text(
              'Edit Profile',
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: isFollowing
                  ? Colors.grey[300]
                  : Theme.of(context).primaryColor,
              textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            onPressed: () => isFollowing
                ? context.read<ProfileBloc>().add(ProfileUnfollowUser())
                : context.read<ProfileBloc>().add(ProfileFollowUser()),
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: TextStyle(
                color: isFollowing ? Colors.black : Colors.white,
              ),
            ),
          );
  }
}
