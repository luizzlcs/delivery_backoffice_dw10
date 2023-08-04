  import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
  
  class OrderHeader extends StatelessWidget {
  
    const OrderHeader({ super.key });
  
     @override
     Widget build(BuildContext context) {
         return BaseHeader(title: 'Administrar Pedidos', addButton: false,
         filterWindget: DropdownButton<bool?>(
        value: enabled,
        items: const [
          DropdownMenuItem(value: null, child: Text('Todos')),
          DropdownMenuItem(value: true, child: Text('Ativos')),
          DropdownMenuItem(value: false, child: Text('Inativos')),
        ],
        onChanged: (value) {
          widget.controller.changeFilter(value);
          setState(() {
            enabled = value;
            widget.controller.changeFilter(value);
          });
        },
      ),
         );
  }}