import 'package:flutter/material.dart';
import 'package:tender_app/model/datamodel.dart';

import '../constants.dart';

class CartItemWidget extends StatelessWidget {
  final ItemInCart item;
  final void Function(Product p) onRemove;
  final void Function(Product p) onAdd;

  const CartItemWidget(
      {required this.item, required this.onRemove, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.white, offset: Offset(0, 0))
      ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // width: MediaQuery.of(context).size.width * 0.31,
            padding: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 0),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Image.network(
              item.product.imageUrl,
              width: MediaQuery.of(context).size.width * 0.31,
              height: MediaQuery.of(context).size.width * 0.31,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "\$${(item.product.price * item.quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: sunset_orange,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${item.quantity}x",
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: black_90,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      onAdd(item.product);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
                      child: Icon(
                        Icons.add_circle_rounded,
                        color: tahiti,
                        size: 30,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onRemove(item.product);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
                      child: Icon(
                        Icons.remove_circle,
                        color: silver,
                        size: 30,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
