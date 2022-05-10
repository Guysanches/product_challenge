import 'package:product_challenge/models/product.dart';

abstract class IProductService {
  Stream<List<ProductModel>> get();
  Future save(ProductModel productModel);
  Future delete(ProductModel productModel);
  Future insertAllProducts();
}
