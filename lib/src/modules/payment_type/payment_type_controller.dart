import 'dart:developer';
import 'package:mobx/mobx.dart';
import '../../model/payment_type_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
part 'payment_type_controller.g.dart';

enum PaymentStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  
  final PaymentTypeRepository _paymentTypeRepository;

  @readonly
  var _status = PaymentStateStatus.initial;

  @readonly
  var _paymentType = <PaymentTypeModel>[];

  @readonly
  String? _errorMessage;

  PaymentTypeControllerBase(this._paymentTypeRepository);

  @action
  Future<void> loadPayment() async {
    try {
      _status = PaymentStateStatus.loading;
      _paymentType = await _paymentTypeRepository.findAll(null);
      _status = PaymentStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar as ofrmas de pagamento.', error: e, stackTrace: s);
      _status = PaymentStateStatus.error;
      _errorMessage = 'Erro ao carregar as ofrmas de pagamento.';
    }
  }
}
