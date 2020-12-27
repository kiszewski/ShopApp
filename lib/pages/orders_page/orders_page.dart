import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/pages/orders_page/order_card_component.dart';
import 'package:shopApp/viewmodels/order_viewmodel.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    OrderViewModel _orderViewModel =
        Provider.of<OrderViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
        backgroundColor: Colors.white12,
        title: Text(
          'Suas compras',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      drawer: DrawerView(),
      body: StreamBuilder<List<OrderModel>>(
        stream: _orderViewModel.orders,
        initialData: [],
        builder: (context, snapshot) {
          return snapshot.data.isEmpty
              ? Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 100,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/shop.png'),
                      Text(
                        'Sem compras registradas',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return OrderCard(snapshot.data[index]);
                  },
                );
        },
      ),
    );
  }
}
