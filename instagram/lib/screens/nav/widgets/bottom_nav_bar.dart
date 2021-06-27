import 'package:flutter/material.dart';
import 'package:instagram/enums/enums.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
  }) : super(key: key);

  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: BottomNavItem.values.indexOf(selectedItem),
        onTap: onTap,
        items: items
            .map(
              (BottomNavItem item, IconData icon) =>
                  MapEntry<String, BottomNavigationBarItem>(
                item.toString(),
                BottomNavigationBarItem(
                  icon: Icon(icon, size: 30.0),
                  label: '',
                ),
              ),
            )
            .values
            .toList());
  }
}
