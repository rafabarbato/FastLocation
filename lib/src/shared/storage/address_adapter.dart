import 'package:hive/hive.dart';

part 'address_adapter.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  final String cep;

  @HiveField(1)
  final String logradouro;

  @HiveField(2)
  final String bairro;

  @HiveField(3)
  final String localidade;

  @HiveField(4)
  final String uf;

  AddressModel({
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });
}