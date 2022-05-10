import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:product_challenge/models/product.dart';
import 'package:product_challenge/pages/home_page/controller/home_controller.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends ModularState<ProductItem, HomeController> {
  @override
  Widget build(BuildContext context) {
    ProductModel item = widget.product;

    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/' + item.filename.toString()),
                radius: 50,
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            item.title.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PopupMenuButton(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: const Material(
                                child: Icon(
                                  Icons.more_horiz,
                                ),
                              ),
                            ),
                            enabled: true,
                            onSelected: (value) {
                              print(value);
                              if (value == 'Deletar') {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Deseja realmente excluir o produto ${item.title}?',
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Modular.to.pop();
                                              },
                                              child: const Text('Não')),
                                          TextButton(
                                              onPressed: () {
                                                controller.delete(item);
                                                Modular.to.pop();
                                              },
                                              child: const Text('Sim'))
                                        ],
                                      );
                                    });
                              } else {}
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: 'Editar',
                                  child: Text('Editar'),
                                ),
                                const PopupMenuItem(
                                  value: 'Deletar',
                                  child: Text('Deletar'),
                                )
                              ];
                            }),
                      ],
                    ),
                    Text(
                      item.type.toString(),
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: double.parse(item.rating.toString()),
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 18,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Color(0xFF6558F5)),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {},
                        ),
                        const Spacer(),
                        Text(
                          'R\$ ' + item.price.toString(),
                          style: const TextStyle(fontSize: 14.0),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
