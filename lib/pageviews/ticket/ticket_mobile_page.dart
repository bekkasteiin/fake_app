import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/loader_widget.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/ticket/components/history.dart';
import 'package:hse/pageviews/ticket/components/scan_qr_page.dart';
import 'package:hse/viewmodels/bpm_models/ticket_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'components/ticket_main.dart';

class TicketMobilePage extends StatefulWidget {
  const TicketMobilePage({Key key}) : super(key: key);

  @override
  _TicketMobilePageState createState() => _TicketMobilePageState();
}

class _TicketMobilePageState extends State<TicketMobilePage> {
  bool loading = true;
  bool canShowQRScanner = true;

  @override
  void initState() {
    _getCameraPermission();
    super.initState();
  }

  void _getCameraPermission() async {
    print(await Permission.camera.status); // prints PermissionStatus.granted
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() {
          canShowQRScanner = true;
        });
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Please enable camera to scan barcodes')));
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        canShowQRScanner = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TicketModel>(context);
    var userModel = Provider.of<UserInfoModel>(context);

    return FutureBuilder(
        future: model.getMyTicketHistory(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              appBar: _appBar(model),
              body: LoaderWidget(),
            );
          }
          loading = false;
          return DefaultTabController(
              length: 3,
              child: Scaffold(
                  // resizeToAvoidBottomInset: false,
                  // resizeToAvoidBottomPadding: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: _appBar(model),
                  body: TabBarView(
                    children: [
                      TicketMain(model),
                      TicketHistory(model, userModel),
                      ScanQrPage(model)
                    ],
                  )));
        });
  }

  Widget _appBar(TicketModel model) {
    return AppBar(
      title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Предупредительные талоны',
            style: generalFontStyle.copyWith(fontSize: defaultFontSize + 2),
          )),
      centerTitle: false,
      bottom: loading
          ? null
          : PreferredSize(
              child: Container(
                child: TabBar(
                  indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.black54,
                  labelColor: appBlueColor,
                  tabs: [
                    Tab(text: 'Основная'),
                    Tab(text: 'История'),
                    Tab(text: 'Мероприятия'),
                  ],
                ),
                color: Colors.white,
              ),
              preferredSize: Size.fromHeight(45),
            ),
    );
  }
}
