import 'package:flutter/material.dart';
import 'package:hse/viewmodels/payment_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'payment_mobile_view.dart';

class PaymentPageView extends StatelessWidget {
  const PaymentPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PaymentModel()),
        ],
        child: Consumer<PaymentModel>(builder: (context, counter, _) {
          return SafeArea(
              top: false,
              child: ScreenTypeLayout(
                mobile: PaymentMobileView(),
                tablet: PaymentMobileView(),
                desktop: PaymentMobileView(), //PaymentDesktopView(),
              ));
        }));
  }
}
