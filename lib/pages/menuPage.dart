import 'package:flutter/material.dart';
import 'package:tender_app/service/dataManagers.dart';
import 'package:tender_app/widgets/product_item.dart';

import '../constants.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataManager.getMenu(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //the future has finshed.data is ready
          var categories = snapshot.data!;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(categories[index].name,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.6,
                        )),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories[index].products.length,
                      itemBuilder: ((context, proadIndex) {
                        var product = categories[index].products[proadIndex];
                        return ProductItemWidget(
                          product: product,
                          onAdd: (addedProduct) {
                            print(addedProduct.name);
                            print(addedProduct.id);
                            dataManager.cartAdd(addedProduct);
                          },
                        );
                      }))
                ],
              );
            },
          );
        } else {
          if (snapshot.hasError) {
            //Data is not there,beacause there is error
            return const Text("there was an error");
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Color(colorPrimary)),
              ),
            );
          }
        }
      },
    );
  }
}
