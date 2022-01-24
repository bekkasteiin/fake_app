import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hse/core/companents/widgets/loader_widget.dart';

class BaseModel with ChangeNotifier {
  bool _busy = false;
  bool _loaderOpen = false;
  bool isSilent = false;

  bool get busy => _busy;

  void setBusy(bool val, [addRebuild = false]) {
    _busy = val;
    if (_busy) {
      _loaderOpen = true;
      if (!isSilent) {
        Get.dialog(
            LoaderWidget(
              isPop: true,
            ),
            barrierDismissible: false);
      }
    }
    if (!_busy && _loaderOpen) {
      _loaderOpen = false;
      if (!isSilent) {
        Get.back();
      }
    }
    // print(addRebuild);
    if(!addRebuild) {
      notifyListeners();
    }
  }

  void rebuild() => notifyListeners();
}
