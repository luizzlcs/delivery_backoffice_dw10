// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../model/orders/order_status.dart';
import '../../model/orders/user_model.dart';
import '../../model/payment_type_model.dart';
import '../../dto/order/order_product_dto.dart';

class OrderDto {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final List<OrderProductDto> orderProduct;
  final UserModel user;
  final String address;
  final String cpf;
  final PaymentTypeModel paymentTypeModel;
  OrderDto({
    required this.id,
    required this.date,
    required this.status,
    required this.orderProduct,
    required this.user,
    required this.address,
    required this.cpf,
    required this.paymentTypeModel,
  });
  
  
}
