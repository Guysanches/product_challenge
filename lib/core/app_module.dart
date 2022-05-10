import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:product_challenge/pages/home_page/home_page.dart';
import 'package:product_challenge/pages/splash_page/splash_page.dart';
import 'package:product_challenge/services/product_service.dart';

import '../pages/home_page/controller/home_controller.dart';
import '../repositories/interfaces/product_repository_interface.dart';
import '../repositories/product_repository.dart';
import '../services/interfaces/product_service_interfaces.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<IProductService>(
            (i) => ProductService(productRepository: i.get())),
        Bind<IProductRepository>((i) =>
            ProductRepository(firebaseFirestore: FirebaseFirestore.instance)),
        Bind((i) => HomeController(productService: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ChildRoute('/home_page', child: (context, args) => const HomePage()),
      ];
}
