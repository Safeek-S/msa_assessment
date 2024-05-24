import 'package:mobx/mobx.dart';


part 'pie_chart_model.g.dart';
class PieChartModel extends _PieChartModel with _$PieChartModel {}

abstract class _PieChartModel with Store {
  
  @observable
  int touchIndex = -1;


  @action 
  void setTouchIndex(int index){
    touchIndex = index;
  }

}
