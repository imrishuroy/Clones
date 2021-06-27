import 'package:flutter/material.dart';
import 'package:instagram/config/custom_router.dart';
import 'package:instagram/enums/enums.dart';

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
        return const Scaffold(
          body: Center(
            child: Text('Search'),
          ),
        );

      case BottomNavItem.create:
        return const Scaffold(
          body: Center(
            child: Text('Create'),
          ),
        );
      case BottomNavItem.notifications:
        return const Scaffold(
          body: Center(
            child: Text('Notifications'),
          ),
        );
      case BottomNavItem.profile:
        return const Scaffold(
          body: Center(
            child: Text('Profile'),
          ),
        );

      default:
        return const Scaffold();
    }
  }
}
