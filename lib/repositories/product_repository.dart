import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:product_challenge/models/product.dart';
import 'package:product_challenge/repositories/interfaces/product_repository_interface.dart';

class ProductRepository extends Disposable implements IProductRepository {
  final FirebaseFirestore firebaseFirestore;
  ProductRepository({
    required this.firebaseFirestore,
  });

  @override
  Stream<List<ProductModel>> get() {
    return firebaseFirestore.collection('product').snapshots().map((query) =>
        query.docs.map((doc) => ProductModel.fromDocument(doc)).toList());
  }

  @override
  Future save(ProductModel productModel) async {
    if (productModel.reference == null) {
      await FirebaseFirestore.instance
          .collection('product')
          .add(productModel.toMap());
    } else {
      productModel.reference?.update(productModel.toMap());
    }
  }

  @override
  Future delete(ProductModel productModel) {
    return productModel.reference!.delete();
  }

  @override
  void dispose() {}

  @override
  Future insertAllProducts() async {
    final String response =
        await rootBundle.loadString('assets/mocks/products.json');

    Iterable data = await json.decode(response);

    List<ProductModel> products =
        List<ProductModel>.from(data.map((item) => ProductModel.fromMap(item)));

    for (var element in products) {
      element = element.copyWith(created: DateTime.now());
      await FirebaseFirestore.instance
          .collection('product')
          .add(element.toMap());
    }
  }
}
