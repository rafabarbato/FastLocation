import 'package:hive/hive.dart';
import '../model/address_model.dart';

class LocalStorageRepository {

  Box<AddressModel> _getAddressBox() {
    if (!Hive.isBoxOpen('addresses')) {
      throw HiveError('The box "addresses" is not open.');
    }
    return Hive.box<AddressModel>('addresses');
  }

  Future<void> saveAddress(AddressModel address) async {
    final box = _getAddressBox();
    await box.add(address);
  }

  Future<List<AddressModel>> getAllAddresses() async {
    final box = _getAddressBox();
    final addresses = box.values.toList();
    return addresses;
  }

  Future<void> clearHistory() async {
    final box = _getAddressBox();
    await box.clear();
  }

}