import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import '../login/login_screen.dart';
import 'register_cubit/register_cubit.dart';
import 'register_cubit/register_states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  late var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var idController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          // Listener in create user success state if success navigate and finish to Home Layout
          if(state is CreateUserSuccessState)
          {
            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state)
        {
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
                      children: [
                        Text(
                          'Sign Up',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1?.copyWith(
                            fontSize: 35.0,
                          ),
                        ),

                        //SizedBox between SignUp Text and Login to Start Text
                        SizedBox(
                          height: height * 0.019,
                        ),

                        Text(
                          'Register to start connect with your company',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.033,
                        ),

                        // TextFormField of ID
                        defaultTextFormField(
                          controller: idController,
                          keyboardType: TextInputType.number,
                          label: 'ID',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your ID';
                            }
                            return null;
                          },
                          prefix: Icons.perm_identity_outlined,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),
                        //SizedBox between Name and Email Address TextFormField
                        SizedBox(
                          height: height * 0.019,
                        ),
                        // TextFormField of Name
                        defaultTextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: 'Name',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),

                        //SizedBox between Name and Email Address TextFormField
                        SizedBox(
                          height: height * 0.019,
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

                        //SizedBox between Email and Phone TextFormField
                        SizedBox(
                          height: height * 0.019,
                        ),

                        // TextFormField of Phone
                        defaultTextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Phone',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),

                        //SizedBox between Phone and Password TextFormField
                        SizedBox(
                          height: height * 0.019,
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
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                          secure: RegisterCubit.get(context).isPasswordShown,
                          prefix: Icons.password,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffixPressed: ()
                          {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                        ),

                        //SizedBox between Password and Login Button
                        SizedBox(
                          height: height * 0.034,
                        ),

                        // Register Button
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) =>
                              Container(
                                alignment: Alignment.center,
                                child: defaultButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate())
                                    {
                                      RegisterCubit.get(context).userRegister(
                                        id: idController.text,
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        image: '',
                                      );
                                    }
                                  },
                                  text: 'Register',
                                  backgroundColor:
                                  AppCubit.get(context).isDark ? Colors.green : Colors.deepOrange,
                                ),
                              ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),

                        //SizedBox between Login Button and Don't have an account
                        SizedBox(
                          height: height * 0.019,
                        ),

                        // Row that contain Don't have an account text and Register TextButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account?',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color:
                                AppCubit.get(context).isDark ? Colors.black : Colors.white,
                              ),
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  LoginScreen(),
                                );
                              },
                              text: 'Login',
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
