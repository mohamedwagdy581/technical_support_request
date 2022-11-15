import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_requests/home_layout/home_layout.dart';
import 'package:technical_requests/shared/network/style/themes.dart';

import 'shared/components/constants.dart';
import 'shared/network/cubit/cubit.dart';
import 'shared/network/cubit/states.dart';
import 'shared/network/local/cash_helper.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  uId = CashHelper.getData(key: 'uId');
  city = CashHelper.getData(key: 'city');
  runApp(TechnicalRequests(isDark: isDark,));
}

class TechnicalRequests extends StatelessWidget {
  final bool? isDark;
  const TechnicalRequests({super.key, this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData()..changeAppModeTheme(fromShared: isDark,),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: uId == null ? const SplashScreen() : const HomeLayout(),
          );
        },
      ),
    );
  }
}
