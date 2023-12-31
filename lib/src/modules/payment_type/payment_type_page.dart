import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messagens.dart';
import 'payment_type_form/payment_type_form_modal.dart';
import 'widgets/payment_type_header.dart';
import 'package:flutter/material.dart';

import 'widgets/payment_type_item.dart';
import 'payment_type_controller.dart';

class PaymentTypePage extends StatefulWidget {
  const PaymentTypePage({super.key});

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage>
    with Loader, Messagens {
  final controller = Modular.get<PaymentTypeController>();

  final disposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filterDisposer = reaction((_) => controller.filterEnabled, (_) {
        controller.loadPayment();
      });
      final statusDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case PaymentStateStatus.initial:
            break;
          case PaymentStateStatus.loading:
            showLoader();
            break;
          case PaymentStateStatus.loaded:
            hideLoader();
            break;
          case PaymentStateStatus.error:
            hideLoader();
            showError(
              controller.errorMessage ?? 'Erro ao buscar formas de pagamentos',
            );
            break;
          case PaymentStateStatus.addOrUpdatePayment:
            hideLoader();
            showAddOrUpdatePayment();
            break;
          case PaymentStateStatus.saved:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            controller.loadPayment();
            break;
        }
      });
      disposers.addAll([statusDisposer, filterDisposer]);
      controller.loadPayment();
    });
  }

  @override
  void dispose() {
    for (final dispose in disposers) {
      dispose();
    }
    super.dispose();
  }

  void showAddOrUpdatePayment() {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: PaymentTypeFormModal(
              model: controller.paymentTypeSelected,
              controller: controller,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          PaymentTypeHeader(controller: controller),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return GridView.builder(
                  itemCount: controller.paymentType.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 120,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    maxCrossAxisExtent: 680,
                  ),
                  itemBuilder: (context, index) {
                    final paymentTypeModel = controller.paymentType[index];
                    return PaymentTypeItem(
                      payment: paymentTypeModel,
                      controller: controller,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
