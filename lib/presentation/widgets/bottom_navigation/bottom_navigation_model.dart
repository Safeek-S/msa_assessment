import 'package:mobx/mobx.dart';

part 'bottom_navigation_model.g.dart';

class BottomNavigationModel = _NavigationStore with _$BottomNavigationModel;

abstract class _NavigationStore with Store {
  @observable
  int selectedIndex = 0;

  @action
  void setIndex(int index) {
    selectedIndex = index;
  }
}
