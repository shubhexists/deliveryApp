// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable, avoid_print, prefer_typing_uninitialized_variables, prefer_is_empty
import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

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

// getRoundTripDistance(List<LatLng> points) {
//   double distance = 0;
//   for (int i = 0; i < points.length - 1; i++) {
//     distance += getRoundTripDistance([points[i], points[i + 1]]);
//   }
//   return distance;
// }

getRoundDetails() async {
  final prefs = await SharedPreferences.getInstance();
// if (!prefs.containsKey('token')) {
//   return false;
//   }
  final token_check = prefs.getString('token');
  var response = await http.get(
      Uri.parse('http://156.67.219.185:8000/api/delivery/getCurrentRound'),
      headers: {
        'Content-Type': 'application/json',
        'token': token_check.toString(),
      });
  // return response.body;
  var jsonData = jsonDecode(response.body);
  // print(jsonData);
  for (var i in jsonData) {
    if (i["orderId"] != currentOrder) {
      currentRoundDetails.add(i);
    }
  }

  // if(jsonData.runtimeType == ){
  for (var i in jsonData) {
    var k = [i['location']["lat"], i['location']["long"]];
    var h = "${i['location']["lat"]},${i['location']["long"]}";
    if (i["orderId"] == currentOrder) {
      currentOrderDetails = i;
    }
    OrderLocation.add(h);
    OrderLocationList.add(k);
  }
  // print(OrderLocation);
  print(currentRoundDetails);
  return [
    OrderLocation,
    OrderLocationList,
    currentOrderDetails,
    currentRoundDetails
  ];
}
// }

getDeliveryBoyDetails() async {
  final prefs = await SharedPreferences.getInstance();
  final token_check = prefs.getString('token');
  var response = await http.get(
      Uri.parse('http://156.67.219.185:8000/api/delivery/deliveryBoyDetails'),
      headers: {
        'Content-Type': 'application/json',
        'token': token_check.toString(),
      });
  // return response.body;
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
  vendor = jsonData['vendor'].toString();
  currentOrder = jsonData['currentOrder'];
  origin_text = "${origin['long']},${origin['lat']}";
  print(origin_text);

  return [
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

// {"user":"isha","phone":9549964210,"totalDeliveries":0,"onTimeDelivery":0,"avgRating":0,"vendor":"shubham2","currentRound":7,"currentOrder":9}
// [{"orderId":9,"orderedByName":"Shubham Singh","amount":130,"deliverAt":"S-144,  Some Address, Near  Near Aggarwal,  Delhi,  Delhi-110092"}]
