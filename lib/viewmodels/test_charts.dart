import 'package:hse/core/model/graphics/OrdinalSales.dart' as mod;
import 'package:hse/core/model/graphics/OrdinalSales.dart';
import 'package:hse/core/model/graphics/OverCategoryGraphic.dart';
import 'package:hse/core/model/graphics/RightAnswersGraphic.dart';
import 'package:hse/core/model/graphics/SubmittedGraphic.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/base_model.dart';
import 'package:intl/intl.dart' show DateFormat;

class TestChartsModel extends BaseModel {
  RightAnswersGraphic rightAnswersGraphic;
  SubmittedGraphic submittedGraphic;
  List<OverCategoryGraphic> overCategoryGraphic;

  Future<RightAnswersGraphic> get rightAnswers async {
    rightAnswersGraphic ??= await RestServices.getTestingGraphicRightAnswers();
    return rightAnswersGraphic;
  }

  Future<List<OverCategoryGraphic>> get categoryAnswers async {
    overCategoryGraphic ??=
        await RestServices.getTestingGraphicOverCategoryList();
    return overCategoryGraphic;
  }

  Future<SubmittedGraphic> get disciplineResults async {
    submittedGraphic ??= await RestServices.getTestingSubmittedGraphic();
    return submittedGraphic;
  }

  Future<List<List<mod.OrdinalSales>>> getProgressData() async {
    var data = <mod.OrdinalSales>[];
    var data2 = <mod.OrdinalSales>[];

    var graphicRes = await rightAnswers;
    var value = graphicRes.percent.toDouble();

    data.add(mod.OrdinalSales(percent: (100 - value).toDouble()));
    data2.add(mod.OrdinalSales(percent: value));

    var list = <List<mod.OrdinalSales>>[];
    list.add(data);
    list.add(data2);
    return list;
  }

  // Future<List<List<OverSales>>> getProgressByCategoryData() async {
  //   var data = <OverSales>[];
  //   var data2 = <OverSales>[];
  //
  //   var graphicRes = await categoryAnswers;
  //   graphicRes.forEach((f) {
  //     data.add(OverSales(
  //         percent: (f.percent).toDouble(),
  //         day: '${f.category} ${f.percent.toInt()}%'));
  //     data2.add(OverSales(
  //         percent: (100 - f.percent).toDouble(),
  //         day: '${f.category} ${f.percent.toInt()}%'));
  //   });
  //
  //   return [data, data2];
  // }

  Future<List<List<mod.OrdinalSales>>> getDisciplineProgress() async {
    var data = <OrdinalSales>[];
    var data2 = <OrdinalSales>[];

    var graphicRes = await disciplineResults;
//        await TestingRest().getTestingSubmittedGraphic();
    data.add(OrdinalSales(percent: 100 - graphicRes.percent));
    data2.add(OrdinalSales(percent: graphicRes.percent));

    return [data, data2];
  }

  String periodName(String percent) {
    return '${S().period} ${DateFormat('yMMM').format(DateTime.now())}';
  }

  String periodNameData(String percent) {
    return '${DateFormat('yMMMM').format(DateTime.now())}';
  }

  String periodCategoryName() {
    var count = pCatName();
    return '${S().period} ${DateFormat('yMMM').format(DateTime.now())}';
  }

  String periodCategoryNameData() {
    var count = pCatName();
    return '${DateFormat('yMMMM').format(DateTime.now())}';
  }

  double pCatName() {
    var count = 0.0;
    overCategoryGraphic.forEach((element) => count += element.percent);
    count = count / overCategoryGraphic.length;
    if (count.isNaN) {
      count = 0;
    }
    return count;
  }
}
