import 'package:bluetouch/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.fail) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              showCloseIcon: true,
              content: Text("Email ou mot de passe incorrect")));
          context.read<AuthBloc>().add(AuthEventInitial());
        }
      },
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/f/f4/Madagascar_%2828262716001%29.jpg"))),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/f/f4/Madagascar_%2828262716001%29.jpg"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text("Connexion", style: TextStyle(fontSize: 36)),
                      const SizedBox(
                        height: 16,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              label: Text("Email"), icon: Icon(Icons.email)),
                          onFieldSubmitted: (_) => context.read<AuthBloc>().add(
                              AuthEventLogin(emailController.text,
                                  passwordController.text)),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              label: Text("Mot de passe"),
                              icon: Icon(Icons.lock)),
                          onFieldSubmitted: (_) => context.read<AuthBloc>().add(
                              AuthEventLogin(emailController.text,
                                  passwordController.text)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthEventLogin(
                                emailController.text, passwordController.text));
                          },
                          child: const Text("Se connecter"))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
