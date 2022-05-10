import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:product_challenge/models/product.dart';
import 'package:product_challenge/pages/home_page/controller/home_controller.dart';

import 'widgets/product_item_widget/product_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9DFF5),
      appBar: AppBar(
        title: const Center(
          child: Text('Produtos'),
        ),
      ),
      body: Observer(
        builder: (context) {
          if (controller.productList?.value?.isEmpty == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text('Não há produtos para serem exibidos'),
                  ElevatedButton(
                      onPressed: () async {
                        await controller.insertAllProducts();
                      },
                      child: const Text('Carregar produtos')),
                ],
              ),
            );
          }

          if (controller.productList?.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<ProductModel> items = controller.productList!.data;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemExtent: 120,
            itemCount: items.length,
            itemBuilder: (_, index) {
              return ProductItem(
                product: items[index],
              );
            },
          );
        },
      ),
    );
  }
}
