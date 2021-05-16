import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class JoinRepo{
  // FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  //FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);
}