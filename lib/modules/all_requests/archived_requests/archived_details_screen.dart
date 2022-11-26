import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_requests/modules/finish_request/finishing_request_screen.dart';
import 'package:technical_requests/shared/components/constants.dart';
import 'package:technical_requests/shared/components/fUser.dart';

import '../../../models/locationServices.dart';
import '../../../shared/components/components.dart';
import '../../finish_request/requests_cubit/requests_cubit.dart';
import '../../finish_request/requests_cubit/requests_states.dart';

class ArchivedDetailsScreen extends StatefulWidget {
  final String id;
  final int currentIndex;
  final String city;

  const ArchivedDetailsScreen({
    super.key,
    required this.currentIndex,
    required this.city,
    required this.id,
  });

  @override
  State<ArchivedDetailsScreen> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<ArchivedDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection(widget.city)
        .doc(widget.city)
        .collection('technicals')
        .doc(userUID)
        .collection('archivedRequests')
        .snapshots();

    return BlocProvider(
      create: (context) => RequestCubit(),
      child: BlocConsumer<RequestCubit, RequestStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: StreamBuilder<QuerySnapshot>(
              stream: dataStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something Wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final List storeDocs = [];
                  snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
                    Map users = documentSnapshot.data() as Map<String, dynamic>;
                    storeDocs.add(users);
                    users['uId'] = documentSnapshot.id;
                  }).toList();
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var latitude = storeDocs[widget.currentIndex]['latitude'];
                      var longitude =
                          storeDocs[widget.currentIndex]['longitude'];
                      return Column(
                        children: [
                          SizedBox(
                            height: height * 0.1,
                          ),
                          Text(
                            'Request From : ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 22.0),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Table(
                              defaultColumnWidth: const FixedColumnWidth(180.0),
                              border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2.5,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              children: [
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Company Name', context: context),
                                    customTableValueCell(
                                      text: storeDocs[widget.currentIndex]
                                          ['companyName'],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'City', context: context),
                                    customTableValueCell(
                                      text: storeDocs[widget.currentIndex]
                                          ['city'],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'School', context: context),
                                    customTableValueCell(
                                      text: storeDocs[widget.currentIndex]
                                          ['school'],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Customer Phone',
                                        context: context),
                                    customTableValueCell(
                                      text: storeDocs[widget.currentIndex]
                                          ['customerPhone'],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Technical Name',
                                        context: context),
                                    customTableValueCell(
                                      text: storeDocs[widget.currentIndex]
                                          ['technicalName'],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Technical Phone',
                                        context: context),
                                    customTableValueCell(
                                      text: storeDocs[widget.currentIndex]
                                          ['technicalPhone'],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Location', context: context),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20.0,
                                      ),
                                      child: Column(
                                        children: [
                                          defaultTextButton(
                                            onPressed: () {
                                              //locationServices.goToLocation(latitude: latitude, longitude: longitude);
                                              MapUtils.openMap(
                                                  latitude: latitude,
                                                  longitude: longitude);
                                            },
                                            text: 'Tap To Location',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Machine Image',
                                        context: context),
                                    Image.network(
                                        '${storeDocs[widget.currentIndex]['machineImage']}'),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Damage Image', context: context),
                                    Image.network(
                                        '${storeDocs[widget.currentIndex]['machineTypeImage']}'),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Fixed Image', context: context),
                                    Image.network(
                                        '${storeDocs[widget.currentIndex]['damageImage']}'),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    customTableKeyCell(
                                        text: 'Consultation', context: context),
                                    customTableValueCell(
                                      text: storeDocs[widget.currentIndex]
                                          ['consultation'],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          customButton(
                            onPressed: () {
                              navigateAndFinish(
                                context,
                                FinishingRequestScreen(
                                  id: widget.id,
                                  companyName: storeDocs[widget.currentIndex]
                                  ['companyName'],
                                  city: storeDocs[widget.currentIndex]
                                  ['city'],
                                  school: storeDocs[widget.currentIndex]
                                  ['school'],
                                  customerPhone: storeDocs[widget.currentIndex]
                                  ['customerPhone'],
                                  machine: storeDocs[widget.currentIndex]
                                  ['machineImage'],
                                  technicalPhone: technicalPhone!,
                                ),
                              );
                            },
                            text: 'Finish',
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget customTableKeyCell({
    required String text,
    required context,
  }) =>
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20.0,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
        ),
      );

  Widget customTableValueCell({
    required String text,
  }) =>
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget customRequestAction({
    required VoidCallback onTap,
    required Color backgroundColor,
    required IconData icon,
    required String label,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Chip(
          elevation: 20.0,
          backgroundColor: backgroundColor,
          avatar: Icon(
            icon,
            color: Colors.white,
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
}
