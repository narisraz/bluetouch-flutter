import 'package:bluetouch/auth/config/use_case.dart';
import 'package:bluetouch/auth/domain/models/auth_exception.dart';
import 'package:bluetouch/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!ResponsiveUtils.isMobile(context))
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
                        onFieldSubmitted: (_) {
                          processLogin(
                              ref: ref,
                              context: context,
                              email: emailController.text,
                              password: passwordController.text);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          processLogin(
                              ref: ref,
                              context: context,
                              email: emailController.text,
                              password: passwordController.text);
                        },
                        child: const Text("Se connecter"))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  processLogin(
      {required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    final login = ref.read(loginProvider);
    final authResult = await login.execute(email, password);
    if (authResult.success == false && context.mounted) {
      if (authResult.exception is BadCredentialException) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            showCloseIcon: true,
            content: Text("Email ou mot de passe incorrect")));
      }
      if (authResult.exception is UnauthorizedException) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            showCloseIcon: true,
            content: Text("Vous n'êtes pas autorisé à visiter ce site")));
      }
    }
  }
}
