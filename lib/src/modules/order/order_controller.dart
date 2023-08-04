import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../model/orders/order_model.dart';
import '../../model/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';
part 'order_controller.g.dart';

enum OrderStateStatus{
  initial,
  loading,
  loaded,
  error,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;
  @readonly
  var _status = OrderStateStatus.initial;

  late final DateTime _today;

  @readonly
  OrderStatus? _statusFilter;

  @readonly
  String? _errorMessage;

  @readonly
  var _orders = <OrderModel>[];

  OrderControllerBase(this._orderRepository){
    final todayNow =  DateTime.now();
    _today =DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  Future<void>findOrders() async {
    try {
  _status = OrderStateStatus.loading;
  _orders = await _orderRepository.findAllOrders(_today, _statusFilter);
  _status = OrderStateStatus.loaded;
} catch (e, s) {
  log('Erro ao buscar pedidos dos dia', error: e, stackTrace: s);
  _status = OrderStateStatus.error;
  _errorMessage ='Erro ao buscar pedidos dos dia';
}

  }


}