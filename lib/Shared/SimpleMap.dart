import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class SimpleMap extends StatelessWidget {
  final double lat;
  final double lng;
  Widget marker;

  SimpleMap({key, this.lat, this.lng, this.marker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        interactiveFlags: InteractiveFlag.none,
        center: LatLng(lat, lng),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(lat, lng),
              builder: (ctx) => Center(
                child: Stack(children: [
                  Positioned(
                    bottom: 32,
                    left: 24,
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 32,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
