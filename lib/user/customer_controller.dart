import 'package:flutter_shop/order/base_order.dart';
import 'package:flutter_shop/product/base_product.dart';
import 'package:flutter_shop/user/customer.dart';
import 'package:flutter_shop/user/user.dart';

class CustomerController{

  Customer customer;


  CustomerController(this.customer);

  void addToOrders(BaseOrder order){
    customer.orders.add(order);
  }

  void addToWatchList(BaseProduct product){
    customer.watchList.add(product);
  }

  bool orderInOrders(BaseOrder order){
    return customer.orders.contains(order);
  }

  bool productInWatchList(BaseProduct product){
    return customer.watchList.contains(product);
  }

  bool removeProductFromWatchList(BaseProduct product){
    return customer.watchList.remove(product);
  }

}