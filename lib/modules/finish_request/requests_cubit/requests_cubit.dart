
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:technical_requests/shared/components/fUser.dart';

import '../../../models/request_model.dart';
import 'requests_states.dart';

class RequestCubit extends Cubit<RequestStates>
{
  RequestCubit() : super(RequestInitialState());

  static RequestCubit get(context) => BlocProvider.of(context);

  // Done Technical Requests
  void technicalDoneRequest(
      {
        required String city,
        required String companyName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
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

    FirebaseFirestore.instance.collection(city).doc(city).collection('doneRequests').doc().get().then((value)
    {

      createDoneRequest(
        city: city,
        companyName: companyName,
        technicalName: user!.displayName.toString(),
        school: school,
        technicalPhone: technicalPhone,
        customerPhone: customerPhone,
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

  void createDoneRequest(
      {
        required String city,
        required String companyName,
        required String technicalName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
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
      technicalPhone: technicalPhone,
      customerPhone: customerPhone,
      machineImage: machineImage,
      uId: uId,
      machineTypeImage: machineTypeImage,
      damageImage: damageImage,
      consultation: consultation,
      latitude: latitude,
      longitude: longitude,
    );

    FirebaseFirestore.instance
        .collection(city).doc(city).collection('doneRequests').doc().set(model.toJson())
        .then((value)
    {
      emit(CreateRequestSuccessState());
    }).catchError((error)
    {
      emit(CreateRequestErrorState(error.toString()));
    });
  }

  // Done Technical History Requests
  void technicalDoneHistoryRequest(
      {
        required String city,
        required String companyName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
        required String machineImage,
        required String machineTypeImage,
        required String damageImage,
        required String consultation,
        required double latitude,
        required double longitude,
      })
  {
    emit(DoneHistoryRequestLoadingState());
    var user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection(city).doc(city).collection('technicals').doc(userUID).collection('doneRequest').doc().get().then((value)
    {

      createDoneHistoryRequest(
        city: city,
        companyName: companyName,
        technicalName: user!.displayName.toString(),
        school: school,
        technicalPhone: technicalPhone,
        customerPhone: customerPhone,
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
      emit(DoneHistoryRequestErrorState(error.toString()));
    });
  }

  // Create Done History Request Model
  void createDoneHistoryRequest(
      {
        required String city,
        required String companyName,
        required String technicalName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
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
      technicalPhone: technicalPhone,
      customerPhone: customerPhone,
      machineImage: machineImage,
      uId: uId,
      machineTypeImage: machineTypeImage,
      damageImage: damageImage,
      consultation: consultation,
      latitude: latitude,
      longitude: longitude,
    );

    FirebaseFirestore.instance
        .collection(city).doc(city).collection('technicals').doc(userUID).collection('doneRequests').doc().set(model.toJson())
        .then((value)
    {
      emit(CreateDoneHistoryRequestSuccessState());
    }).catchError((error)
    {
      emit(CreateDoneHistoryRequestErrorState(error.toString()));
    });
  }

  // Archived Technical Requests
  void technicalArchivedRequest(
      {
        required String city,
        required String companyName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
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

    FirebaseFirestore.instance.collection(city).doc(city).collection('archivedRequests').doc().get().then((value)
    {

      createArchivedRequest(
        city: city,
        companyName: companyName,
        technicalName: user!.displayName.toString(),
        school: school,
        technicalPhone: technicalPhone,
        customerPhone: customerPhone,
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

  // Create Archived Request Model
  void createArchivedRequest(
      {
        required String city,
        required String companyName,
        required String technicalName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
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
      technicalPhone: technicalPhone,
      customerPhone: customerPhone,
      machineImage: machineImage,
      uId: uId,
      machineTypeImage: machineTypeImage,
      damageImage: damageImage,
      consultation: consultation,
      latitude: latitude,
      longitude: longitude,
    );

    FirebaseFirestore.instance
        .collection(city).doc(city).collection('archivedRequests').doc().set(model.toJson())
        .then((value)
    {
      emit(CreateRequestSuccessState());
    }).catchError((error)
    {
      emit(CreateRequestErrorState(error.toString()));
    });
  }


  // Done Technical History Requests
  void technicalArchivedHistoryRequest(
      {
        required String city,
        required String companyName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
        required String machineImage,
        required String machineTypeImage,
        required String damageImage,
        required String consultation,
        required double latitude,
        required double longitude,
      })
  {
    emit(ArchivedHistoryRequestLoadingState());
    var user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection(city).doc(city).collection('technicals').doc(userUID).collection('archivedRequests').doc().get().then((value)
    {

      createArchivedHistoryRequest(
        city: city,
        companyName: companyName,
        technicalName: user!.displayName.toString(),
        school: school,
        technicalPhone: technicalPhone,
        customerPhone: customerPhone,
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
      emit(ArchivedHistoryRequestErrorState(error.toString()));
    });
  }

  // Create Done History Request Model
  void createArchivedHistoryRequest(
      {
        required String city,
        required String companyName,
        required String technicalName,
        required String school,
        required String technicalPhone,
        required String customerPhone,
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
      technicalPhone: technicalPhone,
      customerPhone: customerPhone,
      machineImage: machineImage,
      uId: uId,
      machineTypeImage: machineTypeImage,
      damageImage: damageImage,
      consultation: consultation,
      latitude: latitude,
      longitude: longitude,
    );

    FirebaseFirestore.instance
        .collection(city).doc(city).collection('technicals').doc(userUID).collection('archivedRequests').doc().set(model.toJson())
        .then((value)
    {
      emit(CreateArchivedHistoryRequestSuccessState());
    }).catchError((error)
    {
      emit(CreateArchivedHistoryRequestErrorState(error.toString()));
    });
  }


  String? imagePath1;
  String? imagePath2;
  String? imagePath3;
  void pickImage(int imageNumber) async
  {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      switch (imageNumber) {
        case 1:
          imagePath1 = file.path;
          emit(PickImageSuccessState());
          break;
        case 2:
          imagePath2 = file.path;
          emit(PickImageSuccessState());
          break;
        case 3:
          imagePath3 = file.path;
          emit(PickImageSuccessState());
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
      //emit(PickImageSuccessState());
    }
  }


  IconData locationIcon = Icons.add_location_alt_outlined;
  bool isLocation = false;
  void changeLocationIcon()
  {
    isLocation = !isLocation;
    locationIcon = isLocation ? Icons.add_location_alt_outlined : Icons.done_all;

    emit(ChangeLocationIconState());
  }



}