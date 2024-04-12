// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// class Location extends StatefulWidget {
//   const Location({super.key});

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
//   String LocationMessage = 'Home Location';

//   late String lat;
//   late String long;

//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location Services disabled');
//     }
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permission denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we can not request');
//     }
//     return await Geolocator.getCurrentPosition();
//   }

//   void _liveLocation() {
//     LocationSettings locationSettings = const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//     );

//     Geolocator.getPositionStream(locationSettings: locationSettings)
//         .listen((Position position) {
//       lat = position.latitude.toString();
//       long = position.longitude.toString();
//       setState(() {
//         LocationMessage = 'Latitude: $lat, Longitude:$long';
//       });
//     });
//   }

//   Future<void> _openMap(String lat, String long) async {
//     String googleUrl =
//         'https://www.google.com/maps/search/?api=1&query=$lat,$long';
//     await canLaunchUrlString(googleUrl)
//         ? await launchUrlString(googleUrl)
//         : throw 'Could not launch $googleUrl';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               LocationMessage,
//               textAlign: TextAlign.center,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _getCurrentLocation().then((value) {
//                   lat = '${value.latitude}';
//                   long = '${value.longitude}';
//                   setState(() {
//                     LocationMessage = 'Latitude: $lat,\n Longitude: $long';
//                   });
//                   _liveLocation();
//                 });
//               },
//               child: const Text('Get Home location'),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   _openMap(lat, long);
//                 },
//                 child: Text('Open Goggle Map'))
//           ],
//         ),
//       ),
//     );
//   }
// }