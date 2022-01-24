import 'package:flutter/material.dart';
import 'package:hse/core/companents/widgets/loader_widget.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';
import 'package:hse/generated/l10n.dart';
import '../../core/utils/UI_Helpers.dart';
import 'components/registry.dart';
import 'components/calendar.dart';

class MessageMobileView extends StatefulWidget {
  const MessageMobileView({Key key}) : super(key: key);

  @override
  _MessageMobileViewState createState() => _MessageMobileViewState();
}

class _MessageMobileViewState extends State<MessageMobileView> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MessageModel>(context);
    var userModel = Provider.of<UserInfoModel>(context);

    return FutureBuilder(
        future: model.getEntities(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              appBar: _appBar(model),
              body: LoaderWidget(),
            );
          }
          loading = false;
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: _appBar(model),
                  body: TabBarView(
                    children: [
                      MessageRegistry(model, userModel),
                      MessageCalendar(model),
                    ],
                  )));
        });
  }

  Widget _appBar(MessageModel model) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.messageRegister,
            style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
          )),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 32,
          ),
          onPressed: () => model.createEntity().then((value) => setState((){})),
        )
      ],
      centerTitle: true,
      bottom: loading
          ? null
          : PreferredSize(
              child: Container(
                child: TabBar(
                  indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.black54,
                  labelColor: appBlueColor,
                  tabs: [
                    Tab(
                      text: S.current.registry,
                    ),
                    Tab(text: S.current.calendar),
                  ],
                ),
                color: Colors.white,
              ),
              preferredSize: Size.fromHeight(45),
            ),
    );
  }
}
