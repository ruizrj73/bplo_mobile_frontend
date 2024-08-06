// ignore_for_file: prefer_const_constructors, unnecessary_new, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/local_db.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_webservice/places.dart';

import '../utils/notification_header.dart';

String googleMapsApiKey = "AIzaSyA2qpdmeajmyuUW_l5cBV6pT3VFA8E6-hk";

class GoogleMapView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const GoogleMapView();
  @override
  GoogleMapViewState createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {
  UserController userController = Get.find();
  String gMapApiKey = googleMapsApiKey;
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleMapsApiKey);
  String locationAddr = '';
  // ignore: non_constant_identifier_names
  TextEditingController AddrController = TextEditingController();
  final loc.Location _locationTracker = loc.Location();
  Circle circle;
  GoogleMapController _controller;
  BitmapDescriptor pinLocationIcon;
  static const LatLng _center = LatLng(10.309841, 123.893172);
  LatLng _lastMapPosition = _center;
  final MapType _currentMapType = MapType.normal;
  final List<Marker> _markers = [];
  BitmapDescriptor pinIcon;
  // Address locationInfo = consumerController.addr.value;
  LatLng searchedCoordinates;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(72, 112)), 'assets/images/pin72x112.png')
        .then((onValue) {
      pinIcon = onValue;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: buildPage(),
      onWillPop: () {
        Get.back();
        return;
      },
    );
  }

  Widget buildPage() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("Search Location", style: TextStyle(fontSize: 12)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: SizedBox(
            height: 50, 
            child: addressViewSearch()
          ) 
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: buttonSection(),
      body: bodyView());
  }

  Widget bodyView() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          googleMap(),
        ],
      ),
    );
  }

  Stack googleMap() {
    return Stack(
      children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight + 110),
        child: GoogleMap(
          mapType: _currentMapType,
          initialCameraPosition: const CameraPosition(
            target: LatLng(10.293119, 123.901778),
            zoom: 16.0,
          ),
          circles: Set.of((circle != null) ? [circle] : []),
          markers: _markers.toSet(),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          buildingsEnabled: false,
          onCameraMove: _onCameraMove,
          onCameraIdle: _onCameraIdle,
        )
      ),
    ]);
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("./assets/mc_icon.png");
    return byteData.buffer.asUint8List();
  }

  Future<String> _getLocationAddress(double latitude, double longitude) async {
    try {
      Placemark placeMark = (await placemarkFromCoordinates(latitude, longitude))[0];
      String street = placeMark.street;
      String locality = placeMark.locality;
      String subAdministrativeArea = placeMark.subAdministrativeArea;
      String postalCode = placeMark.postalCode;
      String country = placeMark.country;

      return placeMark == null ? "": "$street, $locality, $subAdministrativeArea, $postalCode, $country";
    } catch (ex) {
      return "";
    }
  }

  Future<void> _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
    if (searchedCoordinates != null) {
      final marker = Marker(
        markerId: MarkerId('0'),
        position: LatLng(searchedCoordinates.latitude, searchedCoordinates.longitude),
        icon: pinIcon,
      );

      _markers.add(marker);
      setState(() {
        _markers.first = _markers.first.copyWith(positionParam: searchedCoordinates);
      });
      animateCamera(searchedCoordinates.latitude, searchedCoordinates.longitude);
      _getLocationAddress(searchedCoordinates.latitude, searchedCoordinates.longitude)
          .then((value) {
        locationAddr = value;
      });
      searchedCoordinates = null;
    } else {
      _locationTracker.getLocation().then((locationData) {
        animateCamera(locationData.latitude, locationData.longitude);
        _getLocationAddress(locationData.latitude, locationData.longitude)
            .then((value) {
          locationAddr = value;
        });
        final marker = Marker(
          markerId: MarkerId('0'),
          position: LatLng(locationData.latitude, locationData.longitude),
          icon: pinIcon,
        );

        _markers.add(marker);
      });
    }
  }

  Widget addressViewSearch() {
    return InkWell(
      onTap: () async {
        Prediction p = await PlacesAutocomplete.show(
            context: context,
            apiKey: gMapApiKey,
            onError: onError,
            mode: Mode.fullscreen,
            language: "en",
            types: [],
            strictbounds: false,
            logo: Container(),
            decoration: InputDecoration(
              hintText: 'Search Location',
              filled: true,
              fillColor: Colors.white,
              focusColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            components: [Component(Component.country, "ph")],
          );
          displayPrediction(p);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(MaterialIcons.search),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                AddrController.text,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                )
              )
            )
          ],
        ),
      ),
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    // ignore: avoid_print
    print(response.errorMessage);
  }

  Future<void> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      searchedCoordinates = LatLng(lat, lng);
      animateCamera(lat, lng);
    }
  }

  animateCamera(double latitude, double longitude, {double zoom = 16.0}) {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latitude, longitude),
            tilt: 0,
            zoom: zoom),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;

    setState(() {
      _markers.first = _markers.first.copyWith(positionParam: position.target);
    });
  }

  void _onCameraIdle() {
    _getLocationAddress(_lastMapPosition.latitude, _lastMapPosition.longitude)
        .then((value) {
      if (value != "") {
        setState(() {
          AddrController.value = TextEditingValue(
            text: value,
            selection: TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          );
        });
      }
    });
  }
  
  Widget buttonSection() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: ThemeColor.primary,
        minimumSize: Size(MediaQuery.of(context).size.width, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () async {
        EasyLoading.show();

        BusinessApplication businessApplication = userController.activeBusinessApplication.value;
        businessApplication.business_latitude = _lastMapPosition.latitude.toString();
        businessApplication.business_longitude = _lastMapPosition.longitude.toString();
        businessApplication.business_actual_address = AddrController.text;

        if (userController.getConnectivityStatus() == "Online") {
          EasyLoading.show();
          
          await updateBusinessApplication(businessApplication).then((value) {
            EasyLoading.dismiss();
            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
              Navigator.pop(context);
            });
          });
        } else if (userController.getConnectivityStatus() == "Offline") {
          EasyLoading.show();

          await LocalDB().localInsertBusinessApplication(businessApplication).then((value) {
            EasyLoading.dismiss();
            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
              Navigator.pop(context);
            });
          });
        }
      },
      child: Text(
        'Get Coordinates',
        style: TextStyle(
            color: ThemeColor.primaryText, fontWeight: FontWeight.w800, fontSize: 16),
      ),
    );
  }
}
