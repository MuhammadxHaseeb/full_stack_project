import 'package:fpdart/fpdart.dart';
import 'package:full_stack_project/features/auth/repository/auth_local_repository.dart';
import 'package:full_stack_project/features/auth/repository/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:full_stack_project/features/auth/model/user_model.dart';

// STEP-BY-STEP GUIDE: wiring a repository method into a Riverpod ViewModel
// (pattern: signUpUser / loginUser)
//
// 1. Method signature:
//    Future<void> yourMethodName({ required <params> }) async { }
//    - Return type is always Future<void> — the STATE carries the result,
//      not the return value.
//
// 2. Guard against duplicate calls while one is already in flight:
//    if (state.isLoading) return;
//
// 3. Set state to loading BEFORE calling the repository:
//    state = const AsyncValue.loading();
//    - This is what flips isLoading to true in the UI.
//
// 4. Call the repository method and store the Either result:
//    final res = await _yourRepository.yourMethod(...);
//    - Repository method MUST return Either<AppFailure, T>
//      (if it doesn't yet, fix the repository first — see repository guide)
//
// 5. Convert the Either into AsyncValue using pattern matching:
//    state = switch (res) {
//      Left(value: final l) => AsyncValue.error(l.message, StackTrace.current),
//      Right(value: final r) => AsyncValue.data(r),
//    };
//
// 6. Done. The UI reacts via ref.listen(yourProvider, (_, next) {
//      next?.when(data: ..., error: ..., loading: ...);
//    });
//    - data    -> success (e.g. show snackbar, navigate)
//    - error   -> failure (e.g. show error snackbar)
//    - loading -> no-op (UI already shows a Loader via ref.watch)
//
// CHECKLIST BEFORE WIRING A NEW FEATURE:
// [ ] Repository method returns Either<AppFailure, T>?
// [ ] ViewModel's AsyncValue<T> type matches repository's Right type?
// [ ] build() sets a sensible initial state (usually AsyncValue.data(null))?
// [ ] UI has ref.watch(...) for loading state + ref.listen(...) for data/error?z


part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  Future <UserModel?> build() async {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }

  Future<void> initSharedPreferences() async{
    await _authLocalRepository.init();
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

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {

    if (state.isLoading) return;

    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
      );
      
      state = switch (res) {
        Left(value: final l) =>AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) =>_loginSuccess(r),
      };
  }

  AsyncValue<UserModel?> _loginSuccess(UserModel user){
    _authLocalRepository.setToken(user.token);
    return state = AsyncValue.data(user);
  }   

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    if(token!=null){
      //TODO:
    }
  }
}
