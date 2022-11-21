abstract class AppStates {}

// App Initial State
class AppInitialState extends AppStates {}

// Change BottomNavigationBar State
class AppChangeBottomNavigationBarState extends AppStates {}

// App Get User State
class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates
{
  final String error;

  AppGetUserErrorState(this.error);
}

// App Get All Document IDs State
class AppGetDocIDsLoadingState extends AppStates {}

class AppGetDocIDsSuccessState extends AppStates {}

class AppGetDocIDsErrorState extends AppStates
{
  final String error;

  AppGetDocIDsErrorState(this.error);
}

// App Get All Done Document IDs State
class AppGetDoneDocIDsLoadingState extends AppStates {}

class AppGetDoneDocIDsSuccessState extends AppStates {}

class AppGetDoneDocIDsErrorState extends AppStates
{
  final String error;

  AppGetDoneDocIDsErrorState(this.error);
}

// App Get All Archived Document IDs State
class AppGetArchivedDocIDsLoadingState extends AppStates {}

class AppGetArchivedDocIDsSuccessState extends AppStates {}

class AppGetArchivedDocIDsErrorState extends AppStates
{
  final String error;

  AppGetArchivedDocIDsErrorState(this.error);
}

// Profile Image Picked States
class AppProfileImagePickedSuccessState extends AppStates {}

class AppProfileImagePickedErrorState extends AppStates {}

// Cover Image Picked States
class AppCoverImagePickedSuccessState extends AppStates {}

class AppCoverImagePickedErrorState extends AppStates {}


// Change Mode Theme of App
class AppChangeModeThemeState extends AppStates {}
