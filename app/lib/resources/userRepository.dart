import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/constants/strings.dart';
import 'package:app/enums/authState.dart';
import 'package:app/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/utilities/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  GoogleSignIn _googleSignIn;
  Muser _fuser;
  Status _status = Status.Uninitialized;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  UserRepository.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  User get user => _user;
  Muser get getUser => _fuser;

  Future<User> getCurrentUser() async {
    try {
      User currentUser;
      currentUser = _auth.currentUser;
      return currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> refreshUser() async {
    Muser ruser = await getUserDetails();
    _fuser = ruser;
    // Prefs.saveUserRole(ruser.userRole);
    notifyListeners();
  }

  Future<Muser> getUserDetails() async {
    try {
      User currentUser = await getCurrentUser();

      DocumentSnapshot documentSnapshot =
          await _userCollection.doc(currentUser.uid).get();
      return Muser.fromMap(documentSnapshot.data());
    } catch (e) {
      print("Error while getiing user detail");
      print(e);
      return _fuser;
    }
  }

  Future<Muser> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _userCollection.doc(id).get();
      return Muser.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.doc(uid).snapshots();

  Future<bool> authenticateUser(User nuser) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: nuser.email)
        .where("uid", isEqualTo: nuser.uid)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    Muser user = Muser(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoURL,
      phoneNumber: null,
      address: null,
      username: username,
    );
    Utils.saveToPrefereces(
      name: currentUser.displayName,
      photo: currentUser.photoURL,
      userId: currentUser.uid,
      email: currentUser.email,
      phoneNumber: null,
      address: null,
    );

    firestore
        .collection(USERS_COLLECTION)
        .doc(currentUser.uid)
        .set(user.toMap(user));
  }

  Future<bool> updateProfile(Muser upUser) async {
    refreshUser();
    try {
      await firestore
          .collection(USERS_COLLECTION)
          .doc(user.uid)
          .update(upUser.toMap(upUser));

      Utils.saveToPrefereces(
        name: upUser.name,
        photo: upUser.profilePhoto,
        userId: user.uid,
        email: upUser.email,
        phoneNumber: upUser.phoneNumber,
        address: upUser.address,
      );
      refreshUser();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addDataToFdb(User newUser, String name) async {
    String username = Utils.getUsername(newUser.email);

    Muser user = Muser(
      uid: newUser.uid,
      email: newUser.email,
      name: name,
      profilePhoto: BLANK_IMAGE,
      phoneNumber: null,
      address: null,
      username: username,
    );
    Utils.saveToPrefereces(
      name: name,
      photo: BLANK_IMAGE,
      userId: newUser.uid,
      email: user.email,
      phoneNumber: null,
      address: null,
    );

    FirebaseFirestore.instance
        .collection(USERS_COLLECTION)
        .doc(newUser.uid)
        .set(user.toMap(user));
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("Error While Sign In");
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String name) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        if (result.user != null) {
          authenticateUser(result.user).then((isNewUser) {
            if (isNewUser) addDataToFdb(result.user, name);
          });
        }
      });
      return true;
    } catch (e) {
      print(e.toString());
      Utils.showToast("Error While Sign Up");
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _signInAuthentication =
          await _signInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: _signInAuthentication.accessToken,
          idToken: _signInAuthentication.idToken);

      await _auth.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          authenticateUser(value.user).then((isNewUser) {
            if (isNewUser)
              addDataToDb(value.user);
            else {
              Utils.saveToPrefereces(
                name: getUser.name,
                photo: getUser.profilePhoto,
                userId: value.user.uid,
                email: value.user.email,
                phoneNumber: getUser.phoneNumber,
                address: getUser.address,
              );
            }
          });
        }
      });
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
      _googleSignIn.signOut();
      _status = Status.Unauthenticated;

      Utils.saveToPrefereces(
                name: null,
                photo: null,
                userId: null,
                email: null,
                phoneNumber: null,
                address: null,
              );
      notifyListeners();
      return Future.delayed(Duration.zero);
    } catch (e) {
      print(e.toString());
      _status = Status.Authenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      await refreshUser();
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
