
import '../../modules/login/login_screen.dart';
import '../network/local/cash_helper.dart';
import 'components.dart';

void signOut(context) {
  CashHelper.removeData(key: 'uId').then((value)
  {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String? uId;

String profileImage = '';

// void printFullText(String text) {
//   final pattern = RegExp('.{1,800}');
//   pattern.allMatches(text).forEach((match) => print(match.group(0)));
// }