import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_requests/home_layout/home_layout.dart';
import 'package:technical_requests/shared/gps_location.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import 'requests_cubit/requests_cubit.dart';
import 'requests_cubit/requests_states.dart';

// ignore: must_be_immutable
class FinishingRequestScreen extends StatelessWidget {
  final Widget requestCompanyName;
  final Widget requestCompanyCity;
  final Widget requestCompanySchool;
  final Widget requestCompanyMachine;
  final Widget requestCompanyMachineType;

  FinishingRequestScreen({
    super.key,
    required this.requestCompanyName,
    required this.requestCompanyCity,
    required this.requestCompanySchool,
    required this.requestCompanyMachine,
    required this.requestCompanyMachineType,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var consultationController = TextEditingController();
  String uniqueImageName = DateTime.now().millisecondsSinceEpoch.toString();
  String machineImageUrl ='';
  String machineTypeImageUrl ='';
  String damageImageUrl ='';
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => RequestCubit(),
      child: BlocConsumer<RequestCubit, RequestStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      // City ListTile with DropdownButton
                      customRequestDetailsRow(
                        title: 'Company Name :',
                        requestTitle: requestCompanyName,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // City ListTile with DropdownButton
                      customRequestDetailsRow(
                        title: 'City :',
                        requestTitle: requestCompanyCity,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      // School ListTile with DropdownButton
                      customRequestDetailsRow(
                        title: 'School :',
                        requestTitle: requestCompanySchool,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      // Machine ListTile with DropdownButton
                      Row(
                        children: [
                          defaultOutlineAddButton(
                            onPressed: () async {

                              RequestCubit.get(context).pickImage(1);

                              // Get Reference To Storage Root
                              Reference referenceRoot = FirebaseStorage.instance.ref();
                              Reference referenceDirImages = referenceRoot.child('images');

                              // Create Reference for the Images to be stored
                              Reference referenceImageToUpload = referenceDirImages.child(uniqueImageName);

                              try
                              {
                                // Store The File
                                await referenceImageToUpload.putFile(File(RequestCubit.get(context).imagePath1!));
                                machineImageUrl = await referenceImageToUpload.getDownloadURL();
                                print('Machine Image : $machineImageUrl');
                              }catch(error)
                              {
                                // Some Errors
                              }

                            },
                            child: (RequestCubit.get(context).imagePath1 !=
                                    null)
                                ? Image.file(
                                    File(RequestCubit.get(context).imagePath1!))
                                : const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        14.0, 50.0, 14.0, 50.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                          defaultOutlineAddButton(
                            onPressed: () async {
                              RequestCubit.get(context).pickImage(2);

                              // Get Reference To Storage Root
                              Reference referenceRoot = FirebaseStorage.instance.ref();
                              Reference referenceDirImages = referenceRoot.child('images');

                              // Create Reference for the Images to be stored
                              Reference referenceImageToUpload = referenceDirImages.child(uniqueImageName);

                              try
                              {
                                // Store The File
                                await referenceImageToUpload.putFile(File(RequestCubit.get(context).imagePath2!));
                                machineTypeImageUrl = await referenceImageToUpload.getDownloadURL();
                                print('Machine Type Image : $machineTypeImageUrl');
                              }catch(error)
                              {

                                // Some Errors
                              }
                            },
                            child: (RequestCubit.get(context).imagePath2 !=
                                    null)
                                ? Image.file(
                                    File(RequestCubit.get(context).imagePath2!))
                                : const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        14.0, 50.0, 14.0, 50.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                          defaultOutlineAddButton(
                            onPressed: () async {
                              RequestCubit.get(context).pickImage(3);
                              // Get Reference To Storage Root
                              Reference referenceRoot = FirebaseStorage.instance.ref();
                              Reference referenceDirImages = referenceRoot.child('images');

                              // Create Reference for the Images to be stored
                              Reference referenceImageToUpload = referenceDirImages.child(uniqueImageName);

                              try {
                                // Store The File
                                await referenceImageToUpload.putFile(File(RequestCubit.get(context).imagePath3!));
                                damageImageUrl = await referenceImageToUpload.getDownloadURL();
                                print('Damaged Machine Image : $damageImageUrl');
                              } catch (error) {
                                // Some Errors

                              }
                            },
                            child: (RequestCubit.get(context).imagePath3 !=
                                    null)
                                ? Image.file(
                                    File(RequestCubit.get(context).imagePath3!))
                                : const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        14.0, 50.0, 14.0, 50.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      // Location ListTile with DropdownButton
                      customRequestDetailsRow(
                        title: 'Location : ',
                        //requestTitle: requestCompanyMachine,
                        trailingWidget: Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: IconButton(
                            onPressed: () {
                              _showModelBottomSheet(
                                context: context,
                                onTapped: ()
                                {
                                  var position = determinePosition();
                                  position.then((value) {
                                    if (kDebugMode) {
                                      print('location = lt : ${value.latitude.toString()}   LG: ${value.longitude.toString()}');
                                    }
                                    _latitude = value.latitude;
                                    _longitude = value.longitude;
                                  });
                                  Navigator.pop(context);
                                }
                              );
                            },
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      // Consultation TextField
                      SizedBox(
                        width: width * 0.8, //height: 350,
                        child: TextFormField(
                          controller: consultationController,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Must not be Empty';
                            }
                            return null;
                          },
                          textDirection: TextDirection.rtl,
                          maxLines: 5,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
                            hintText: ' !اكتب استفسارك',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 15,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height * 0.03,
                      ),

                      ConditionalBuilder(
                        condition: state is! RequestLoadingState,
                        builder: (context) => defaultButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final companyName = requestCompanyName.toString();
                            final city = requestCompanyCity.toString();
                            final school = requestCompanySchool.toString();
                            final consultation = consultationController.text;
                            if(kDebugMode)
                            {
                              print(_latitude);
                              print(_longitude);
                              print(requestCompanyName);
                              print(machineImageUrl);
                              print(machineTypeImageUrl);
                            }

                            if(machineImageUrl.isEmpty && machineTypeImageUrl.isEmpty && _latitude == 0.0 && _longitude == 0.0)
                            {
                              return showToast(
                                message:
                                'All Field must not be Empty',
                                state: ToastStates.ERROR,
                              );

                            }else
                            {
                              _showDoneAndArchivedDialog(context: context, doneOnPressed: ()
                              {
                                RequestCubit.get(context).technicalDoneRequest(
                                  city: city.toString(),
                                  companyName: companyName.toString(),
                                  school: school.toString(),
                                  machineImage: machineImageUrl,
                                  machineTypeImage: machineTypeImageUrl,
                                  damageImage: damageImageUrl,
                                  consultation: consultation.toString(),
                                  longitude: _longitude,
                                  latitude: _latitude,
                                );

                                showToast(
                                  message:
                                  'Request To Maintenance Sent Successfully',
                                  state: ToastStates.SUCCESS,
                                );
                                navigateAndFinish(context, const HomeLayout());
                              },
                                  archivedOnPressed: ()
                                  {
                                    RequestCubit.get(context).technicalArchivedRequest(
                                      city: city.toString(),
                                      companyName: companyName.toString(),
                                      school: school.toString(),
                                      machineImage: machineImageUrl,
                                      machineTypeImage: machineTypeImageUrl,
                                      damageImage: damageImageUrl,
                                      consultation: consultation.toString(),
                                      longitude: _longitude,
                                      latitude: _latitude,
                                    );

                                    showToast(
                                      message:
                                      'Request still Archived',
                                      state: ToastStates.WARNING,
                                    );
                                    navigateAndFinish(context, const HomeLayout());
                                  });
                            }

                          }
                          },
                          text: 'Finish',
                          backgroundColor: AppCubit.get(context).isDark
                              ? Colors.blue
                              : Colors.deepOrange,
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget customRequestDetailsRow({
    required String title,
    Widget? requestTitle,
    Widget? trailingWidget,
  }) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[300],
        ),
        child: ListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: requestTitle,
                ),
              ),
            ],
          ),
          trailing: trailingWidget,
        ),
      );

  Widget defaultOutlineAddButton({
    required VoidCallback onPressed,
    required Widget child,
  }) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 2.5,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            onPressed: onPressed,
            child: child,
          ),
        ),
      );

  void _showModelBottomSheet({required BuildContext context, required VoidCallback onTapped}) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              30.0,
            ),
          ),
        ),
        builder: (context) => Container(
          height: 250,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: customListTile(
            onTapped: onTapped,
            leadingWidget: const Icon(
              Icons.add_location,
              color: Colors.amber,
              size: 60.0,
            ),
            title: const Text(
              'Tap to Select Your Current Location',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }

  Future<bool> _showDoneAndArchivedDialog(
      {
    context,
    required VoidCallback doneOnPressed,
    required VoidCallback archivedOnPressed,
  }) async
  {
    return await showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Finishing Request'),
      content: const Text('If Request is Done!, Enter the Done Button, if not Enter the Archive Button.'),
      actions: [
        defaultButton(onPressed: doneOnPressed, text: 'Done',backgroundColor: Colors.green,),
        defaultButton(onPressed: archivedOnPressed, text: 'Archive',backgroundColor: Colors.red,),
      ],
    ));
  }
}
