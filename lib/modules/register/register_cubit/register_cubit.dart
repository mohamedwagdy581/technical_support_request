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
        required String phone,
        required String uId,
        required String image,
        required String cover,
      })
  {

    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      image: 'https://img.freepik.com/free-photo/wow-sale-there-amazed-redhead-girl-pointing-left-being-impressed-by-sale-announcement-showing-logo-standing-tshirt-against-white-background_176420-49239.jpg?t=st=1656577210~exp=1656577810~hmac=cc1cccdcd74eead3c597ae7f55984de886bf8c710457355ac173fc0a9ca3c542&w=1380',
      cover: 'https://img.freepik.com/free-photo/indecisive-girl-picks-from-two-choices-looks-questioned-troubled-crosses-hands-across-chest-hesitates-suggested-products-wears-yellow-t-shirt-isolated-crimson-wall_273609-42552.jpg?w=1380',
      bio: 'Write your bio ...',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('technicals')
        .doc(uId)
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