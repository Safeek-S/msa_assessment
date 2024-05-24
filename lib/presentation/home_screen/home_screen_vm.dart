import 'package:mobx/mobx.dart';
import 'package:msa_assessment/presentation/home_screen/home_screen_model.dart';



class HomeScreenVM extends HomeScreenModel{

  Future<void> fetchExpenses()async{
    try {
      var res = await localStorageService.getExpenses();
      expenseStore.setExpenses(ObservableList.of(res.data!));
    } catch (e) {
      print(e.toString());
    }
  }
  
}