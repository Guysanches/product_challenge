import '../../models/product.dart';

abstract class IProductRepository {
  Stream<List<ProductModel>> get();
  Future save(ProductModel productModel);
  Future delete(ProductModel productModel);
  Future insertAllProducts();
}
