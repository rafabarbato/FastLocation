import 'package:hive_flutter/hive_flutter.dart';
import 'address_adapter.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AddressModelAdapter());
    await Hive.openBox<AddressModel>('addresses');
  }
}