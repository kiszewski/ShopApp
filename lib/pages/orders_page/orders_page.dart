import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/orders_model.dart';
import 'package:shopApp/pages/home_page/components/drawer_view.dart';

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
          Order order = ordersModel.orders[index];

          return ListTile(
            title: Text('R\$ ${order.totalOrder.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat('dd/M/y H:m').format(order.date)),
          );
        },
        itemCount: ordersModel.orders.length,
      ),
    );
  }
}
