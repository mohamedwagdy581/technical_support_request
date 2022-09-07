import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/firebaseServices.dart';

FirebaseService firebaseService = FirebaseService();

//Const:
const themeColor = Color(0xfff5a623);
const greyColor = Color(0xffaeaeae);
const greyColor2 = Color(0xffE8E8E8);
const String avatarPlaceholderURL =
    'https://cdn-icons-png.flaticon.com/512/219/219983.png';
const sCashedImg = 800;
const lCashedImg = 2000;

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// OTP Consts:
final BoxDecoration pinPutDecoration = BoxDecoration(
  color: Colors.transparent,
  //const Color.fromRGBO(43, 46, 66, 1),
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(
    color: const Color.fromRGBO(126, 203, 224, 1),
  ),
);
final TextEditingController pinPutController = TextEditingController();
final FocusNode pinPutFocusNode = FocusNode();

sendMessage({
  required String phone,
  required String message,
}) async {
  var uri = 'sms:$phone?body=$message';

  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not Launch $uri';
  }
}

String formattedDate(timeStamp) {
  var dateFromTimeStamp =
      DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimeStamp);
}
