import 'package:flutter/material.dart';
import 'package:instagram/blocs/auth/auth_bloc.dart';
import 'package:instagram/config/custom_router.dart';
import 'package:instagram/enums/enums.dart';
import 'package:instagram/repositories/post/post_repository.dart';
import 'package:instagram/repositories/storage/storage_repository.dart';
import 'package:instagram/repositories/user/user_repository.dart';
import 'package:instagram/screens/create_posts/create_post_screen.dart';
import 'package:instagram/screens/create_posts/cubit/create_post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/screens/profile/bloc/profile_bloc.dart';
import 'package:instagram/screens/profile/profile_screen.dart';
import 'package:instagram/screens/search/cubit/search_cubit.dart';
import 'package:instagram/screens/search/search_screen.dart';

class TavNavigator extends StatelessWidget {
  const TavNavigator({Key? key, required this.navigatorKey, required this.item})
      : super(key: key);

  static const String tabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> routeBuilders =
        _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, String initialRoute) {
        return <Route<dynamic>>[
          MaterialPageRoute<dynamic>(
            settings: const RouteSettings(name: tabNavigatorRoot),
            builder: (BuildContext context) =>
                routeBuilders[initialRoute]!(context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return <String, Widget Function(BuildContext)>{
      tabNavigatorRoot: (BuildContext context) => _getScreen(context, item)
    };
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return const Scaffold(
          body: Center(
            child: Text('Feed'),
          ),
        );
      case BottomNavItem.search:
        return BlocProvider<SearchCubit>(
          create: (context) =>
              SearchCubit(userRepository: context.read<UserRepository>()),
          child: SearchScreen(),
        );

      case BottomNavItem.create:
        return BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(
            postRepository: context.read<PostRepository>(),
            storageRepository: context.read<StorageRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
          child: CreatePostScreen(),
        );
      case BottomNavItem.notifications:
        return const Scaffold(
          body: Center(
            child: Text('Notifications'),
          ),
        );
      case BottomNavItem.profile:
        return BlocProvider(
          create: (context) => ProfileBloc(
            userRepository: context.read<UserRepository>(),
            authBloc: context.read<AuthBloc>(),
            postRepository: context.read<PostRepository>(),
          )..add(ProfileLoadUser(
              userId: context.read<AuthBloc>().state.user?.uid)),
          child: ProfileScreen(),
        );

      default:
        return const Scaffold();
    }
  }
}
