import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'firebaseServices.dart';

class LocationServices {
  final FirebaseService _service = FirebaseService();

  // Send Location to Database Method
  sendLocationToDatabase(context) async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    // Here we check if Location Service is enabled
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Here we check the permission of device if not have it then we request
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
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
    if (await canLaunchUrlString(encodedUrl) != null) {
      await launchUrlString(encodedUrl);
    } else {
      print('Could not Launch $encodedUrl');
      throw 'Could not Launch $encodedUrl';
    }
  }
}

class MapUtils
{
  MapUtils._();
  static Future<void> openMap({required double latitude, required double longitude}) async
  {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if(await canLaunch(googleUrl) != null)
    {
      await launch(googleUrl);
    }else
    {
      throw 'Could not Launch $googleUrl';
    }
  }
}
