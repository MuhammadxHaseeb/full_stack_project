import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:full_stack_project/core/widgets/loader.dart';
import 'package:full_stack_project/features/auth/view/pages/login_page.dart';
import 'package:full_stack_project/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:full_stack_project/features/auth/view/widgets/custom_field.dart';
import 'package:full_stack_project/core/theme/app_pallete.dart';
import 'package:full_stack_project/features/auth/viewmodel/auth_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    // final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;
    
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
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const LoginPage(),),);
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
            return const Loader();
          },
          );
      });

    return Scaffold(
      appBar: AppBar(),
      body: 
      // isLoading ? const Loader() :
       Padding(
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
                onTap: ()  async {
                  if (formKey.currentState!.validate()){

                  await ref.read(authViewmodelProvider.notifier).signUpUser(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    );

                  }
                },
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>LoginPage(),
                    ),
                  );
                },
                child: RichText(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}