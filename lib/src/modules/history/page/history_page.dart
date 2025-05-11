import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location/src/modules/history/controller/history_controller.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = HistoryController();

  @override
  void initState() {
    super.initState();
    controller.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Endereços'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: controller.clearHistory,
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.history.isEmpty) {
            return const Center(child: Text('Nenhum endereço consultado.'));
          }

          return ListView.builder(
            itemCount: controller.history.length,
            itemBuilder: (_, index) {
              final AddressModel address = controller.history[index];
              return ListTile(
                title: Text(address.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
