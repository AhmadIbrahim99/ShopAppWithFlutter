
import 'package:flutter_shop/product/base_product.dart';

abstract class BaseCartItem{
  BaseProduct product;

  double quantity;

  BaseCartItem(this.product,this.quantity);

  BaseCartItem.fromJson(Map<String,dynamic>jsonObject){
    this.product=BaseProduct.fromJson(jsonObject['product']);
    this.quantity=jsonObject['quantity'];
  }

  double discount(){

  }
}