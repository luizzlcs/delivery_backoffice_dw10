import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';

class OrderBottomBar extends StatelessWidget {
  const OrderBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        OrderBottomBarButtom(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          buttonCollor: Colors.blue,
          buttonLabel: 'Finalizar',
          image: 'assets/images/icons/finish_order_white_ico.png',
        ),
        OrderBottomBarButtom(
          borderRadius: BorderRadius.zero,
          buttonCollor: Colors.green,
          buttonLabel: 'Confirmar',
          image: 'assets/images/icons/confirm_order_white_icon.png',
        ),
        OrderBottomBarButtom(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          buttonCollor: Colors.red,
          buttonLabel: 'Cancelar',
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
  const OrderBottomBarButtom({
    super.key,
    required this.borderRadius,
    required this.buttonCollor,
    required this.image,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(
              color: buttonCollor,
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
