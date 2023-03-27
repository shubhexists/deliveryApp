// ignore_for_file: prefer_is_empty, avoid_print

import 'dart:convert';
// import 'dart:typed_data';

import 'package:delapp/Screens/hhjjh.dart';
import 'package:delapp/Screens/initFucntions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class POIAlongRouteWidget extends StatefulWidget {
  const POIAlongRouteWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return POIAlongRouteWidgetState();
  }
}

class POIAlongRouteWidgetState extends State {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(25.321684, 82.987289),
    zoom: 8.0,
  );
  //  Future<void> addImageFromAsset(String name, String assetName) async {
  //   final ByteData bytes = await rootBundle.load(assetName);
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   return controller.addImage(name, list);
  // }

  addMarker(a, b) async {
    controller.addSymbol(SymbolOptions(geometry: LatLng(a, b)));
  }

  // TextEditingController sourceController =
  //     TextEditingController(text: origin_text);
  // TextEditingController destinationController =
  //     TextEditingController(text: "28.554676,77.186982");
  TextEditingController keywordController =
      TextEditingController(text: "FODCOF");

  List<SuggestedPOI> result = [];
  bool isShowList = false;

  late MapmyIndiaMapController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      MapmyIndiaMap(
        initialCameraPosition: _kInitialPosition,
        onMapCreated: (map) => {
          controller = map,
        },
        onStyleLoadedCallback: () {
          // callDirection(TextEditingController(text: origin_text),
          //     TextEditingController(text: "28.554676,77.186982"));
          for (int i = 0; i < OrderLocation.length - 1; i++) {
            addMarker(OrderLocationList[i][0], OrderLocationList[i][1]);
            callDirection(TextEditingController(text: OrderLocation[i]),
                TextEditingController(text: OrderLocation[i + 1]));
          }
        },
      ),
      result.length > 0 && isShowList
          ? BottomSheet(
              onClosing: () => {},
              builder: (context) => Expanded(
                  child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(5),
                              focusColor: Colors.white,
                              title: Text(result[index].address ?? ''),
                            ));
                      })))
          : Container()
    ]);
  }

  callDirection(TextEditingController sourceController,
      TextEditingController destinationController) async {
    try {
      setState(() {
        result = [];
      });
      controller.clearLines();
      controller.clearSymbols();
      LatLng? source;
      String? sourceEloc;
      LatLng? destination;
      String? destinationEloc;

      if (sourceController.text.length == 0 ||
          destinationController.text.length == 0 ||
          keywordController.text.length == 0) {
        return;
      }
      if (sourceController.text.contains(",")) {
        source = LatLng(
          double.parse(sourceController.text.split(",")[0]),
          double.parse(sourceController.text.split(",")[1]),
        );
      } else {
        sourceEloc = sourceController.text;
      }
      if (destinationController.text.contains(",")) {
        destination = LatLng(
          double.parse(destinationController.text.split(",")[0]),
          double.parse(destinationController.text.split(",")[1]),
        );
      } else {
        destinationEloc = destinationController.text;
      }

      DirectionResponse? directionResponse = await MapmyIndiaDirection(
              origin: source,
              originELoc: sourceEloc,
              destination: destination,
              destinationELoc: destinationEloc)
          .callDirection();
      if (directionResponse != null &&
          directionResponse.routes != null &&
          directionResponse.routes!.length > 0) {
        Polyline polyline = Polyline.Decode(
            encodedString: directionResponse.routes![0].geometry, precision: 6);
        List<LatLng> latLngList = [];
        if (polyline.decodedCoords != null) {
          polyline.decodedCoords?.forEach((element) {
            latLngList.add(LatLng(element[0], element[1]));
          });
        }
        drawPath(latLngList);
        callPOIAlongRoute(directionResponse.routes![0]);
      }
    } on PlatformException catch (e) {
      print(e.code);
    }
  }

  void drawPath(List<LatLng> latlngList) {
    controller.addLine(
        LineOptions(geometry: latlngList, lineColor: "#3bb2d0", lineWidth: 6));
    LatLngBounds latLngBounds = boundsFromLatLngList(latlngList);
    controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
  }

  boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  void callPOIAlongRoute(DirectionsRoute directionsRoute) async {
    await addImageFromAsset("icon", "assets/avatar.jpg");

    await controller.clearSymbols();
    PoiAlongRouteResponse? poiAlongRouteResponse =
        await MapmyIndiaPOIAlongRoute(
                path: directionsRoute.geometry!,
                category: keywordController.text,
                buffer: 300)
            .callPOIAlongRoute();
    if (poiAlongRouteResponse != null &&
        poiAlongRouteResponse.suggestedPOIs != null &&
        poiAlongRouteResponse.suggestedPOIs!.length > 0) {
      setState(() {
        result = poiAlongRouteResponse.suggestedPOIs!;
      });
      List<SymbolOptions> options = [];
      poiAlongRouteResponse.suggestedPOIs?.forEach((element) {
        // print('${element.placeName} (${element.distance})');
        print(json.encode(element.toJson()));
        options.add(SymbolOptions(
            geometry: LatLng(element.latitude!, element.longitude!),
            iconImage: 'icon'));
      });
      controller.addSymbols(options);
    }
  }
}
