import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'firebaseServices.dart';

class LocationServices {
  final FirebaseService _service = FirebaseService();

  // Send Location to Database Method
  sendLocationToDatabase(context) async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    // Here we check if Location Service is enabled
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Here we check the permission of device if not have it then we request
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    /*_locationData = await location.getLocation();
    DocumentReference reference = _service.db
        .collection('sections')
        .doc(getSectionID(context: context))
        .collection('subSections')
        .doc(getSubSectionID(context: context))
        .collection('activities')
        .doc(getActivityID(context: context));

    reference.update({
      'latitude': _locationData.latitude,
      'longitude': _locationData.longitude,
    });*/
  }

  // Go To Location
  goToLocation({required double latitude, required double longitude}) async {
    String mapLocationUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final encodedUrl = Uri.encodeFull(mapLocationUrl);
    if (await canLaunchUrlString(encodedUrl)) {
      await launchUrlString(encodedUrl);
    } else {
      print('Could not Launch $encodedUrl');
      throw 'Could not Launch $encodedUrl';
    }
  }
}
