import 'package:mobx/mobx.dart';

import 'package:product_challenge/models/product.dart';
import 'package:product_challenge/services/interfaces/product_service_interfaces.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  late IProductService productService;

  _HomeControllerBase({
    required this.productService,
  }) {
    getList();
  }

  @observable
  ObservableStream<List<ProductModel>>? productList;

  @action
  void getList() {
    productList = productService.get().asObservable();
  }

  @action
  void save(ProductModel productModel) {
    productService.save(productModel);
  }

  @action
  void delete(ProductModel productModel) {
    productService.delete(productModel);
  }

  @action
  Future insertAllProducts() async {
    await productService.insertAllProducts();
  }
}
