part of 'bottom_nav_cubit.dart';

class BottomNavState extends Equatable {
  const BottomNavState({required this.selectedItem});
  final BottomNavItem selectedItem;

  @override
  List<Object?> get props => <Object?>[selectedItem];
}
