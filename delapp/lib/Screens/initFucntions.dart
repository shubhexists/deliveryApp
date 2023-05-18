// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, file_names

import 'dart:convert';

import 'package:delapp/Screens/mapRountApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:http/http.dart" as http;
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String mapurl = "";
var name;
var phone;
var totalDeliveries;
var onTimeDeliveries;
var avgRating;
var Star;
var origin;
var vendor;
var origin_text;
var currentOrder;
var OrderLocation = [origin_text];
var OrderLocationList = [];
var currentOrderDetails;
var currentRoundDetails = [];
var jsonData;
List VendorLocationList = [];
List Markers = [];
var FinalLocationList = [origin_text];
var vendorKiLocation;
List listOfPoints = [];
List<LatLng> points = [];
List FinalPoints = [];

getRoundDetails() async {
  OrderLocation.clear();
  OrderLocationList.clear();
  currentOrderDetails = null;
  currentRoundDetails.clear();
  final prefs = await SharedPreferences.getInstance();

  final token_check = prefs.getString('token');
  var response = await http.get(
      Uri.parse('http://156.67.219.185:8000/api/delivery/getCurrentRound'),
      headers: {
        'Content-Type': 'application/json',
        'token': token_check.toString(),
      });

  jsonData = jsonDecode(response.body);

  print(jsonData);
  if (jsonData.runtimeType == List<dynamic>) {
    for (var i in jsonData) {
      if (i["orderId"] != currentOrder) {
        currentRoundDetails.add(i);
      }
    }
  }

  if (jsonData.runtimeType == List<dynamic>) {
    for (var i in jsonData) {
      var k = [i['location']["lat"], i['location']["long"]];
      var h = "${i['location']["lat"]},${i['location']["long"]}";
      mapurl += "$h|";
      if (i["orderId"] == currentOrder) {
        currentOrderDetails = i;
      }

      print(currentOrderDetails);

      OrderLocation.add(h);
      OrderLocationList.add(k);
      FinalLocationList.add(h);
    }
    print(currentOrderDetails);
    print(OrderLocation);
    print(mapurl);
    print(OrderLocationList);
    print(FinalLocationList);
    print(currentRoundDetails);
    for (var i in OrderLocationList) {
      Markers.add(Marker(
        point: LatLng(i[0], i[1]),
        width: 80,
        height: 80,
        builder: ((context) => IconButton(
              onPressed: () async {
                var url =
                    'https://www.google.com/maps/search/?api=1&query=${i[0]},${i[1]}';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: const Icon(Icons.location_on),
              color: Colors.blue,
              iconSize: 50,
            )),
      ));
    }
    print(currentOrderDetails);
    return [
      Markers,
      mapurl,
      jsonData,
      OrderLocation,
      OrderLocationList,
      currentOrderDetails,
      currentRoundDetails
    ];
  }
}

getDeliveryBoyDetails() async {
  final prefs = await SharedPreferences.getInstance();
  final token_check = prefs.getString('token');
  var response = await http.get(
      Uri.parse('http://156.67.219.185:8000/api/delivery/deliveryBoyDetails'),
      headers: {
        'Content-Type': 'application/json',
        'token': token_check.toString(),
      });

  print(response.body);
  var jsonData = jsonDecode(response.body);
  print(jsonData);
  name = jsonData['user'].toString();
  phone = jsonData['phone'].toString();
  totalDeliveries = jsonData['totalDeliveries'].toString();
  onTimeDeliveries = jsonData['onTimeDelivery'].toString();
  avgRating = jsonData['avgRating'];
  origin = jsonData['origin'];
  if (avgRating < 1) {
    Star = "☆☆☆☆☆";
  } else if (avgRating > 1 && avgRating < 2) {
    Star = "★☆☆☆☆";
  } else if (avgRating > 2 && avgRating < 3) {
    Star = "★★☆☆☆";
  } else if (avgRating > 3 && avgRating < 4) {
    Star = "★★★☆☆";
  } else if (avgRating > 4 && avgRating < 5) {
    Star = "★★★★☆";
  } else {
    Star = "★★★★★";
  }
  print(origin["lat"].runtimeType);
  VendorLocationList.add([origin["lat"], origin["long"]]);
  vendorKiLocation = [origin["long"], origin["lat"]];
  vendor = jsonData['vendor'].toString();
  print(VendorLocationList);
  currentOrder = jsonData['currentOrder'];
  origin_text = "${origin['long']},${origin['lat']}";
  print(origin_text);
  print(currentOrder);

  return [
    VendorLocationList,
    vendorKiLocation,
    name,
    phone,
    totalDeliveries,
    onTimeDeliveries,
    avgRating,
    Star,
    vendor,
    origin,
    origin_text,
    currentOrder
  ];
}

getCoordinates(a, b) async {
  var response = await http.get(getRouteUrl(a, b));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var listOfPoints = data['features'][0]['geometry']['coordinates'];
    points = listOfPoints
        .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
        .toList();
  }
  print(points);
  return points;
}

cancelOrder(reason) async {
  final prefs = await SharedPreferences.getInstance();
  final token_check = prefs.getString('token');
  var response = await http.post(
    Uri.parse('http://156.67.219.185:8000/api/delivery/cancelOrder'),
    headers: {
      'token': token_check.toString(),
    },
    body: {
      'orderId': currentOrder,
      "reason": reason.toString(),
    },
  );
  var jsonData = jsonDecode(response.body);
  return jsonData;
}
