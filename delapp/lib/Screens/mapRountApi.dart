// ignore_for_file: file_names, unused_element
import 'package:url_launcher/url_launcher.dart';

const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf6248fd8bea7c1711445083b90504973412ef';

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}

_launchURL(lat, long) async {
  var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
