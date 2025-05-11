import 'package:mobx/mobx.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/address_service.dart';
import 'package:fast_location/src/modules/home/repositories/viacep_repository.dart';
import 'package:fast_location/src/modules/home/repositories/local_storage_repository.dart';
import 'package:dio/dio.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final AddressService _service = AddressService(
    viaCepRepository: ViaCepRepository(Dio()),
    localStorageRepository: LocalStorageRepository(),
  );

  @observable
  String cep = '';

  @observable
  ObservableFuture<AddressModel?>? addressFuture;

  @observable
  ObservableList<AddressModel> addressHistory = ObservableList<AddressModel>();

  @action
  void setCep(String value) => cep = value;

  @action
  Future<void> searchCep() async {
    addressFuture = ObservableFuture(_service.fetchAddressByCep(cep));
    final address = await addressFuture;
    if (address != null && !addressHistory.any((a) => a.cep == address.cep)) {
      addressHistory.add(address);
    }
  }

  @action
  Future<void> loadSavedAddresses() async {
    final addresses = await _service.getHistory();
    addressHistory.addAll(addresses);
  }
}
