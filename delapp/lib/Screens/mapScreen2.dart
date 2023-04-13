// ignore_for_file: file_names, unnecessary_null_comparison, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:delapp/Screens/initFucntions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen2 extends StatefulWidget {
  const MapScreen2({super.key});

  @override
  State<MapScreen2> createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  _launchURL(lat, long) async {
    var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          zoom: 10,
          center: LatLng(origin["long"], origin["lat"]),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(origin["long"], origin["lat"]),
                width: 80,
                height: 80,
                builder: ((context) => IconButton(
                      onPressed: () {
                        _launchURL(origin["long"], origin["lat"]);
                      },
                      icon: const Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 50,
                    )),
              ),
              ...Markers
            ],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: points != []
                    ? points
                    : OrderLocationList.map(
                            (p) => LatLng(p[1].toDouble(), p[0].toDouble()))
                        .toList(),
                strokeWidth: 5,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
