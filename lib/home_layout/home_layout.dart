import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_requests/modules/done_requests/done_requests.dart';
import 'package:technical_requests/modules/settings_screen/settings_screen.dart';

import '../modules/all_requests/get_requests_data.dart';
import '../modules/login/login_screen.dart';
import '../modules/request_details/request_details.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/cubit/cubit.dart';
import '../shared/network/local/cash_helper.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var user = FirebaseAuth.instance.currentUser;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    uId = CashHelper.getData(key: 'uId');


    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
      ),

      // **************************  The Drawer  ***************************
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // Header
            UserAccountsDrawerHeader(
              accountName:
              uId != null ?  Text('${user?.displayName}') : const Text(''),
              accountEmail:
              uId != null ?  Text('${user?.email}') : Container(
                width: width * 0.5,
                padding: const EdgeInsets.only(bottom: 15,left: 5,right: 60),
                child: defaultButton(
                  onPressed: ()
                  {
                    navigateAndFinish(context, LoginScreen());
                  },
                  text: 'Login Now',
                  backgroundColor: Colors.deepOrange,
                ),
              ),
              currentAccountPicture: Image.network('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),

              /*cubit.profileImageUrl == ''
                      ? Image.network('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png')
                      : CircleAvatar(
                    backgroundImage: NetworkImage(
                      cubit.profileImageUrl,
                    ),
                  ),*/
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),

            // Body
            SizedBox(
              height: height * 0.03,
            ),

            InkWell(
              onTap: () {
                navigateAndFinish(context, const HomeLayout());
              },
              child: const ListTile(
                title: Text(
                  'Home Page',
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.green,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.03,
            ),

            InkWell(
              onTap: () {
                navigateAndFinish(context, const DoneRequestsScreen());
              },
              child: const ListTile(
                title: Text(
                  'Done Requests',
                ),
                leading: Icon(
                  FontAwesomeIcons.thumbsUp,
                  color: Colors.green,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.03,
            ),

            InkWell(
              onTap: () {
                navigateAndFinish(context, const SettingsScreen());
              },
              child: const ListTile(
                title: Text(
                  'Settings',
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.03,
            ),


            const Divider(),

            InkWell(
              onTap: ()
              {
                //navigateTo(context, const AboutUsScreen());
              },
              child: const ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.blue,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                signOut(context);
              },
              child: const ListTile(
                title: Text('Logout'),
                leading: Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),

      body: FutureBuilder(
        future: cubit.getDocId(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done)
          {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              itemBuilder: (context, index) => customListTile(
                onTapped: () {
                  //navigateTo(context, DetailsScreen(index: index,id: cubit.docIDs[index],));
                  navigateTo(
                      context,
                      RequestDetails(
                        currentIndex: index,
                        id: cubit.docIDs[index],
                        requestCompanyName: GetRequestsData(
                          documentId: cubit.docIDs[index],
                          documentDataKey: 'companyName',
                        ),
                        requestCompanyCity: GetRequestsData(
                          documentId: cubit.docIDs[index],
                          documentDataKey: 'city',
                        ),
                        requestCompanySchool: GetRequestsData(
                          documentId: cubit.docIDs[index],
                          documentDataKey: 'school',
                        ),
                        requestCompanyMachine: GetRequestsData(

                          documentId: cubit.docIDs[index],
                          documentDataKey: 'machine',
                        ),
                        requestCompanyMachineType: GetRequestsData(
                          documentId: cubit.docIDs[index],
                          documentDataKey: 'machineType',
                        ),
                        requestCompanyConsultation: GetRequestsData(
                          documentId: cubit.docIDs[index],
                          documentDataKey: 'consultation',
                        ),
                      ));
                  //print(cubit.docIDs[index]);
                },
                title: GetRequestsData(
                  documentId: cubit.docIDs[index],
                  documentDataKey: 'companyName',
                ),
                leadingWidget: Icon(
                  Icons.history_outlined,
                  color: AppCubit.get(context).isDark
                      ? Colors.blue
                      : Colors.deepOrange,
                ),
                trailingWidget: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: AppCubit.get(context).isDark
                        ? Colors.blue
                        : Colors.deepOrange,
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                thickness: 2.0,
              ),
              itemCount: cubit.docIDs.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );

        },
      ),
    );
  }
}

