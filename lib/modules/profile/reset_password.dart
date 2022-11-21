import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late String email;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    resetPass() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email)
            .whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم ارسال الايميل'),
              duration: Duration(milliseconds: 400),
            ),
          );
        });
      } on FirebaseAuthException catch (error) {
        if (error.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لايوجد ايميل بهذا الاسم'),
              duration: Duration(milliseconds: 400),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  defaultTextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'الايميل',
                    textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppCubit.get(context).isDark
                          ? Colors.black
                          : Colors.white,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'برجاء ادخال الايميل';
                      }
                      if(!RegExp("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                      {
                        return 'برجاء ادخال ايميل صحيح';
                      }
                      return null;
                    },
                    suffix: Icons.email,
                    prefixColor:
                    AppCubit.get(context).isDark ? Colors.black : Colors.white, prefix: null,
                  ),

                  const SizedBox(height: 30.0,),

                  defaultTextButton(
                    onPressed: ()
                    {
                      if(_formKey.currentState!.validate())
                      {
                        setState(() {
                          email = emailController.text;
                          resetPass();
                        });
                      }
                    },
                    text: 'إرسال',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
