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

// Done Requests History States
class DoneHistoryRequestLoadingState extends RequestStates {}

class DoneHistoryRequestErrorState extends RequestStates
{
  final String error;

  DoneHistoryRequestErrorState(this.error);
}

class CreateDoneHistoryRequestSuccessState extends RequestStates {}

class CreateDoneHistoryRequestErrorState extends RequestStates
{
  final String error;

  CreateDoneHistoryRequestErrorState(this.error);
}


// Archived Requests History States
class ArchivedHistoryRequestLoadingState extends RequestStates {}

class ArchivedHistoryRequestErrorState extends RequestStates
{
  final String error;

  ArchivedHistoryRequestErrorState(this.error);
}

class CreateArchivedHistoryRequestSuccessState extends RequestStates {}

class CreateArchivedHistoryRequestErrorState extends RequestStates
{
  final String error;

  CreateArchivedHistoryRequestErrorState(this.error);
}


class PickImageSuccessState extends RequestStates{}

class ChangeLocationIconState extends RequestStates {}

// Change Mode Theme of App
class AppChangeModeThemeState extends RequestStates {}

