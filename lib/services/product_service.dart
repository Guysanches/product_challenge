import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:product_challenge/models/product.dart';
import 'package:product_challenge/repositories/interfaces/product_repository_interface.dart';

import 'interfaces/product_service_interfaces.dart';

class ProductService extends Disposable implements IProductService {
  final IProductRepository productRepository;

  ProductService({
    required this.productRepository,
  });

  @override
  Stream<List<ProductModel>> get() {
    return productRepository.get();
  }

  @override
  Future save(ProductModel productModel) {
    return productRepository.save(productModel);
  }

  @override
  Future delete(ProductModel productModel) {
    return productRepository.delete(productModel);
  }

  @override
  void dispose() {}

  @override
  Future insertAllProducts() async {
    await productRepository.insertAllProducts();
  }
}
