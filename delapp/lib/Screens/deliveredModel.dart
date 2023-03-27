// ignore_for_file: unused_local_variable

import "dart:convert";

import "package:delapp/Screens/initFucntions.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

delivered(otp) async {
  final prefs = await SharedPreferences.getInstance();
  final token_check = prefs.getString('token');
  var response = await http.post(
      Uri.parse("http://156.67.219.185:8000/api/delivery/delivered"),
      headers: {
        'Content-Type': 'application/json',
        'token': token_check.toString()
      },
      body: jsonEncode({"orderId": currentOrder, "otp": otp}));
  var jsonData = jsonDecode(response.body);
  print(jsonData);
}
