import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  final String cep;

  @HiveField(1)
  final String logradouro;

  @HiveField(2)
  final String complemento;

  @HiveField(3)
  final String bairro;

  @HiveField(4)
  final String localidade;

  @HiveField(5)
  final String uf;

  AddressModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'] ?? '',
      logradouro: json['logradouro'] ?? '',
      complemento: json['complemento'] ?? '',
      bairro: json['bairro'] ?? '',
      localidade: json['localidade'] ?? '',
      uf: json['uf'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
    };
  }

  @override
  String toString() {
    return '$logradouro, $bairro, $localidade - $uf, $cep';
  }
}
