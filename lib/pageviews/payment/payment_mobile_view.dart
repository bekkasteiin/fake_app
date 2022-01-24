import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/sheet/SettlenetSheet.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/payment_model.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';

import 'payment_pdf_web_view.dart';

class PaymentMobileView extends StatefulWidget {
  @override
  _PaymentMobileViewState createState() => _PaymentMobileViewState();
}

class _PaymentMobileViewState extends State<PaymentMobileView> {
  var other;

  @override
  void dispose() {
    super.dispose();
    if (other != null) other.close();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S().salary,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            ),
          ),
          actions: [SaveButton()],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: FutureProvider<List<SettlenetSheet>>(
                      create: (BuildContext context) => counter.list,
                      initialData: null,
                      child: Consumer<List<SettlenetSheet>>(
                          builder: (context, model, _) {
                        if (model == null) {
                          return GFLoader(
                            type: GFLoaderType.ios,
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...model.map((e) {
                                return GestureDetector(
                                    onTap: () {
                                      // var bytes =
                                      //     await RestServices.downloadFileData(
                                      //         Kinfolk.getFileUrl(e.fileId));
                                      // if (kIsWeb) {
                                      //   Get.to(PaymentPdfWebView(
                                      //       e.fileId, e, bytes));
                                      // }
                                      counter.lookUp(e, kIsWeb);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: appBlueColor,
                                                  width: 0.2))),
                                      child: ListTile(
                                        leading: Icon(
                                          FontAwesomeIcons.creditCard,
                                          color: appBlueColor,
                                          size: GFSize.SMALL,
                                        ),
                                        title: Text(
                                            '${S().paymentPaper} ' +
                                                'за ' +
                                                getCodeLang(e.period) +
                                                ' ' +
                                                formatOnlyYear(e.date),
                                            style: namingStyle),
                                        subtitle: Text(formatOnlyDate(e.date),
                                            style: captionStyle),
                                      ),
                                    ));
                              }).toList()
                            ],
                          ),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
      child: Center(
        child: GestureDetector(
          //onTap: () => Get.dialog(LimitsDialog()),
          child: kIsWeb
              ? Padding(
            padding: const EdgeInsets.fromLTRB(2, 2, 10, 2),
            child: Icon(
              FontAwesomeIcons.save,
              size: GFSize.SMALL*0.7,
            ),
          )
              : Icon(
            FontAwesomeIcons.tags,
            size: GFSize.SMALL*0.7,
          ), //Image.asset('assets/images/limitsIcon.png'),
        ),
      ),
    );
  }
}