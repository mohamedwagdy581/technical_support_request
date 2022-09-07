abstract class RequestStates {}

class RequestInitialState extends RequestStates {}

class RequestLoadingState extends RequestStates {}

class RequestSuccessState extends RequestStates {}

class RequestErrorState extends RequestStates
{
  final String error;

  RequestErrorState(this.error);
}

class CreateRequestSuccessState extends RequestStates {}

class CreateRequestErrorState extends RequestStates
{
  final String error;

  CreateRequestErrorState(this.error);
}

class PickImageSuccessState extends RequestStates{}

// Change Mode Theme of App
class AppChangeModeThemeState extends RequestStates {}

