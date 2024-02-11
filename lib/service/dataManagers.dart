import 'dart:convert';

import 'package:tender_app/model/datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];
  fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = response.body;
      _menu = [];
      var decodeData = jsonDecode(body) as List<dynamic>;
      for (var json in decodeData) {
        _menu?.add(Category.fromJson(json));
      }
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }

  cartAdd(Product p) {
    int found = cart.indexWhere((item) => item.product.id == p.id);

    if (found >= 0) {
      cart[found].quantity++;
    } else {
      cart.add(ItemInCart(product: p, quantity: 1));
      print('added: ${p.name}');
      print('added: ${p.id}');
      print(cart);
    }
  }

  cartRemove(Product p) {
    cart.removeWhere((item) {
      if (item.product.id == p.id) {
        if (item.quantity > 1) {
          item.quantity--;
          return false;
        }
        print('removed: ${p.id}');
        return true;
      }
      return false;
    });
    print(cart);
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    var total = 0.0;
    for (var item in cart) {
      total += item.quantity * item.product.price;
    }
    return total;
  }
}

class HttpException implements Exception {
  final String massage;

  HttpException(this.massage);

  @override
  String toString() {
    return massage;

    /// return super.toString(); // Instance of [HttpException]
  }
}
