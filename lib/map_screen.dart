import 'package:doctorproject/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> list = [];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blue[800],
          statusBarIconBrightness: Brightness.light
        ),
        centerTitle:false,
        backgroundColor: Colors.blue[800],
        title: Text(
          'Map'
        ),
      ),
      body: GoogleMap(
        onTap: (argument) {
          list.add(Marker(markerId: MarkerId("1"), position: argument));
          setState(() {});
        },
        markers: list.toSet(),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
            target: LatLng(31.98608057315421, 35.898214490039535), zoom: 14),
      ),
      bottomNavigationBar: list.isNotEmpty
          ? Padding(
            padding: const EdgeInsets.only(
              bottom: 20
            ),
            child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadiusDirectional.circular(20)
        ),
              child: TextButton(
                  onPressed: () {
                    if (list.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FillPositionPage(
                           initialPosition: list.first.position,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                      "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
            ),
          )
          : SizedBox(),
    );
  }
}
