import 'package:flutter/material.dart';
// import 'package:dio/dio.dart'; // Removida importação não utilizada neste arquivo
import 'package:fast_location/src/modules/home/controller/home_controller.dart';
import 'package:fast_location/src/modules/home/page/home_page.dart';
import 'package:fast_location/src/modules/initial/page/initial_page.dart';
import 'package:fast_location/src/routes/app_routes.dart';
// import 'package:fast_location/src/modules/home/service/address_service.dart'; // Removida importação não utilizada neste arquivo
import 'package:fast_location/src/modules/history/page/history_page.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import hive_flutter
import 'package:fast_location/src/modules/home/model/address_model.dart'; // Import AddressModel
// import 'package:fast_location/src/modules/home/repositories/local_storage_repository.dart'; // Removida importação não utilizada neste arquivo


// Function to initialize Hive and open the box
Future<void> _initHive() async {
  await Hive.initFlutter();
  // Register your adapter if you haven't already
  // Certifique-se de que AddressModelAdapter() está acessível aqui.
  // Pode ser necessário importar o arquivo onde AddressModelAdapter está definido
  // se não estiver no mesmo arquivo que AddressModel.
  if (!Hive.isAdapterRegistered(0)) { // Replace 0 with your AddressModel adapter typeId
    Hive.registerAdapter(AddressModelAdapter());
  }
  await Hive.openBox<AddressModel>('addresses');
}

void main() async { // Make main async
  WidgetsFlutterBinding.ensureInitialized(); // Required for async operations before runApp
  await _initHive(); // Initialize Hive and open the box

  runApp(const FastLocationApp());
}

class FastLocationApp extends StatelessWidget {
  const FastLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    // O HomeController é instanciado aqui e passado para a HomePage.
    // Se você planeja usar o controller em outras partes da árvore de widgets
    // (como na HistoryPage que interage com o histórico do controller),
    // considere usar um gerenciador de estado mais abrangente (como Provider, GetIt, etc.)
    // ou passá-lo como argumento para as rotas ou widgets que o utilizam.
    // Para este exemplo, onde ele é passado apenas para a HomePage, está ok.
    final controller = HomeController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastLocation',
      theme: ThemeData( // <--- Tema definido aqui
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF8F1FF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade300,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6C4AB6),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
        ),
        // Adicione aqui outras configurações de tema conforme necessário
      ),
      initialRoute: AppRoutes.initial,
      routes: {
        AppRoutes.initial: (_) => const InitialPage(),
        AppRoutes.home: (_) => HomePage(controller: controller),
        // Se a HistoryPage precisar do controller para acessar o histórico,
        // você precisará passar o controller para ela também.
        // Exemplo: AppRoutes.history: (_) => HistoryPage(controller: controller),
        AppRoutes.history: (_) => const HistoryPage(), // Mantido como estava, mas considere o ponto acima
      },
    );
  }
}