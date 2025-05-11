import 'package:dio/dio.dart';
import '../model/address_model.dart';

class ViaCepRepository {
  final Dio dio;

  ViaCepRepository(this.dio);

  Future<AddressModel> getAddressByCep(String cep) async {
    final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200 && !response.data.containsKey('erro')) {
      return AddressModel.fromJson(response.data);
    } else {
      throw Exception('CEP não encontrado.');
    }
  }

  Future<AddressModel> getCepByAddress(String uf, String cidade, String logradouro) async {
    final response = await dio.get('https://viacep.com.br/ws/$uf/$cidade/$logradouro/json/');
    if (response.statusCode == 200 && (response.data as List).isNotEmpty) {
      return AddressModel.fromJson(response.data[0]);
    } else {
      throw Exception('Endereço não encontrado.');
    }
  }
}
