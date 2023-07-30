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
  addOrUpdatePayment,
  saved,
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
  @readonly
  bool? _filterEnabled;

  @readonly
  PaymentTypeModel? _paymentTypeSelected;

  PaymentTypeControllerBase(this._paymentTypeRepository);

  @action
  void changeFilter(bool? enabled) => _filterEnabled = enabled;

  @action
  Future<void> loadPayment() async {
    try {
      _status = PaymentStateStatus.loading;
      _paymentType = await _paymentTypeRepository.findAll(_filterEnabled);
      _status = PaymentStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar as formas de pagamento.', error: e, stackTrace: s);
      _status = PaymentStateStatus.error;
      _errorMessage = 'Erro ao carregar as formas de pagamento.';
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = null;
    _status = PaymentStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> editPayment(PaymentTypeModel payment) async {
    _status = PaymentStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = payment;
    _status = PaymentStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    int? id,
    required String name,
    required String acronym,
    required bool enabled,
  }) async {
    _status = PaymentStateStatus.loading;
    final paymentTaypeModel = PaymentTypeModel(
      id: id,
      name: name,
      acronym: acronym,
      enabled: enabled,
    );
   await _paymentTypeRepository.save(paymentTaypeModel);
   _status = PaymentStateStatus.saved;
  }
}
