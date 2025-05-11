import 'package:mobx/mobx.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:hive/hive.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  @observable
  ObservableList<AddressModel> history = ObservableList<AddressModel>();

  @action
  Future<void> loadHistory() async {
    final box = await Hive.openBox<AddressModel>('addresses');
    history = ObservableList.of(box.values);
  }

  @action
  Future<void> clearHistory() async {
    final box = await Hive.openBox<AddressModel>('addresses');
    await box.clear();
    history.clear();
  }
}
