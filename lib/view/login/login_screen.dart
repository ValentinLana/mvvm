import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view/products_list/products_list_screen.dart';
import 'package:flutter_mvvm_provider/viewmodels/login/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      builder: (context, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Bienvenido',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Usuario'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su usuario';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      context.read<LoginViewModel>().onUsernameChanged(value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su contraseña';
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (value) =>
                      context.read<LoginViewModel>().onPasswordChanged(value),
                ),
                const SizedBox(height: 100.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final viewModel = context.read<LoginViewModel>();
                      await viewModel.login();
                      if (viewModel.isSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductsListScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(viewModel.errorMessage)));
                      }
                    }
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
