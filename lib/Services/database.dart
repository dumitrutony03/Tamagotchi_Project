// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../Models/User.dart';

// class DatabaseService {
//   final String? uid;

//   DatabaseService({this.uid});

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // create user obj based on firebase user
//   UserModel? _userFromFirebaseUser(User? user) {
//     return user != null ? UserModel(uid: user.uid) : null;
//   }

//   // auth change user stream
//   Stream<UserModel?> get userStream {
//     print(_auth.authStateChanges().map(_userFromFirebaseUser));
//     return _auth.authStateChanges().map(_userFromFirebaseUser);
//   }

//   // collection reference
//   final CollectionReference tamagotchiCollection =
//       FirebaseFirestore.instance.collection('TamagotchiCollection');

//   Future<void> updateTamiData(
//       int healthPercentage, int happinessPercentage) async {
//     return await tamagotchiCollection.doc(uid).set({
//       'healthPercentage': healthPercentage,
//       'happinessPercentage': happinessPercentage,
//     });
//   }
// }
