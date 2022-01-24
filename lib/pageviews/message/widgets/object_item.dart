
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/model/message/object_name.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class ObjectItem extends StatelessWidget {
  final ObjectName objectName;
  final bool current;
  const ObjectItem(this.objectName, this.current);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color:  current ? appBlueColor.withOpacity(0.2) : null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // tileColor: current ? appBlueColor.withOpacity(0.3) : null,
        title: Text(objectName.langValue, style: generalFontStyle.copyWith(fontSize: defaultFontSize - 1),),
        trailing: current ? Icon(Icons.check_circle_outline, color: appBlueColor,) : null,
      ),
    );
  }
}
