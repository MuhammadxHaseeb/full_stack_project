import 'package:flutter/material.dart';
import 'package:full_stack_project/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:full_stack_project/features/auth/view/widgets/custom_field.dart';
import 'package:full_stack_project/core/theme/app_pallete.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              CustomField(
                hintText: 'Name',
                controller: nameController,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              CustomField(
                hintText: 'Email',
                controller: emailController,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              CustomField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              AuthGradientButton(
                buttonText: 'Sign Up',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    print(nameController.text);
                    print(emailController.text);
                    print(passwordController.text);
                  }
                },
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: 'Already have account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: const [
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}