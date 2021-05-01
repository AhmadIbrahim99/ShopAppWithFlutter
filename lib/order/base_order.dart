import 'package:flutter_shop/cart/base_cart.dart';
import 'package:flutter_shop/payment/base_payment.dart';
import 'package:flutter_shop/user/customer.dart';

abstract class BaseOrder{
  BaseCart cart;
  Customer customer;
  BasePayment payment;

  BaseOrder(this.cart, this.customer, this.payment);

  double total(){
    
  }
}