import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/viewmodels/orders_viewmodel.dart';
import 'package:shopApp/pages/orders_page/order_card_component.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    OrdersViewModel ordersModel = Provider.of<OrdersViewModel>(context);

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
