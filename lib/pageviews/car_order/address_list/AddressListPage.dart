import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hse/core/model/car_order/CarAddress.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/car_model.dart';
import 'package:provider/provider.dart';

class AdrList extends StatefulWidget {
  @override
  _AdrListState createState() => _AdrListState();
}

class _AdrListState extends State<AdrList> {
  final _formKey = GlobalKey<FormState>();
  String address;

  @override
  Widget build(BuildContext context) {
    var carModel = Provider.of<CarModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.001),
        child: FloatingActionButton(
          onPressed: () {
            Get.dialog(Dialog(
              child: Container(
                height: 150,
                child: Card(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: S.current.nameOfAddress,
                                hintStyle: captionStyle),
                            onSaved: (newValue) => address = newValue,
                          ),
                          RaisedButton(
                            onPressed: () {
                              _formKey.currentState.save();
                              carModel.addContact(CarAddress(address, 0));
                              Get.back();
                            },
                            color: appGreenColor,
                            child: Text(
                              S.current.save,
                              style: generalFontStyle.copyWith(
                                  color: appWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
          },
          child: Icon(Icons.add),
        ),
      ),
      body: FutureBuilder(
        future: Hive.openBox(
          'addressesBox',
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return ContactPage();
            }
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

// мои адреса
class ContactPage extends StatelessWidget {
  final bool isBody;

  ContactPage({this.isBody = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(child: _buildListView(context)),
      ],
    );
  }

  // список адресов
  Widget _buildListView(context) {
    var model = Provider.of<CarModel>(context);
    // ignore: deprecated_member_use
    return WatchBoxBuilder(
      box: Hive.box('addressesBox'),
      builder: (context, addressesBox) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            itemCount: addressesBox.length,
            itemBuilder: (context, index) {
              final contact = addressesBox.getAt(index) as CarAddress;
              var placeController = TextEditingController();
              placeController.text = contact.name;
              return GestureDetector(
                onTap: () {
                  isBody == true
                      ? model.fromController = placeController
                      : null;
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 0.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: appBlueColor, width: 0.2),
                  )),
                  child: ListTile(
                    onTap: !isBody
                        ? null
                        : () {
                            if (model.toFrom) {
                              model.fromController.text = contact.name;
                              model.order.fromAddress = contact.name;
                            } else {
                              model.toController.text = contact.name;
                              model.order.toAddress = contact.name;
                            }
                            model.setBusy(false);
                          },
                    leading: IconButton(
                      icon: Icon(FontAwesomeIcons.solidCircle,
                          color: appBlueColor, size: GFSize.SMALL * 0.5),
                      onPressed: () {},
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(contact.name ?? '', style: namingStyle),
                    ),
                    trailing: IconButton(
                      icon: Icon(FontAwesomeIcons.times,
                          color: appRedColor, size: GFSize.SMALL * 0.7),
                      onPressed: () {
                        addressesBox.deleteAt(index);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
