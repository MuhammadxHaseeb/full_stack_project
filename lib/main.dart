import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_stack_project/core/providers/current_user_notifier.dart';
// import 'package:full_stack_project/features/auth/view/pages/signup_page.dart';
import 'package:full_stack_project/core/theme/theme.dart';
import 'package:full_stack_project/features/auth/view/pages/signup_page.dart';
import 'package:full_stack_project/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:full_stack_project/features/home/view/pages/home_page.dart';
import 'package:full_stack_project/features/home/view/pages/upload_song_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  await container.read(authViewmodelProvider.notifier).getData();

  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
      ),
    );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Music App',
      theme: AppTheme.darkThemeMode,
      home: currentUser == null ? const SignupPage(): const UploadSongPage(),
    );
  }
}