import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order/order_dto.dart';
import '../../../model/orders/order_status.dart';
import '../order_controller.dart';

class OrderBottomBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;

  const OrderBottomBar({
    super.key,
    required this.controller,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderBottomBarButtom(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          buttonCollor: Colors.blue,
          buttonLabel: 'Finalizar',
          onPressed: order.status == OrderStatus.confirmado
              ? () {
                  controller.changeStatus(OrderStatus.finalizado);
                }
              : null,
          image: 'assets/images/icons/finish_order_white_ico.png',
        ),
        OrderBottomBarButtom(
          borderRadius: BorderRadius.zero,
          buttonCollor: Colors.green,
          buttonLabel: 'Confirmar',
          onPressed: order.status == OrderStatus.pendente
              ? () {
                  controller.changeStatus(OrderStatus.confirmado);
                }
              : null,
          image: 'assets/images/icons/confirm_order_white_icon.png',
        ),
        OrderBottomBarButtom(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          buttonCollor: Colors.red,
          buttonLabel: 'Cancelar',
          onPressed: order.status != OrderStatus.cancelado &&
                  order.status != OrderStatus.finalizado
              ? () {
                  controller.changeStatus(OrderStatus.cancelado);
                }
              : null,
          image: 'assets/images/icons/cancel_order_white_icon.png',
        ),
      ],
    );
  }
}

class OrderBottomBarButtom extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color buttonCollor;
  final String image;
  final String buttonLabel;
  final VoidCallback? onPressed;

  const OrderBottomBarButtom({
    super.key,
    required this.borderRadius,
    required this.buttonCollor,
    required this.image,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(
              color: onPressed != null ? buttonCollor : Colors.transparent,
            ),
            backgroundColor: buttonCollor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(image),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                buttonLabel,
                style: context.textStyles.textBold.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
