import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/sheet/SettlenetSheet.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/payment_model.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class PaymentDesktopView extends StatefulWidget {
  @override
  _PaymentDesktopViewState createState() => _PaymentDesktopViewState();
}

class _PaymentDesktopViewState extends State<PaymentDesktopView> {
  var other;

  @override
  void dispose() {
    super.dispose();
    if (other != null) other.close();
  }

  @override
  Widget build(BuildContext context) {
    var namingStyle = Theme.of(context).textTheme.subtitle1;
    var captionStyle = Theme.of(context).textTheme.caption;
    return Consumer<PaymentModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(title: Center(child: Text(S().salary))),
        //drawer: isDesktop(context) ? null : AppDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  S().paymentPaper,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.4,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...model.map((e) {
                              return GestureDetector(
                                onTap: () {
                                  if (kIsWeb) {
                                    other = html.window.open(
                                        Kinfolk.getFileUrl(e.fileId), 'asd');
                                  }
                                  counter.lookUp(e, kIsWeb);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/payment_logo.png'),
                                            width: GFSize.MEDIUM,
                                            height: GFSize.MEDIUM,
                                            color: appBlueColor,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  '${S().period}:',
                                                  style: captionStyle,
                                                ),
                                                subtitle: Text(
                                                  getCodeLang(e.period),
                                                  style: namingStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/testing_logo.png'),
                                            width: GFSize.MEDIUM,
                                            height: GFSize.MEDIUM,
                                            color: appBlueColor,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  '${S().createTs}:',
                                                  style: captionStyle,
                                                ),
                                                subtitle: Text(
                                                  formatOnlyDate(e.date),
                                                  style: namingStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      );
                    })),
              ),
            ],
          ),
        ),
      );
    });
  }
}
