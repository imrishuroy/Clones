import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagram/enums/enums.dart';
import 'package:instagram/screens/nav/cubit/bottom_nav_cubit.dart';
import 'package:instagram/screens/nav/widgets/bottom_nav_bar.dart';
import 'package:instagram/screens/nav/widgets/tab_navigator.dart';

class NavScreen extends StatelessWidget {
  NavScreen({Key? key}) : super(key: key);

  static const String routeName = '/nav';

  static Route<void> route() {
    return PageRouteBuilder<void>(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(),
      pageBuilder: (_, __, ___) => BlocProvider<BottomNavCubit>(
        create: (_) => BottomNavCubit(),
        child: NavScreen(),
      ),
    );
  }

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys =
      <BottomNavItem, GlobalKey<NavigatorState>>{
    BottomNavItem.feed: GlobalKey<NavigatorState>(),
    BottomNavItem.search: GlobalKey<NavigatorState>(),
    BottomNavItem.create: GlobalKey<NavigatorState>(),
    BottomNavItem.notifications: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavItem, IconData> items = <BottomNavItem, IconData>{
    BottomNavItem.feed: Icons.home,
    BottomNavItem.search: Icons.search,
    BottomNavItem.create: Icons.add,
    BottomNavItem.notifications: Icons.favorite_border,
    BottomNavItem.profile: Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    //RepositoryProvider.of<AuthRepository>(context).logout();
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (BuildContext context, BottomNavState state) {
          return Scaffold(
            body: Stack(
              children: items
                  .map(
                    (BottomNavItem item, _) => MapEntry<BottomNavItem, Widget>(
                      item,
                      _buildOffStageNavigator(
                        item,
                        item == state.selectedItem,
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
            bottomNavigationBar: BottomNavBar(
              items: items,
              selectedItem: state.selectedItem,
              onTap: (int index) {
                final BottomNavItem selectedItem = BottomNavItem.values[index];

                _selectBottomNaviItem(
                  context,
                  selectedItem,
                  selectedItem == state.selectedItem,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOffStageNavigator(
    BottomNavItem currentItem,
    bool isSelected,
  ) {
    return Offstage(
      offstage: !isSelected,
      child: TavNavigator(
        navigatorKey: navigatorKeys[currentItem]!,
        item: currentItem,
      ),
    );
  }

  void _selectBottomNaviItem(
    BuildContext context,
    BottomNavItem selectedItem,
    bool isSameItem,
  ) {
    if (isSameItem) {
      // feed screen --> post screen --> post comment -->

      navigatorKeys[selectedItem]
          ?.currentState
          ?.popUntil((Route<dynamic> route) => route.isFirst);
    }
    context.read<BottomNavCubit>().updateSelectedItem(selectedItem);
  }
}
