
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/model/assignment/Department.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class DepartmentItem extends StatelessWidget {
  final Department department;
  final bool current;
  const DepartmentItem(this.department, this.current);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color:  current ? appBlueColor.withOpacity(0.2) : null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // tileColor: current ? appBlueColor.withOpacity(0.3) : null,
        title: Text(department.departmentName, style: generalFontStyle.copyWith(fontSize: defaultFontSize - 1),),
        trailing: current ? Icon(Icons.check_circle_outline, color: appBlueColor,) : null,
      ),
    );
  }
}
