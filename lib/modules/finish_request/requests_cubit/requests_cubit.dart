
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:technical_requests/shared/components/constants.dart';

import '../../../models/request_model.dart';
import 'requests_states.dart';

class RequestCubit extends Cubit<RequestStates>
{
  RequestCubit() : super(RequestInitialState());

  static RequestCubit get(context) => BlocProvider.of(context);

  void technicalRequest(
      {
        required String city,
        required String companyName,
        required String school,
        required String machineImage,
        required String machineTypeImage,
        required String damageImage,
        required String consultation,
        required double latitude,
        required double longitude,
      })
  {
    emit(RequestLoadingState());
    var user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('doneRequests').doc(uId).get().then((value)
    {

      createRequest(
        city: city,
        companyName: companyName,
        technicalName: user!.displayName.toString(),
        school: school,
        machineImage: machineImage,
        uId: value.id.toString(),
        machineTypeImage: machineTypeImage.toString(),
        damageImage: damageImage.toString(),
        consultation: consultation.toString(),
        latitude: latitude,
        longitude: longitude,
        //isEmailVerified: value.user!.emailVerified.toString(),
      );
    }).catchError((error)
    {
      emit(RequestErrorState(error.toString()));
    });
  }

  void createRequest(
      {
        required String city,
        required String companyName,
        required String technicalName,
        required String school,
        required String machineImage,
        required String uId,
        required String machineTypeImage,
        required String damageImage,
        required String consultation,
        required double latitude,
        required double longitude,
      })
  {

    RequestModel model = RequestModel(
      city: city,
      companyName: companyName,
      technicalName: technicalName,
      school: school,
      machineImage: machineImage,
      uId: uId,
      machineTypeImage: machineTypeImage,
      damageImage: damageImage,
      consultation: consultation,
      latitude: latitude,
      longitude: longitude,
    );

    FirebaseFirestore.instance
        .collection('doneRequests')
        .doc()
        .set(model.toJson())
        .then((value)
    {
      emit(CreateRequestSuccessState());
    }).catchError((error)
    {
      emit(CreateRequestErrorState(error.toString()));
    });
  }



  String? imagePath1;
  String? imagePath2;
  String? imagePath3;
  String uniqueImageName = DateTime.now().millisecondsSinceEpoch.toString();
  String imageUrl ='';
  void pickImage(int imageNumber) async
  {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      switch (imageNumber) {
        case 1:
          imagePath1 = file.path;
          break;
        case 2:
          imagePath2 = file.path;
          break;
        case 3:
          imagePath3 = file.path;
          break;
      }

     /* // Get Reference To Storage Root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      // Create Reference for the Images to be stored
      Reference referenceImageToUpload = referenceDirImages.child(uniqueImageName);

      try {
        // Store The File
        await referenceImageToUpload.putFile(File(imagePath!));
        imageUrl = await referenceImageToUpload.getDownloadURL();


      } catch (error) {
        // Some Errors

      }*/
      emit(PickImageSuccessState());
    }
  }


}