import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:full_stack_project/features/auth/view/pages/signup_page.dart';
import 'package:full_stack_project/core/theme/theme.dart';
import 'package:full_stack_project/features/auth/view/pages/signup_page.dart';
import 'package:full_stack_project/features/auth/viewmodel/auth_viewmodel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const SignupPage(),
    );
  }
}