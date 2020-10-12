import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/orders_model.dart';
import 'package:shopApp/pages/drawer/drawer_view.dart';
import 'package:shopApp/pages/orders_page/order_card_component.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrdersModel ordersModel = Provider.of<OrdersModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Suas compras'),
      ),
      drawer: DrawerView(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderCard(ordersModel.orders[index]);
        },
        itemCount: ordersModel.orders.length,
      ),
    );
  }
}
