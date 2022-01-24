import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:get/get.dart';
import 'package:hse/core/model/sheet/SettlenetSheet.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:kinfolk/kinfolk.dart';

class PaymentPdfViewWidget extends StatefulWidget {
  PaymentPdfViewWidget(this.fileId, this.e);

  String fileId;
  SettlenetSheet e;

  @override
  _PaymentPdfViewWidgetState createState() => _PaymentPdfViewWidgetState();
}

class _PaymentPdfViewWidgetState extends State<PaymentPdfViewWidget> {
  bool _isLoading = true;
  PDFDocument document;
  String fileUrl;

  @override
  void initState() {
    super.initState();
    loadValue();
  }

  void loadValue() async {
    // fileUrl = Kinfolk.getFileUrl(widget.fileId);
    document = await PDFDocument.fromAsset('assets/fake/fake-data.pdf');
    setState(() => _isLoading = false);
  }

  void saveToStorage() async {
    // var name =
    //     'Payment-${getCodeLang(widget.e.period)}-${formatOnlyDate(widget.e.date)}';
    // var file = await RestServices.downloadFile(
    //   fileUrl,
    //   name,
    //   downloads: true,
    //   folder: 'LK',
    // );
    var message = '${S.current.successfully}\n Имя документа fake-data.pdf';
    Get.snackbar(S.current.attention, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => saveToStorage(),
          )
        ],
      ),
      body: Center(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: PDFViewer(
                      showIndicator: true,
                      showPicker: false,
                      showNavigation: true,
                      document: document,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
