import '../model/address_model.dart';
import '../repositories/local_storage_repository.dart';
import '../repositories/viacep_repository.dart';

class AddressService {
  final ViaCepRepository viaCepRepository;
  final LocalStorageRepository localStorageRepository;

  AddressService({
    required this.viaCepRepository,
    required this.localStorageRepository,
  });

  Future<AddressModel> fetchAddressByCep(String cep) async {
    final address = await viaCepRepository.getAddressByCep(cep);
    await localStorageRepository.saveAddress(address);
    return address;
  }

  Future<AddressModel> fetchCepByAddress(String uf, String cidade, String logradouro) async {
    final address = await viaCepRepository.getCepByAddress(uf, cidade, logradouro);
    await localStorageRepository.saveAddress(address);
    return address;
  }

  Future<List<AddressModel>> getHistory() {
    return localStorageRepository.getAllAddresses();
  }

  Future<void> clearHistory() {
    return localStorageRepository.clearHistory();
  }
}
