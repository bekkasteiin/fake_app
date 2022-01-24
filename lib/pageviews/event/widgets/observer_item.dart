import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class ObserverItem extends StatelessWidget {
  final Person person;
  final bool current;
  const ObserverItem(this.person, this.current);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color:  current ? appBlueColor.withOpacity(0.2) : null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(person.firstName + ' ' + person.lastName, style: generalFontStyle.copyWith(fontSize: defaultFontSize - 1),),
        trailing: current ? Icon(Icons.check_circle_outline, color: appBlueColor,) : null,
      ),
    );
  }
}
