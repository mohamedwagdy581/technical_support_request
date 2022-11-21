import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_requests/home_layout/home_layout.dart';
import 'package:technical_requests/modules/history/history_screen.dart';
import 'package:technical_requests/modules/profile/profile_screen.dart';


import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/cubit/cubit.dart';
import '../about_us/about_us_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true ,
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 20.0),
              onPressed: ()
          {
            navigateAndFinish(context, const HomeLayout());
          }, icon: const Icon(FontAwesomeIcons.thumbsUp,color: Colors.blue,),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.033,
            ),
            customListTile(
              context: context,
              onTap: ()
              {
                navigateTo(context, const AboutUsScreen());
              },
              prefixIcon: Icons.info_outline,
              suffixIcon: FontAwesomeIcons.arrowRight,
              title: 'About us',
              subTitle: 'contact with us to solve your problem',
            ),

            SizedBox(
              height: height * 0.033,
            ),

            customListTile(
              context: context,
              onTap: ()
              {
                navigateTo(context, const ProfileScreen());
              },
              prefixIcon: Icons.person,
              suffixIcon: FontAwesomeIcons.arrowRight,
              title: 'Profile Screen',
              subTitle: 'Edit your profile image and cover and password',
            ),

            SizedBox(
              height: height * 0.033,
            ),
            customListTile(
              context: context,
              onTap: ()
              {
                navigateTo(context, const HistoryScreen());
              },
              prefixIcon: Icons.person,
              suffixIcon: FontAwesomeIcons.arrowRight,
              title: 'History',
              subTitle: 'See all Done and Archived Requests',
            ),

            SizedBox(
              height: height * 0.033,
            ),
            customListTile(
              context: context,
              onTap: ()
              {
                AppCubit.get(context).changeAppModeTheme();
              },
              prefixIcon: Icons.brightness_4_outlined,
              suffixIcon: AppCubit.get(context).isDark
                  ? FontAwesomeIcons.moon
                  : FontAwesomeIcons.sun,
              title: AppCubit.get(context).isDark
                  ? 'Light'
                  : 'Dark',
              subTitle: 'Click to Switch Theme',
            ),

            SizedBox(
              height: height * 0.05,
            ),

            // Logout Button
            SizedBox(
              width: width * 0.4,
              child: defaultButton(
                onPressed: () {
                  signOut(context);
                },
                text: 'LOGOUT',
                backgroundColor: AppCubit.get(context).isDark
                    ? Colors.blue
                    : Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customListTile({
    required context,
    VoidCallback? onTap,
    required IconData prefixIcon,
    required IconData suffixIcon,
    required String title,
    required String subTitle,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            prefixIcon,
            color:
                AppCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
            size: 35.0,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: Theme.of(context).textTheme.caption,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
                suffixIcon,
              color: AppCubit.get(context).isDark
                  ? Colors.blue
                  : Colors.deepOrange,
            ),
          ),
        ),
      );
}
