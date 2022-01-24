import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

/// @author yeras-is

String langValue = '';

class LocationResult {
  String name; // or road

  String locality;

  LatLng latLng;

  String formattedAddress;

  String placeId;
}

class NearbyPlace {
  String name;

  String icon;

  LatLng latLng;
}

class AutoCompleteItem {
  String id;

  String text;

  int offset;

  int length;
}

class PlacePicker extends StatefulWidget {
  final String apiKey;

  PlacePicker(this.apiKey);

  @override
  State<StatefulWidget> createState() {
    return PlacePickerState();
  }
}

/// Place picker state
class PlacePickerState extends State<PlacePicker> {
  /// Initial waiting location for the map before the current user location
  /// is fetched.
  static final LatLng initialTarget = LatLng(5.5911921, -0.3198162);

  final Completer<GoogleMapController> mapController = Completer();

  /// Indicator for the selected location
  final Set<Marker> markers = Set()
    ..add(
      Marker(
        position: initialTarget,
        markerId: MarkerId("Выберите метоположение"),
      ),
    );

  /// Result returned after user completes selection
  LocationResult locationResult;

  /// Overlay to display autocomplete suggestions
  OverlayEntry overlayEntry;

  List<NearbyPlace> nearbyPlaces = List();

  /// Session token required for autocomplete API call
  String sessionToken = Uuid().v4();

  GlobalKey appBarKey = GlobalKey();

  bool hasSearchTerm = false;

  String previousSearchTerm = '';

  // constructor
  PlacePickerState();

  void onMapCreated(GoogleMapController controller) {
    this.mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    this.overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserInfoModel>(context);
    langValue = model.locale.languageCode;
    return Scaffold(
      appBar: AppBar(
        key: this.appBarKey,
        title: SearchInput((it) {
          searchPlace(it);
        }),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialTarget,
                zoom: 15,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              onTap: (latLng) {
                clearOverlay();
                moveToLocation(latLng);
              },
              markers: markers,
            ),
          ),
          this.hasSearchTerm
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SelectPlaceAction(getLocationName(), () {
                      Navigator.of(context).pop(this.locationResult);
                    }),
                  ],
                ),
        ],
      ),
    );
  }

  void clearOverlay() {
    if (this.overlayEntry != null) {
      this.overlayEntry.remove();
      this.overlayEntry = null;
    }
  }

  void searchPlace(String place) {
    if (place == this.previousSearchTerm) {
      return;
    } else {
      previousSearchTerm = place;
    }

    if (context == null) {
      return;
    }

    clearOverlay();

    setState(() {
      hasSearchTerm = place.length == 0;
    });

    if (place.length < 1) {
      return;
    }

    final RenderBox renderBox = context.findRenderObject();
    Size size = renderBox.size;

    final RenderBox appBarBox =
        this.appBarKey.currentContext.findRenderObject();

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarBox.size.height,
        width: size.width,
        child: Material(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Text(
                    "Нахождение места...",
                    style: generalFontStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(this.overlayEntry);

    autoCompleteSearch(place);
  }

  void autoCompleteSearch(String place) {
    place = place.replaceAll(" ", "+");
    var endpoint =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?language=$langValue&" +
            "key=${widget.apiKey}&" +
            "input={$place}&sessiontoken=${this.sessionToken}";

    if (this.locationResult != null) {
      endpoint += "&location=${this.locationResult.latLng.latitude}," +
          "${this.locationResult.latLng.longitude}";
    }
    http.get(endpoint).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> predictions = data['predictions'];

        List<RichSuggestion> suggestions = [];

        if (predictions.isEmpty) {
          AutoCompleteItem aci = AutoCompleteItem();
          aci.text = "Результатов не найдено";
          aci.offset = 0;
          aci.length = 0;

          suggestions.add(RichSuggestion(aci, () {}));
        } else {
          for (dynamic t in predictions) {
            AutoCompleteItem aci = AutoCompleteItem();

            aci.id = t['place_id'];
            aci.text = t['description'];
            aci.offset = t['matched_substrings'][0]['offset'];
            aci.length = t['matched_substrings'][0]['length'];

            suggestions.add(RichSuggestion(aci, () {
              FocusScope.of(context).requestFocus(FocusNode());
              decodeAndSelectPlace(aci.id);
            }));
          }
        }

        displayAutoCompleteSuggestions(suggestions);
      }
    }).catchError((error) {
      print(error);
    });
  }

  void decodeAndSelectPlace(String placeId) {
    clearOverlay();

    String endpoint =
        "https://maps.googleapis.com/maps/api/place/details/json?language=$langValue&key=${widget.apiKey}" +
            "&placeid=$placeId";

    http.get(endpoint).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> location =
            jsonDecode(response.body)['result']['geometry']['location'];

        LatLng latLng = LatLng(location['lat'], location['lng']);

        moveToLocation(latLng);
      }
    }).catchError((error) {
      print(error);
    });
  }

  /// Display autocomplete suggestions with the overlay.
  void displayAutoCompleteSuggestions(List<RichSuggestion> suggestions) {
    final RenderBox renderBox = context.findRenderObject();
    Size size = renderBox.size;

    final RenderBox appBarBox =
        this.appBarKey.currentContext.findRenderObject();

    clearOverlay();

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: appBarBox.size.height,
        child: Material(
          elevation: 1,
          color: Colors.white,
          child: Column(
            children: suggestions,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(this.overlayEntry);
  }

  String getLocationName() {
    if (this.locationResult == null) {
      return "Безымянное место";
    }

    for (NearbyPlace np in this.nearbyPlaces) {
      if (np.latLng == this.locationResult.latLng &&
          np.name != this.locationResult.locality) {
        this.locationResult.name = np.name;
        return "${np.name}, ${this.locationResult.locality}";
      }
    }

    return "${this.locationResult.formattedAddress.split(",")[0]}";
  }

  void setMarker(LatLng latLng) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("selected-location"),
          position: latLng,
        ),
      );
    });
  }

  void getNearbyPlaces(LatLng latLng) {
    http
        .get(
            "https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=$langValue"
                    "&key=${widget.apiKey}&" +
                "location=${latLng.latitude},${latLng.longitude}&radius=150")
        .then((response) {
      if (response.statusCode == 200) {
        this.nearbyPlaces.clear();
        for (Map<String, dynamic> item
            in jsonDecode(response.body)['results']) {
          NearbyPlace nearbyPlace = NearbyPlace();

          nearbyPlace.name = item['name'];
          nearbyPlace.icon = item['icon'];
          double latitude = item['geometry']['location']['lat'];
          double longitude = item['geometry']['location']['lng'];

          LatLng _latLng = LatLng(latitude, longitude);

          nearbyPlace.latLng = _latLng;

          this.nearbyPlaces.add(nearbyPlace);
        }
      }

      setState(() {
        this.hasSearchTerm = false;
      });
    }).catchError((error) {});
  }

  void reverseGeocodeLatLng(LatLng latLng) {
    http
        .get(
            "https://maps.googleapis.com/maps/api/geocode/json?language=$langValue&"
            "latlng=${latLng.latitude},${latLng.longitude}"
            "&key=${widget.apiKey}")
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);

        final result = responseJson['results'][0];

        String road = result['address_components'][0]['short_name'];
        String locality = result['address_components'][1]['short_name'];

        setState(() {
          this.locationResult = LocationResult();
          this.locationResult.name = road;
          this.locationResult.locality = locality;
          this.locationResult.latLng = latLng;
          this.locationResult.formattedAddress = result['formatted_address'];
          this.locationResult.placeId = result['place_id'];
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  void moveToLocation(LatLng latLng) {
    this.mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 15.0,
          ),
        ),
      );
    });

    setMarker(latLng);

    reverseGeocodeLatLng(latLng);
  }

  void moveToCurrentUserLocation() {
    var location = Location();
    location.getLocation().then((locationData) {
      LatLng target = LatLng(locationData.latitude, locationData.longitude);
      moveToLocation(target);
    }).catchError((error) {
      print(error);
    });
  }
}

