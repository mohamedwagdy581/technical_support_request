import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technical_requests/shared/components/fUser.dart';

import '../../../models/user_model.dart';
import '../../components/constants.dart';
import '../local/cash_helper.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  // Get context to Easily use in a different places in all Project
  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance.collection(city).doc(city).collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  // Get Document IDs to start access to all data in document in firebase
  List<String> docIDs = [];

  Future getDocId() async
  {
    emit(AppGetDocIDsLoadingState());
    docIDs.clear();
    await FirebaseFirestore.instance.collection(city).doc(city).collection('requests').get().then((snapshot)
    {
      for (var document in snapshot.docs) {
        docIDs.add(document.reference.id);
      }
      emit(AppGetDocIDsSuccessState());

    }).catchError((error)
    {
      emit(AppGetDocIDsErrorState(error));
    });
  }

  // Get Done Document IDs to start access to all data in document in firebase
  List<String> doneDocIDs = [];

  Future getDoneDocId({required String city}) async
  {
    print(city);
    emit(AppGetDoneDocIDsLoadingState());
    doneDocIDs.clear();
    await FirebaseFirestore.instance.collection(city).doc(city).collection('technicals').doc(userUID).collection('doneRequests').get().then((
        snapshot) {
      for (var document in snapshot.docs) {
        doneDocIDs.add(document.reference.id);
        emit(AppGetDoneDocIDsSuccessState());
      }
    }).catchError((error)
    {
      emit(AppGetDoneDocIDsErrorState(error));
    });
  }


  // Get Archived Document IDs to start access to all data in document in firebase
  List<String> archivedDocIDs = [];

  Future getArchivedDocId({required String city}) async
  {
    archivedDocIDs.clear();
    emit(AppGetArchivedDocIDsLoadingState());
    await FirebaseFirestore.instance.collection(city).doc(city).collection('technicals').doc(userUID).collection('archivedRequests').get().then((
        snapshot) {
      for (var document in snapshot.docs) {
        archivedDocIDs.add(document.reference.id);
        emit(AppGetArchivedDocIDsSuccessState());
      }
    }).catchError((error)
    {
      emit(AppGetArchivedDocIDsErrorState(error));
    });
  }


  // Function to Change Theme mode
  bool isDark = false;

  void changeAppModeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeThemeState());
    } else {
      isDark = !isDark;
      CashHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeThemeState());
      });
    }
  }


}
