import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:http/http.dart' as http;

import 'GoogleMap.dart';
import 'PlaceSearch.dart' as ps;

class WebMapPicker extends StatefulWidget {
  String apiKey;
  final _key = GlobalKey<GoogleMapStateBase>();

  WebMapPicker(this.apiKey);

  @override
  State<StatefulWidget> createState() {
    return OrderState();
  }
}

class OrderState extends State<WebMapPicker> {
  List<ps.Result> searchResultsList = [];
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        centerTitle: true,
        title: Container(
          width: 800,
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: GFSearchBar(
            overlaySearchListItemBuilder: (item) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text(
                      item.formattedAddress,
                      style: generalFontStyle.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              );
            },
            onItemSelected: (item) {
              var location = LocationResult();
              location.name = item.formattedAddress;
              location.formattedAddress = item.formattedAddress;
              location.placeId = item.placeId;
              Get.back(result: location);
            },
            searchQueryBuilder: (String query, List<dynamic> list) {
              search(query);
              return searchResultsList;
            },
            searchList: searchResultsList,
          ),
        ),
        elevation: 2,
      ),
      body: GoogleMap(
        key: widget._key,
        initialZoom: 16,
        initialPosition: GeoCoord(43.27750, 76.89583),
        mapType: MapType.roadmap,
        interactive: true,
        onTap: (coord) {
          tapSelect(coord);
        },
        webPreferences: WebMapPreferences(),
      ),
    );
  }

  void goto(ps.Viewport viewport) {
    if (mounted) {
      GoogleMap.of(widget._key).moveCameraBounds(GeoCoordBounds(
        northeast: GeoCoord(
          viewport.northeast.lat,
          viewport.northeast.lng,
        ),
        southwest: GeoCoord(
          viewport.southwest.lat,
          viewport.southwest.lng,
        ),
      ));
    }
  }

  search(String text) async {
    text = text.replaceAll(RegExp(r' '), '+');

    var url = 'https://maps.googleapis.com/maps/api/geocode/json';

    url = '$url?address=$text';
    url = '$url&key=${widget.apiKey}';
    url = '$url&language=ru';

    var response = await http.get(url);

    var search = ps.PlaceSearch.fromJson(response.body);

    if (search.status != 'OK') {}
    if (search.status == 'OVER_QUERY_LIMIT') {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(S().error),
              content:
                  Text('Google API key request denied or over daily limit'),
            );
          });
    }

    searchResultsList = search?.results ?? [];
    setState(() {});
  }

  void tapSelect(GeoCoord coord) async {
    var url = 'https://maps.googleapis.com/maps/api/geocode/json';

    url = '$url?latlng=${coord.latitude},${coord.longitude}';
    url = '$url&key=${widget.apiKey}';
    url = '$url&language=ru';

    var response = await http.get(url);

    var search = ps.PlaceSearch.fromJson(response.body);

    if (search.status != 'OK') {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(S().error),
              content:
                  Text('Google API key request denied or over daily limit'),
            );
          });
      return;
    }

    searchResultsList = search.results ?? [];

    setState(() {});
  }
}
