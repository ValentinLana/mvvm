import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view/products_list/products_list_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'services/api_service.dart';
import 'view/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await const FlutterSecureStorage().read(key: 'token');
  final getIt = GetIt.instance;

  getIt.registerSingleton<ApiService>(ApiService());

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff9e007e),
        ),
      ),
      home: isLoggedIn ? const ProductsListScreen() : LoginScreen(),
    );
  }
}
