import 'package:hse/core/model/news/News.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/base_model.dart';

class NewsModel extends BaseModel {
  List _news;

  Future<List<News>> get news async {
    _news ??= await RestServices.getNews();
    return _news;
  }
}

class ArchiveModel extends BaseModel {
  List _archive;

  Future<List<News>> get archives async {
    _archive ??= await RestServices.getArchiveNews();
    return _archive;
  }
}
