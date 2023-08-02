import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

import '../../../model/product_model.dart';
import '../../../repositories/products/product_repository.dart';
part 'product_detail_controller.g.dart';

enum ProductDetailStateStatus {
  initial,
  loading,
  loaded,
  error,
  errorLoadProduct,
  deleted,
  uploaded,
  saved,
}

class ProductDetailController = ProductDetailControllerBase
    with _$ProductDetailController;

abstract class ProductDetailControllerBase with Store {
  final ProductRepository _productRepository;

  @readonly
  var _status = ProductDetailStateStatus.initial;

  @readonly
  String? _erroMessage;

  @readonly
  String? _imagePath;

  ProductDetailControllerBase(this._productRepository);

  @action
  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    _status = ProductDetailStateStatus.loading;
    _imagePath = await _productRepository.uploadImageProduct(file, fileName);
    _status = ProductDetailStateStatus.uploaded;
  }

  Future<void> save(String name, double price, String description)async {
    try {
  ProductDetailStateStatus.loading;
  final productModel = ProductModel(  
    name: name,
    description: description,
    price: price,
    enabled: true,
    image: _imagePath!,
  );
  
    await _productRepository.save(productModel);
    _status = ProductDetailStateStatus.saved;  
} catch (e, s) {
  log('Erro ao salvar produto', error: e, stackTrace: s);
  _status = ProductDetailStateStatus.error;
  _erroMessage = 'Erro ao salvar o produto';

   
}
  }
}
