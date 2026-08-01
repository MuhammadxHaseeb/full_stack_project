import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_stack_project/core/widgets/loader.dart';
import 'package:full_stack_project/features/auth/repository/auth_remote_repository.dart';
import 'package:full_stack_project/features/auth/view/pages/signup_page.dart';
import 'package:full_stack_project/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:full_stack_project/features/auth/view/widgets/custom_field.dart';
import 'package:full_stack_project/core/theme/app_pallete.dart';
import 'package:full_stack_project/features/auth/viewmodel/auth_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;

    ref.listen(
      authViewmodelProvider,
      (_,next){
        next?.when(
          data:(data){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Account Created Successfully. Please Login In!'),
                ),
            );
            // // TODO: Navigate to home page
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(
            //     builder: (context) => const LoginPage(),),);
          },
          error: (error, st) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                 SnackBar(
                  content: Text(error.toString()),
                ),
            );
          },
          loading: () {
          },
          );
      });


    return Scaffold(
      appBar: AppBar(),
      body: isLoading ? const Loader() :
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
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
                buttonText: 'Sign In',
                onTap: () async {
                  final res = await AuthRemoteRepository().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  final val = switch(res){
                    Left(value: final l) => l,
                    Right(value: final r) => r,
                    
                  };
                  print(val);

                },
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>SignupPage(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: const [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Pallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}