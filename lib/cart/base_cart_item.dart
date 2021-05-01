
import 'package:flutter_shop/product/base_product.dart';

abstract class BaseCartItem{
  BaseProduct product;

  double quantity;

  BaseCartItem(this.product,this.quantity);

  double discount(){

  }
}