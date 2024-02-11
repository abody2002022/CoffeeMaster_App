import 'package:flutter/material.dart';

import 'package:tender_app/service/dataManagers.dart';

import '../constants.dart';
import '../model/datamodel.dart';
import '../widgets/cart_item.dart';

class OrderPage extends StatefulWidget {
  final DataManager dataManager;
  const OrderPage({super.key, required this.dataManager});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String adress = "";
  String phone = "";
  String value = "";
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.dataManager.cart);
    if (widget.dataManager.cart.isEmpty) {
      return const Center(
        child: Icon(
          Icons.not_interested_rounded,
          size: 120,
          color: vermilion_10,
        ),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
            itemCount: widget.dataManager.cart.length,
            itemBuilder: ((context, index) {
              var item = widget.dataManager.cart[index];
              return CartItemWidget(
                  item: item,
                  onAdd: (product) {
                    setState(() {
                      widget.dataManager.cartAdd(product);
                    });
                  },
                  onRemove: (product) {
                    setState(() {
                      widget.dataManager.cartRemove(product);
                    });
                  });
            })),
        bottomSheet: Container(
          alignment: Alignment.bottomCenter,
          height: 70,
          color: alabaster,
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'CANCEL',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                widget.dataManager.cartClear();
                                setState(() {});
                                Navigator.pop(context);
                              }
                            },
                            child: Text('ACCEPT',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                            var height = MediaQuery.of(context).size.height;
                            var width = MediaQuery.of(context).size.width;

                            return Container(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Enter Name'),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[a-z A-Z]+$')
                                                .hasMatch(value)) {
                                          //allow upper and lower case alphabets and space
                                          return "Enter Correct Name";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Enter Phone Number'),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                                .hasMatch(value)) {
                                          //  r'^[0-9]{10}$' pattern plain match number with length 10
                                          return "Enter Correct Phone Number";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              height: height - 450,
                              width: width - 400,
                            );
                          },
                        ),
                      ));
            },
            style: TextButton.styleFrom(
              backgroundColor: sunset_orange,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(colorPrimary)),
            ),
          ),
        ),
      );
    }
  }
}

class OrderItem extends StatelessWidget {
  final ItemInCart item;
  final Function onRemove;
  const OrderItem({Key? key, required this.item, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("${item.quantity}x"),
                    )),
                Expanded(
                    flex: 6,
                    child: Text(
                      item.product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                        "\$${(item.product.price * item.quantity).toStringAsFixed(2)}")),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          onRemove(item.product);
                        },
                        icon: const Icon(Icons.delete)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
