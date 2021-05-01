import 'package:flutter_shop/cart/base_cart_item.dart';

abstract class BaseCart{

  List<BaseCartItem> items;
  BaseCart(this.items);


}