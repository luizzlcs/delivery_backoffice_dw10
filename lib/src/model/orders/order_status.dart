import 'package:flutter/material.dart';

enum OrderStatus {
  pendente(name: 'Pendente', acronym: 'P', color: Colors.blue),
  confirmado(name: 'Confirmado', acronym: 'C', color: Colors.green),
  finalizado(name: 'Finalizado', acronym: 'D', color: Colors.black),
  cancelado(name: 'Cancelado', acronym: 'R', color: Colors.red),
  ;

  final String name;
  final String acronym;
  final Color color;

  const OrderStatus({
    required this.name,
    required this.acronym,
    required this.color,
  });

  static OrderStatus pasrse(String acronym) {
    return values.firstWhere((s) => s.acronym == acronym);
  }
}
