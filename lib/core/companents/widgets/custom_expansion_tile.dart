
import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';


class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  CustomExpansionTile({
    Key key,
    this.title,
    this.children,
    this.subtitle,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: Theme.of(context).copyWith(
            accentColor: appBlueColor,
            dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          tilePadding: EdgeInsets.zero,
          title: Text(
            widget.title,
            textAlign: TextAlign.start,
            style: generalFontStyle.copyWith(color: appDarkGrayColor),
          ),
          subtitle: widget.subtitle != null
              ? Text(
            widget.subtitle,
            style: generalFontStyle.copyWith(fontSize: 11.0),
          )
              : null,
          children: widget.children,
          onExpansionChanged: (bool expanding) => setState(() => isExpanded = expanding),
        ),
      ),
    );
  }
}

