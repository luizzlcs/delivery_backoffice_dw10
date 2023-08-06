import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../model/orders/order_model.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyles;
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Pedido',
                    style: textStyle.textBold,
                  ),
                  Text(
                    '1',
                    style: textStyle.textExtraBold,
                  ),
                  Expanded(
                    child: Text(
                      order.status.name,
                      textAlign: TextAlign.end,
                      style: textStyle.textExtraBold.copyWith(
                        fontSize: 20,
                        color: order.status.color,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                    height: double.infinity,
                  )
                ],
              ),
            ),
          ),
        ),
        const VerticalDivider(
          thickness: 1,
          color: Colors.grey,
        )
      ],
    );
  }
}
