import 'package:get/get.dart';
import 'package:hse/core/model/sheet/SettlenetSheet.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/pageviews/payment/payment_pdf_page.dart';
import 'package:hse/viewmodels/base_model.dart';

class PaymentModel extends BaseModel {
  List _list;

  Future<List<SettlenetSheet>> get list async {
    _list ??= await RestServices.getSettlenetSheet();
    return _list;
  }

  void lookUp(SettlenetSheet e, bool kIsWeb) {
    if (!e.seen) {
      RestServices.setSeen(e.fileId);
    }
    if (kIsWeb) {
      return;
    }
    Get.to(PaymentPdfViewWidget(e.fileId, e));
  }
}
