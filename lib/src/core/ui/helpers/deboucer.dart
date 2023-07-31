// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';

class Deboucer {
  final int milliseconds;
  Timer? time;

  Deboucer({required this.milliseconds});

  void call(VoidCallback callback) {
    time?.cancel();
    time = Timer(Duration(microseconds: milliseconds), callback);
  }
}
