import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:technical_requests/home_layout/home_layout.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/cubit/cubit.dart';
import 'requests_cubit/requests_cubit.dart';
import 'requests_cubit/requests_states.dart';

// ignore: must_be_immutable
class FinishingRequestScreen extends StatefulWidget {
  final String id;
  final String companyName;
  final String city;
  final String school;
  final String customerPhone;
  final String technicalPhone;
  final String machine;

  const FinishingRequestScreen({
    super.key,
    required this.companyName,
    required this.city,
    required this.school,
    required this.machine,
    required this.id,
    required this.customerPhone, required this.technicalPhone,
  });

  @override
  State<FinishingRequestScreen> createState() => _FinishingRequestScreenState();
}

class _FinishingRequestScreenState extends State<FinishingRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var consultationController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  String uniqueImageName = DateTime.now().millisecondsSinceEpoch.toString();

  XFile? image1;
  String machineImageUrl ='';

  XFile? image2;
  String machineTypeImageUrl ='';

  XFile? image3;
  String damageImageUrl ='';

  var locationMessage = '';

  bool locationIcon = false;

  double latitude = 0.0;

  double longitude = 0.0;

  void getCurrentLocation() async
  {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      locationMessage = '${position.altitude}, ${position.longitude}';
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  showSnackBar(String snackText, Duration d)
  {
    final snackBar = SnackBar(content: Text(snackText), duration: d,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => RequestCubit(),
      child: BlocConsumer<RequestCubit, RequestStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
              .collection(city!)
              .doc(city)
              .collection('technicals')
              .snapshots();
          return Scaffold(
            appBar: AppBar(),
            body: StreamBuilder<QuerySnapshot>(
              stream: dataStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
              {
                if(snapshot.hasError)
                {
                  return Text('Something Wrong! ${snapshot.error}');
                }else if (snapshot.hasData)
                {
                  final List storeDocs = [];
                  snapshot.data!.docs.map((
                      DocumentSnapshot documentSnapshot) {
                    Map users = documentSnapshot.data() as Map<
                        String,
                        dynamic>;
                    storeDocs.add(users);
                    users['uId'] = documentSnapshot.id;
                  }).toList();
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index)
                    {
                      return  Padding(
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
                                requestTitle: widget.companyName,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              // City ListTile with DropdownButton
                              customRequestDetailsRow(
                                title: 'City :',
                                requestTitle: widget.city,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),

                              // School ListTile with DropdownButton
                              customRequestDetailsRow(
                                title: 'School :',
                                requestTitle: widget.school,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),

                              // Machine ListTile with DropdownButton
                              Row(
                                children: [
                                  defaultOutlineAddButton(
                                    onPressed: () async {
                                      image1 = await imagePicker.pickImage(source: ImageSource.camera);
                                      // Get Reference To Storage Root
                                      Reference referenceRoot = FirebaseStorage.instance.ref();
                                      Reference referenceDirImages = referenceRoot.child('images');

                                      // Create Reference for the Images to be stored
                                      Reference referenceImageToUpload = referenceDirImages.child(uniqueImageName);

                                      try {
                                        // Store The File
                                        await referenceImageToUpload.putFile(File(image1!.path));
                                        machineImageUrl = await referenceImageToUpload.getDownloadURL();
                                        print('Machine Image : $machineImageUrl');
                                      } catch (error) {
                                        // Some Errors

                                      }
                                    },
                                    child: (image1?.path !=
                                        null)
                                        ? Image.file(
                                        File(image1!.path))
                                        : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 35.0, 8.0, 50.0),
                                      child: Column(
                                        children: const [
                                          Text('Machine Photo'),
                                          Icon(Icons.add,color: Colors.grey,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  defaultOutlineAddButton(
                                    onPressed: () async {
                                      image2 = await imagePicker.pickImage(source: ImageSource.camera);
                                      // Get Reference To Storage Root
                                      Reference referenceRoot = FirebaseStorage.instance.ref();
                                      Reference referenceDirImages = referenceRoot.child('images');

                                      // Create Reference for the Images to be stored
                                      Reference referenceImageToUpload = referenceDirImages.child(uniqueImageName);

                                      try {
                                        // Store The File
                                        await referenceImageToUpload.putFile(File(image2!.path));
                                        machineTypeImageUrl = await referenceImageToUpload.getDownloadURL();
                                        print('Machine Type Image : $machineTypeImageUrl');
                                      } catch (error) {
                                        // Some Errors

                                      }
                                    },
                                    child: (image2?.path !=
                                        null)
                                        ? Image.file(
                                        File(image2!.path))
                                        : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 35.0, 8.0, 35.0),
                                      child: Column(
                                        children: const [
                                          Text('Machine Type Photo'),
                                          Icon(Icons.add,color: Colors.grey,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  defaultOutlineAddButton(
                                    onPressed: () async {
                                      image3 = await imagePicker.pickImage(source: ImageSource.camera);
                                      // Get Reference To Storage Root
                                      Reference referenceRoot = FirebaseStorage.instance.ref();
                                      Reference referenceDirImages = referenceRoot.child('images');

                                      // Create Reference for the Images to be stored
                                      Reference referenceImageToUpload = referenceDirImages.child(uniqueImageName);

                                      try {
                                        // Store The File
                                        await referenceImageToUpload.putFile(File(image3!.path));
                                        damageImageUrl = await referenceImageToUpload.getDownloadURL();
                                        print('Damaged Machine Image : $damageImageUrl');
                                      } catch (error) {
                                        // Some Errors

                                      }
                                    },
                                    child: (image3?.path !=
                                        null)
                                        ? Image.file(
                                        File(image3!.path))
                                        : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 35.0, 8.0, 35.0),
                                      child: Column(
                                        children: const [
                                          Text('Machine Type Photo'),
                                          Icon(Icons.add,color: Colors.grey,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),

                              // Location ListTile with DropdownButton
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10.0),
                                  color: Colors.grey[300],
                                ),
                                child: ListTile(
                                  title: const Text(
                                    'Press to send Your Current Location --->',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      getCurrentLocation();
                                      RequestCubit.get(context)
                                          .changeLocationIcon();
                                    },
                                    icon: Icon(
                                      RequestCubit
                                          .get(context)
                                          .locationIcon,
                                      color: RequestCubit
                                          .get(context)
                                          .isLocation
                                          ? Colors.blue
                                          : Colors.green,
                                      size: 30.0,
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
                                      final companyName = widget.companyName.toString();
                                      final city = widget.city.toString();
                                      final customerPhone = widget.customerPhone.toString();
                                      //final technicalPhoneNumber = widget.technicalPhone.toString();
                                      final school = widget.school.toString();
                                      final consultation = consultationController.text;
                                      if(kDebugMode)
                                      {
                                        print(latitude);
                                        print(longitude);
                                        print(widget.companyName);
                                        print('Machine Image : $machineImageUrl');
                                        print('Machine Type Image : $machineTypeImageUrl');
                                      }

                                      if(machineImageUrl.isEmpty && machineTypeImageUrl.isEmpty && damageImageUrl.isEmpty && latitude == 0.0 && longitude == 0.0)
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
                                            technicalPhone: technicalPhone.toString(),
                                            customerPhone: customerPhone.toString(),
                                            machineImage: machineImageUrl,
                                            machineTypeImage: machineTypeImageUrl,
                                            damageImage: damageImageUrl,
                                            consultation: consultation.toString(),
                                            longitude: longitude,
                                            latitude: latitude,
                                          );
                                          RequestCubit.get(context).technicalDoneHistoryRequest(
                                            city: city.toString(),
                                            companyName: companyName.toString(),
                                            school: school.toString(),
                                            technicalPhone: technicalPhone.toString(),
                                            customerPhone: customerPhone.toString(),
                                            machineImage: machineImageUrl,
                                            machineTypeImage: machineTypeImageUrl,
                                            damageImage: damageImageUrl,
                                            consultation: consultation.toString(),
                                            longitude: longitude,
                                            latitude: latitude,
                                          );
                                          FirebaseFirestore.instance.collection(city).doc(city).collection('requests').doc(widget.id).delete();

                                          showToast(
                                            message:
                                            'Request Done Successfully',
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
                                                technicalPhone: technicalPhone.toString(),
                                                customerPhone: customerPhone.toString(),
                                                machineImage: machineImageUrl,
                                                machineTypeImage: machineTypeImageUrl,
                                                damageImage: damageImageUrl,
                                                consultation: consultation.toString(),
                                                longitude: longitude,
                                                latitude: latitude,
                                              );

                                              RequestCubit.get(context).technicalArchivedHistoryRequest(
                                                city: city.toString(),
                                                companyName: companyName.toString(),
                                                school: school.toString(),
                                                technicalPhone: technicalPhone.toString(),
                                                customerPhone: customerPhone.toString(),
                                                machineImage: machineImageUrl,
                                                machineTypeImage: machineTypeImageUrl,
                                                damageImage: damageImageUrl,
                                                consultation: consultation.toString(),
                                                longitude: longitude,
                                                latitude: latitude,
                                              );

                                              FirebaseFirestore.instance.collection(city).doc(city).collection('requests').doc(widget.id).delete();

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
                      );
                    },
                  );
                }else
                {
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

  Widget customRequestDetailsRow({
    required String title,
    required String requestTitle,
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
                  child: Text(requestTitle, style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),),
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
