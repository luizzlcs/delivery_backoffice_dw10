import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';

class OdrderInfoTile extends StatelessWidget {
  final String label;
  final String info;

  const OdrderInfoTile({super.key, required this.label, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: context.textStyles.textBold,
          ),
          const SizedBox(
             width:8 ,
          ),
          Text(info, style: context.textStyles.textMidium),
        ],
      ),
    );
  }
}
