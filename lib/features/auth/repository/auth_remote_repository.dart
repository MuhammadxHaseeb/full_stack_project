import 'package:fpdart/fpdart.dart';
import 'package:full_stack_project/features/auth/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:full_stack_project/core/failure/failure.dart';

// STEP-BY-STEP GUIDE: implementing login() like signup()
//
// 1. Change return type from Future<void> to Future<Either<AppFailure, UserModel>>
//
// 2. Keep the try/catch wrapper (already have this)
//
// 3. Keep the http.post() call as is (already correct)
//
// 4. Decode the response body into a Map:
//    final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
//
// 5. Check response.statusCode — confirm with backend what success code is
//    (signup uses 201, login is usually 200 — VERIFY, don't assume)
//
// 6. If statusCode is NOT the success code:
//    return Left(AppFailure(resBodyMap['detail']?.toString() ?? 'Login failed'));
//
// 7. If statusCode IS the success code:
//    return Right(UserModel.fromJson(response.body));
//
// 8. In the catch block, keep:
//    return Left(AppFailure(e.toString()));
//
// 9. Remove the print() debug statements — no longer needed
//    since the Either return value now carries this info to the caller

class AuthRemoteRepository {
  final String baseUrl = 'http://192.168.18.19:8000';

  Future<Either<AppFailure,UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201)
      {
        // handled the error
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(UserModel.fromJson(response.body));
    }
     catch (e) {  
        return Left(AppFailure(e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");
    } catch (e) {
      print("Exception: $e");
    }
  }
}