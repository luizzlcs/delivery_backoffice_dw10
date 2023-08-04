import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../model/orders/order_status.dart';
import '../../model/orders/order_model.dart';
import './order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final CustomDio _dio;

  OrderRepositoryImpl(this._dio);
  @override
  Future<void> changeStatus(int id, OrderStatus status) async {
    try {
      await _dio.auth().put(
        '/orders/$id',
        data: {
          'status': status.acronym,
        },
      );
    } on DioException catch (e, s) {
      log(
        'Erro ao alterar status do pedido para ${status.acronym}',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao alterar status do pedido para ${status.acronym}',
      );
    }
  }

  @override
  Future<List<OrderModel>> findAllOrders(
    DateTime date, [
    OrderStatus? status,
  ]) async {
    try {
      final orderResponse = await _dio.auth().get(
        '/orders',
        queryParameters: {
          'data': date.toIso8601String(),
          if (status != null) 'status': status.acronym,
        },
      );

      return orderResponse.data.map<OrderModel>((o) => OrderModel.fromMap(o)).toList();
    } on DioException catch (e, s) {
      log(
        'Erro ao buscar pedidos',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao buscar pedidos',
      );
    }
  }

  @override
  Future<OrderModel> getById(int id) async {
    try {
      final orderResponse = await _dio.auth().get(
            '/orders/$id',
          );

      return OrderModel.fromMap(orderResponse.data);
    } on DioException catch (e, s) {
      log(
        'Erro ao buscar pedido',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao buscar pedido',
      );
    }
  }
}
