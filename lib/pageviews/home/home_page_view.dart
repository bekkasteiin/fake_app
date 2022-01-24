import 'package:flutter/material.dart';
import 'package:hse/pageviews/home/home_mobile_view.dart';
import 'package:hse/viewmodels/home_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Home()),
      ],
      child: Consumer<Home>(
        builder: (context, counter, _) {
          return HomeMobileView();
        },
      ),
    );
  }
}
