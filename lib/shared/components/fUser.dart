// FirebaseUser
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final userUID = auth.currentUser?.uid;
var userPhotoUrl = auth.currentUser?.photoURL;
final userDisplayName = auth.currentUser?.displayName;
