// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/unauthorized_exception.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../model/auth_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  AuthRepositoryImpl(this._dio);
  
  @override
  Future<AuthModel> login(String email, String password) async {
    try {
  final result = await _dio.unauth().post(
    '/auth',
    data: {
      'email': email,
      'password': password,
      'admin': true,
    },
  );
  return AuthModel.fromMap(result.data);
} on DioException catch (e, s) {
  if(e.response?.statusCode == 403){
    log('Login ou senha invlálidos', error: e, stackTrace: s);
    throw UnauthorizedException();
  }
  log('Erro ao realizar login', error: e, stackTrace: s);
  throw RepositoryException(message: 'erro ao realizar login');
}
  }
}
