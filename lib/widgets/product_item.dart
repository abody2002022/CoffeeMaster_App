import 'package:flutter/material.dart';
import 'package:tender_app/model/datamodel.dart';

import '../constants.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final void Function(Product p) onAdd;

  const ProductItemWidget({required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      padding: const EdgeInsets.all(6),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.27,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(color: Colors.white, offset: Offset(0, 0))
              ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '${(product.price).roundToDouble()} \$',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: sunset_orange,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onAdd(product);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
                          child: Ink(
                            color: Colors.orangeAccent,
                            child: Icon(
                              Icons.add_circle,
                              color: vermilion_100,
                              size: 40,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(product.imageUrl),
          )
        ],
      ),
    );
  }
}
