import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../home_layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import '../../shared/network/local/cash_helper.dart';
import '../register/register_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  late var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)
        {
          // Listener in Login State if Error Show toast with error
          if(state is LoginErrorState)
          {
            showToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          }
          // Listener in Login state if success save uId in CacheHelper and navigate to HomeLayout
          if(state is LoginSuccessState)
          {
            // CacheHelper to save token or Authorization and navigate and finish to the main home screen
            CashHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {

              navigateAndFinish(
                context,
                const HomeLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          var height = MediaQuery.of(context).size.height;

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Login main text in the screen
                      children: [
                        Text(
                          'Login',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                            fontSize: 35.0,
                          ),
                        ),
                        //SizedBox between Login Text and Login to Start Text
                        SizedBox(
                          height: height * 0.02,
                        ),

                        // subtitle login in the screen
                        Text(
                          'Login to start connect with your company',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),

                        // TextFormField of Email Address
                        defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                              AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),

                        //SizedBox between Email and Password TextFormField
                        SizedBox(
                          height: height * 0.02,
                        ),

                        // TextFormField of Password
                        defaultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          secure: LoginCubit.get(context).isPasswordShown,
                          prefix: Icons.password,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffix: LoginCubit.get(context).suffix,
                          suffixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffixPressed: ()
                          {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        //SizedBox between Password and Login Button
                        SizedBox(
                          height: height * 0.035,
                        ),

                        // Login Button
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) =>
                              Container(
                                alignment: Alignment.center,
                                child: defaultButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate())
                                    {
                                      LoginCubit.get(context).userLogin(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                      );
                                    }
                                  },
                                  text: 'Login',
                                  backgroundColor:
                                    AppCubit.get(context).isDark ? Colors.green : Colors.deepOrange,
                                ),
                              ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),

                        //SizedBox between Login Button and Don't have an account
                        SizedBox(
                          height: height * 0.02,
                        ),

                        // Row that contain Don't have an account text and Register TextButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color:
                                AppCubit.get(context).isDark ? Colors.black : Colors.white,
                              ),
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  RegisterScreen(),
                                );
                              },
                              text: 'REGISTER',
                            ),
                          ],
                        ),

                        // Google And FaceBook Signing In Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: ()
                              {
                                //LoginCubit.get(context).signInWithGoogle();
                              },
                              child: const CircleAvatar(
                                radius: 30.0,
                                backgroundColor: Colors.transparent,
                                child: Icon(FontAwesomeIcons.facebook,size: 55.0,color: Colors.blue,),
                              ),
                            ),
                            InkWell(
                              onTap: ()
                              {
                                LoginCubit.get(context).signInWithGoogle();
                              },
                              child: const CircleAvatar(
                                radius: 30.0,
                                backgroundColor: Colors.transparent,
                                child: Icon(FontAwesomeIcons.googlePlus,size: 55.0,color: Colors.amber,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
