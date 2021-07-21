import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/blocs/auth/auth_bloc.dart';
import 'package:instagram/screens/profile/bloc/profile_bloc.dart';
import 'package:instagram/screens/profile/widget/profile_info.dart';
import 'package:instagram/screens/profile/widget/profile_stats.dart';
import 'package:instagram/widgets/error_dialog.dart';
import 'package:instagram/widgets/user_profile_image.dart';

class ProfileScren extends StatelessWidget {
  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${state.user?.username}'),
            actions: [
              if (state.isCurrentUser ?? false)
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0),
                      child: Row(
                        children: [
                          UserProfileImage(
                            radius: 40.0,
                            profileImageUrl: state.user?.profileImageUrl,
                          ),
                          ProfileStats(
                            isCurrentUser: state.isCurrentUser ?? false,
                            isFollowing: state.isFollowing ?? false,
                            posts: state.posts?.length ?? 0,
                            followers: state.user?.followers,
                            following: state.user?.following ?? 0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: ProfileInfo(
                        username: state.user?.username ?? '',
                        bio: state.user?.bio ?? '',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
