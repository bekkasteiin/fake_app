import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/viewmodels/bpm_models/event_model.dart';
import 'package:open_file/open_file.dart';
import 'package:hse/core/utils/UI_Helpers.dart';

class EventFilesWidgetSlider extends StatefulWidget {
  final EventModel model;
  final bool editable;

  const EventFilesWidgetSlider(this.model, [this.editable = true]);

  @override
  _EventFilesWidgetSliderState createState() => _EventFilesWidgetSliderState();
}

class _EventFilesWidgetSliderState extends State<EventFilesWidgetSlider> {
  @override
  Widget build(BuildContext context) {
    return widget.model.entity.files != null &&
        widget.model.entity.files.isNotEmpty
        ? Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.model.entity.files.length,
          itemBuilder: (_, index) {
            //  print( File(widget.model.entity.files[index].localPath).lengthSync());
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                children: [
                  InkWell(
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8))),
                      ),
                      child: Container(
                          width:
                          (MediaQuery.of(context).size.width - 32) /
                              2.5,
                          child:
                          // widget.model.entity.files[index].id != null
                          //     ? CachedImage(
                          //         widget.model.entity.files[index].id)
                          //     :
                          widget.model.entity.files[index]
                              .localPath !=
                              null
                              ? Image.file(
                            File(widget.model.entity
                                .files[index].localPath),
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                              "assets/images/no-data.png")),
                    ),
                    onTap: () {
                      print('opened File');
                      if (widget.model.entity.files[index].localPath !=
                          null) {
                        OpenFile.open(
                            widget.model.entity.files[index].localPath);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  child: Image.asset(
                                      'assets/images/no-data.png'),
                                ),
                              );
                            });
                      }
                    },
                  ),
                  widget.editable
                      ? Positioned(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          color: appRedColor,
                          size: 16,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: appRedColor, width: 2),
                            borderRadius:
                            BorderRadius.circular(15)),
                      ),
                      onTap: () => setState(() {
                        widget.model.entity.files.remove(
                            widget.model.entity.files[index]);
                      }),
                    ),
                    right: 5,
                    top: 5,
                  )
                      : SizedBox()
                ],
              ),
            );
          }),
    )
        : Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            LocalIconData.noData,
            width: 30,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.current.noData,
            style: generalFontStyle.copyWith(
                color: appDarkGrayColor, fontSize: defaultFontSize - 2),
          ),
        ],
      ),
    );
  }
}