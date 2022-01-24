import 'package:flutter/material.dart';
import 'package:hse/pageviews/car_order/car_order_mobile_view.dart';
import 'package:hse/viewmodels/car_model.dart';
import 'package:provider/provider.dart';

class CarOrderPage extends StatelessWidget {
  const CarOrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CarModel()),
        ],
        child: Consumer<CarModel>(builder: (context, counter, _) {
          return SafeArea(
            top: false,
            child: CarOrderMobileView(),
          );
        }));
  }
}
