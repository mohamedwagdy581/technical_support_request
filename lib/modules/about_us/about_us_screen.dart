import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),

          const CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('assets/images/baruziklogo.png',),
            backgroundColor: Colors.transparent,
          ),

          SizedBox(
            height: height * 0.05,
          ),

          Text(
            'مؤسسة عبدالعزيز بارزيق',
            style: Theme.of(context).textTheme.bodyText1,
          ),

          SizedBox(
            height: height * 0.06,
          ),

          defaultSigningInRowButton(
            rowBackgroundColor: AppCubit.get(context).isDark ? const Color(0xffF4F2F2) : Colors.deepOrange,
            onPressed: () async
            {
              const link = WhatsAppUnilink(
                phoneNumber: '+966-540814455',
                text: "مرحبا بارزيق, لدي مشكله اريد حلها!!",
              );
              // Convert the WhatsAppUnilink instance to a string.
              // Use either Dart's string interpolation or the toString() method.
              // The "launch" method is part of "url_launcher".
              await launch('$link');
            },
            title: 'تواصل معنا عبر الواتساب',
            titleStyle: Theme.of(context).textTheme.headline6?.copyWith(
              color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
              fontSize: 18.0
            ),
            icon: Icons.whatsapp,
            iconColor:  const Color(0xff199606),
            width: width * 0.04,
          ),
        ],
      ),
    );
  }
}
