import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location/src/modules/home/controller/home_controller.dart';
import 'package:mobx/mobx.dart'; // Importação correta para FutureStatus
import 'package:fast_location/src/routes/app_routes.dart';
import 'package:map_launcher/map_launcher.dart'; // <--- Importe map_launcher
import 'package:fast_location/src/modules/home/model/address_model.dart'; // Importe AddressModel se necessário para tipagem
import 'package:geocoding/geocoding.dart'; // <--- Importe geocoding


// Função utilitária para abrir o app de mapas com geocodificação
Future<void> _openMapWithAddress(String address, BuildContext context) async {
  try {
    final availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.isEmpty) {
      // Mostrar aviso para o usuário usando um SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum aplicativo de mapas instalado.')),
      );
      debugPrint('Nenhum aplicativo de mapas instalado.');
      return;
    }

    // Usa geocoding para obter as coordenadas do endereço
    final locations = await locationFromAddress(address);

    if (locations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível localizar o endereço.')),
      );
      debugPrint('Não foi possível localizar o endereço para: $address');
      return;
    }

    // Pega a primeira localização encontrada (geralmente a mais relevante)
    final loc = locations.first;

    // Usa as coordenadas reais obtidas pelo geocoding
    await availableMaps.first.showDirections(
      destination: Coords(loc.latitude, loc.longitude), // <--- Agora usando as coordenadas reais
      destinationTitle: address, // Ainda útil para o nome do destino no mapa
      directionsMode: DirectionsMode.driving, // Modo de direção (driving, walking, etc.)
      // origin: Coords(lat, lng), // Opcional: Se quiser definir um ponto de origem específico
      // originTitle: "Minha Localização", // Opcional: Título para o ponto de origem
    );

  } catch (e) {
    // Lida com possíveis erros ao abrir o mapa (por exemplo, se o formato do endereço for problemático)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao tentar abrir o mapa: ${e.toString()}')),
    );
    debugPrint('Erro ao abrir mapa com geocoding: $e');
  }
}


class HomePage extends StatelessWidget {
  final HomeController controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cepController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('FastLocation')),
      body: SafeArea( // Adiciona SafeArea
        child: SingleChildScrollView( // Adiciona SingleChildScrollView para permitir rolagem
          padding: const EdgeInsets.all(16), // Move o padding para aqui
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Opcional, ajuda a esticar os elementos
            children: [
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Digite o CEP',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final cep = cepController.text.trim(); // Pega o texto do campo e remove espaços extras

                  if (cep.isEmpty || cep.length < 8) { // Valida se o CEP está vazio ou tem menos de 8 dígitos
                    ScaffoldMessenger.of(context).showSnackBar( // Exibe uma mensagem para o usuário
                      const SnackBar(content: Text('Informe um CEP válido.')),
                    );
                    return; // Interrompe a execução se o CEP for inválido
                  }

                  controller.setCep(cep); // Define o CEP no controller
                  controller.searchCep(); // Aciona a busca
                },
                child: const Text('Buscar Endereço'),
              ),
              const SizedBox(height: 24),
              Observer(
                builder: (_) {
                  if (controller.addressFuture == null) {
                    return const Text('Digite um CEP para buscar.');
                  }

                  if (controller.addressFuture!.status == FutureStatus.pending) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final address = controller.addressFuture!.result;

                  if (address == null) {
                    return const Text('Endereço não encontrado.');
                  }

                  // <--- Início do trecho para exibir o endereço encontrado e o botão
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Endereço encontrado:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(address.toString()),
                      const SizedBox(height: 16), // Espaço entre o endereço e o botão
                      ElevatedButton.icon(
                        icon: const Icon(Icons.directions),
                        label: const Text('Traçar Rota'),
                        onPressed: () {
                          // Chama a função para abrir o mapa
                          _openMapWithAddress(address.toString(), context);
                        },
                      ),
                    ],
                  );
                  // <--- Fim do trecho
                },
              ),
              const SizedBox(height: 24),
              const Divider(),
              const Text('Histórico:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Observer(
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha os itens da lista à esquerda (opcional)
                  children: controller.addressHistory
                      .map((item) => ListTile( // Mapeia cada item do histórico para um ListTile
                    title: Text(item.toString()),
                  ))
                      .toList(), // Converte o resultado para uma lista de Widgets
                ),
              ),
              const SizedBox(height: 24), // Adiciona espaçamento antes do botão de histórico
              TextButton.icon( // Adiciona o botão para ver o histórico completo
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.history);
                },
                icon: const Icon(Icons.history),
                label: const Text('Ver Histórico'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}