class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  SearchInput(this.onSearchInput);

  @override
  State<StatefulWidget> createState() {
    return SearchInputState();
  }
}

class SearchInputState extends State<SearchInput> {
  TextEditingController editController = TextEditingController();

  Timer debouncer;

  bool hasSearchEntry = false;

  SearchInputState();

  @override
  void initState() {
    super.initState();
    this.editController.addListener(this.onSearchInputChange);
  }

  @override
  void dispose() {
    this.editController.removeListener(this.onSearchInputChange);
    this.editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (this.editController.text.isEmpty) {
      this.debouncer?.cancel();
      widget.onSearchInput(this.editController.text);
      return;
    }

    if (this.debouncer?.isActive ?? false) {
      this.debouncer.cancel();
    }

    this.debouncer = Timer(Duration(milliseconds: 500), () {
      widget.onSearchInput(this.editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Поиск места",
                border: InputBorder.none,
              ),
              controller: this.editController,
              onChanged: (value) {
                setState(() {
                  this.hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          this.hasSearchEntry
              ? GestureDetector(
                  child: Icon(
                    Icons.clear,
                  ),
                  onTap: () {
                    this.editController.clear();
                    setState(() {
                      this.hasSearchEntry = false;
                    });
                  },
                )
              : SizedBox(),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
    );
  }
}

class SelectPlaceAction extends StatelessWidget {
  final String locationName;
  final VoidCallback onTap;

  SelectPlaceAction(this.locationName, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          this.onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      locationName,
                      style: generalFontStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Нажмите, чтобы выбрать это место",
                      style: generalFontStyle.copyWith(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RichSuggestion extends StatelessWidget {
  final VoidCallback onTap;
  final AutoCompleteItem autoCompleteItem;

  RichSuggestion(this.autoCompleteItem, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(children: getStyledTexts(context)),
                  ),
                )
              ],
            )),
        onTap: this.onTap,
      ),
    );
  }

  List<TextSpan> getStyledTexts(BuildContext context) {
    final List<TextSpan> result = [];

    String startText =
        this.autoCompleteItem.text.substring(0, this.autoCompleteItem.offset);
    if (startText.isNotEmpty) {
      result.add(
        TextSpan(
          text: startText,
          style: generalFontStyle.copyWith(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
      );
    }

    var boldText = this.autoCompleteItem.text.substring(
        this.autoCompleteItem.offset,
        this.autoCompleteItem.offset + this.autoCompleteItem.length);

    result.add(TextSpan(
      text: boldText,
      style: generalFontStyle.copyWith(
        color: Colors.black,
        fontSize: 15,
      ),
    ));

    var remainingText = this
        .autoCompleteItem
        .text
        .substring(this.autoCompleteItem.offset + this.autoCompleteItem.length);
    result.add(
      TextSpan(
        text: remainingText,
        style: generalFontStyle.copyWith(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
    );

    return result;
  }
}
