import '../../dto/order/order_product_dto.dart';
import '../../model/orders/order_model.dart';
import '../../dto/order/order_dto.dart';
import '../../model/orders/user_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/products/product_repository.dart';
import '../../model/payment_type_model.dart';
import './get_order_by_id.dart';

class GetOrderByIdImpl extends GetOrderById {
  final PaymentTypeRepository _paymentTypeRepository;
  final UserRepository _userRepository;
  final ProductRepository _productRepository;

  GetOrderByIdImpl(
    this._paymentTypeRepository,
    this._userRepository,
    this._productRepository,
  );
  @override
  Future<OrderDto> call(OrderModel order) => _orderDtoParse(order);

  Future<OrderDto> _orderDtoParse(OrderModel order) async {
    final paymentTypeFuture =
        _paymentTypeRepository.getById(order.paymentTypeId);
    final userFuture = _userRepository.getById(order.userId);
    final orderProductsFuture = _orderProductParse(order);

    final response =
        await Future.wait([paymentTypeFuture, userFuture, orderProductsFuture]);

    return OrderDto(
      id: order.id,
      date: order.date,
      status: order.status,
      orderProduct: response[2] as List<OrderProductDto>,
      user: response[1] as UserModel,
      address: order.address,
      cpf: order.cpf,
      paymentTypeModel: response[0] as PaymentTypeModel,
    );
  }

  Future<List<OrderProductDto>> _orderProductParse(OrderModel order) async {
    final orderProducts = <OrderProductDto>[];
    final productFutures = order.orderProducts
        .map((e) => _productRepository.getProduct(e.productId))
        .toList();

    final products = await Future.wait(productFutures);

    for (var i = 0; i < order.orderProducts.length; i++) {
      final orderProduct = order.orderProducts[i];
      final productDto = OrderProductDto(
        product: products[i],
        amount: orderProduct.amount,
        totalPrice: orderProduct.totalPrice,
      );
      orderProducts.add(productDto);
    }
    return orderProducts;
  }
}
