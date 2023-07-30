import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../../model/product_model.dart';
import '../../../../repositories/products/product_repository.dart';
part 'products_controller.g.dart';

enum ProductStateStatus{
  initial,
  loading,
  loaded,
  error,
}

class ProductsController = ProductsControllerBase with _$ProductsController;

abstract class ProductsControllerBase with Store {
  final ProductRepository _productRepository;

  ProductsControllerBase(this._productRepository);
  
  @readonly
  var _status = ProductStateStatus.initial;

  @readonly
  var _product = <ProductModel>[];

  @readonly
  String? _filterName;

  @action
  void loadProducts()async{
    try {
  _status = ProductStateStatus.loaded;
  _product = await _productRepository.findAll(_filterName);
  _status = ProductStateStatus.loaded;
} on DioException catch (e, s) {
  log('Erro ao buscar produto', error: e, stackTrace: s);
  _status = ProductStateStatus.error;
  throw '';
}


  }



}