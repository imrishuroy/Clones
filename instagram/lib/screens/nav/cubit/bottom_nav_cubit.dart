import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/enums/enums.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit()
      : super(const BottomNavState(selectedItem: BottomNavItem.feed));

  void updateSelectedItem(BottomNavItem item) {
    if (item != state.selectedItem) {
      emit(BottomNavState(selectedItem: item));
    }
  }
}
