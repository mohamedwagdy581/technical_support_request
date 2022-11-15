import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {
        required String name,
        required String id,
        required String area,
        required String email,
        required String password,
        required String phone,
        required String image,
      })
  {
    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,

    ).then((value)
    {
      var user = FirebaseAuth.instance.currentUser;
      user?.updateDisplayName(name);

      //var displayName = value.user?.updateDisplayName(name);
      createUser(
        id: id,
        area: area,
        name: name,
        email: value.user!.email.toString(),
        phone: phone,
        uId: value.user!.uid.toString(),
        image: image.toString(),
        cover: '',
        //isEmailVerified: value.user!.emailVerified.toString(),
      );

    }).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser(
      {
        required String name,
        required String email,
        required String area,
        required String phone,
        required String uId,
        required String id,
        required String image,
        required String cover,
      })
  {

    UserModel model = UserModel(
      email: email,
      area: area,
      name: name,
      phone: phone,
      uId: uId,
      id: id,
      image: 'https://resources.premierleague.com/premierleague/photos/players/250x250/p118748.png',
      cover: 'https://img.freepik.com/free-photo/indecisive-girl-picks-from-two-choices-looks-questioned-troubled-crosses-hands-across-chest-hesitates-suggested-products-wears-yellow-t-shirt-isolated-crimson-wall_273609-42552.jpg?w=1380',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection(area)
        .doc(area).collection('technicals').doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(CreateUserSuccessState());
    }).catchError((error)
    {
      emit(CreateUserErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility()
  {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }


}