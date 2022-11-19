abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates
{
  final String uId, city, technicalPhone;

  LoginSuccessState(this.uId, this.city,this.technicalPhone);
}

class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}

class CreateLoginUserSuccessState extends LoginStates {}

class CreateLoginUserErrorState extends LoginStates
{
  final String error;

  CreateLoginUserErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}