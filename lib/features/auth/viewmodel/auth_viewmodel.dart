import 'package:fpdart/fpdart.dart';
import 'package:full_stack_project/features/auth/repository/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:full_stack_project/features/auth/model/user_model.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  final AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();
  @override
  AsyncValue<UserModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {

    if (state.isLoading) return;

    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
      );
      
      state = switch (res) {
        Left(value: final l) =>AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) =>AsyncValue.data(r),
      };
      
  }
}
