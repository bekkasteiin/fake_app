
import 'package:flutter/material.dart';
import 'package:hse/core/utils/UI_Helpers.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  final bool value;
  final Function onChanged;

  const CustomCheckboxListTile(
      {Key key,
        @required this.title,
        @required this.value,
        this.onChanged,
        this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: appBlueColor,
          toggleableActiveColor: appBlueColor,
        ),
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.trailing,
          title: title,
          value: value,
          onChanged: onChanged,
          subtitle: subTitle,
          checkColor: appBlueColor,
          activeColor: appYellowColor,
        ),
      ),
    );
  }
}
