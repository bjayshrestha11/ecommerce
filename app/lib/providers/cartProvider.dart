import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/models/cartItem.dart';
import 'package:app/models/product.dart';
import 'package:app/services/db_services.dart';
import 'package:app/utilities/utils.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartList = [];
  CartItem _cartItem;

  List<CartItem> get cartList => _cartList;

  void setCartList(List<CartItem> carts) {
    _cartList = carts;
    print("Cart List Updated - ${carts.length}");
  }

  Future<bool> _containItem(Product product, String userId,
      {int quantity = 1}) async {
    CartItem cartItem = CartItem(
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.salePrice,
        quantity: quantity,
        productId: product.id,
        userId: userId);
    final cartStream = await cartItemDb.getQueryList(args: [
      QueryArgs("userId",userId),
    ]);
    for (int i = 0; i < cartStream.length; i++) {
      if (cartItem.name == cartStream[i].name) {
        _cartItem = cartStream[i];
        return true;
      }
    }
    return false;
  }

  void addToCart(Product product, String userId, {int quantity = 1}) async {
    if (userId == null) {
      Utils.showToast("Login To Add & View Cart");
    } else if (await _containItem(product, userId)) {
      // Utils.showToast("Already on the cart");
      incrementCart(_cartItem);
       Utils.showToast("${_cartItem.name}(${_cartItem.quantity + 1}) is updated to cart");
    } else {
      CartItem cartItem = CartItem(
          id: null,
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.salePrice,
          quantity: quantity,
          productId: product.id,
          userId: userId);
      cartItemDb.createItem(cartItem);
      Utils.showToast("${product.name}(${cartItem.quantity}) is added to cart");
    }
    notifyListeners();
  }

  void deleteCartAt(int index, int price, String id) {
    cartItemDb.removeItem(id);
    Utils.showToast("Removed from cart");
    notifyListeners();
  }

  void incrementCart(CartItem cartItem)async {
    CartItem upcartItem = CartItem(
        id: cartItem.id,
        name: cartItem.name,
        imageUrl: cartItem.imageUrl,
        price: cartItem.price,
        quantity: cartItem.quantity + 1,
        productId: cartItem.productId,
        userId: cartItem.userId);
    await cartItemDb.updateItem(upcartItem);
    notifyListeners();
  }

  void decrementCart(CartItem cartItem) async {
    int newQuantity = cartItem.quantity - 1;
    if (newQuantity == 0) {
      cartItemDb.removeItem(cartItem.id);
    } else {
      CartItem upcartItem = CartItem(
          id: cartItem.id,
          name: cartItem.name,
          imageUrl: cartItem.imageUrl,
          price: cartItem.price,
          quantity: cartItem.quantity - 1,
          productId: cartItem.productId,
          userId: cartItem.userId);
      await cartItemDb.updateItem(upcartItem);
    }
    notifyListeners();
  }

  void deleteCart() {
    for (int i = 0; i < _cartList.length; i++) {
      cartItemDb.removeItem(_cartList[i].id);
    }
    notifyListeners();
  }
}
