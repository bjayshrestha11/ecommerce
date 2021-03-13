import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutcommerce/views/admin/admin.view.dart';
import 'package:flutcommerce/views/auth/login.view.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FirebaseAuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  Rx<User> _firebaseUser = Rx<User>();

  String get user => _firebaseUser.value?.email;
  String get imageurl => _firebaseUser.value?.photoURL;

  @override
  // ignore: must_call_super
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    print(" Auth Change :   ${_auth.currentUser}");
  }

  // function to createuser, login and sign out user

  void createUser(
      String firstname, String lastname, String email, String password) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("Users");

    Map<String, String> userdata = {
      "First Name": firstname,
      "Last Name": lastname,
      "Email": email
    };

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      reference.add(userdata).then((value) => Get.offAll(LoginWidget()));
    }).catchError(
      (onError) =>
          Get.snackbar("Error while creating account ", onError.message),
    );
  }

  void login(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Get.offAll(AdminWidget()))
        .catchError(
            (onError) => Get.snackbar("Error while sign in ", onError.message));
  }

  void signout() async {
    await _auth.signOut().then((value) => Get.offAll(LoginWidget()));
  }

  void sendpasswordresetemail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(LoginWidget());
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError(
        (onError) => Get.snackbar("Error In Email Reset", onError.message));
  }

  void deleteuseraccount(String email, String pass) async {
    User user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    await user.reauthenticateWithCredential(credential).then((value) {
      value.user.delete().then((res) {
        Get.offAll(LoginWidget());
        Get.snackbar("User Account Deleted ", "Success");
      });
    }).catchError((onError) => Get.snackbar("Credential Error", "Failed"));
  }

  void googleLogIn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final User user = (await _auth
        .signInWithCredential(credential)
        .then((value) => Get.offAll(AdminWidget())));
    
    print(user.displayName);

  }

  void googleSignOut() async {
    await googleSignIn.signOut().then((value) => Get.offAll(LoginWidget()));
  }

  Future<Null> fbLogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
}
