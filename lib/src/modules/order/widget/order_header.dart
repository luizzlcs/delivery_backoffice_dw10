import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import '../../../model/orders/order_status.dart';
import '../order_controller.dart';

class OrderHeader extends StatefulWidget {
  final OrderController controller;

  const OrderHeader({
    super.key,
    required this.controller,
    });

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  OrderStatus? statusSelected;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Administrar Pedidos',
      addButton: false,
      filterWindget: DropdownButton<OrderStatus?>(
        value: statusSelected,
        items: [
          const DropdownMenuItem(value: null, child: Text('Todos')),
          ...OrderStatus.values
              .map((s) => DropdownMenuItem(value: s, child: Text(s.name)))
              .toList()
        ],
        onChanged: (value) {
          setState(() {
            widget.controller.changeSatusFilter(value);
            statusSelected = value;
          });
        },
      ),
    );
  }
}
