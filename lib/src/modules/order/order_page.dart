import 'package:flutter/material.dart';

import 'widget/order_header.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) {
        return Container(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: const [
              OrderHeader(),
            ],
          ),
        );
      },
    );
  }
}
