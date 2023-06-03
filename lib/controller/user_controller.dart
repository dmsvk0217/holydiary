import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxString uid = "".obs;
  RxString email = "".obs;
  RxString image = "".obs;
  RxString name = "".obs;

  // used in writing diary page
  RxString contentGPT = "this is content".obs;
  RxString content = "this is contentGPT".obs;

  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      print("-----------authStateChanges----------");
      if (user != null) {
        uid.value = user.uid;
        bool loginWithGoogle = await isSignedInWithGoogleOrAnonymous();
        if (loginWithGoogle) {
          for (final providerProfile in user.providerData) {
            uid.value = providerProfile.uid!;
            email.value = providerProfile.displayName!;
            image.value = providerProfile.photoURL!;
            name.value = providerProfile.displayName!;
          }
          if (await isFirstTimeSignIn()) {
            await addGoogleUser();
          }
        } else {
          uid.value = "";
          email.value = "";
          image.value = "";
          name.value = "";
        }
      } else {
        uid.value = "";
        email.value = "";
        image.value = "";
        name.value = "";
      }
    });
  }

  Future<void> addAnonymousUser() async {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    await user.doc(uid.value).set(
      {
        'uid': uid.value,
        'status_message': "I promise to take the test honestly before GOD.",
      },
    );
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> addGoogleUser() async {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    await user.doc(uid.value).set(
      {
        'uid': uid.value,
        'name': name.value,
        'email': email.value,
        'status_message': "I promise to take the test honestly before GOD.",
      },
    );
  }

  Future<bool> isFirstTimeSignIn() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final userMetadata = user!.metadata;
    if (userMetadata.creationTime == userMetadata.lastSignInTime) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    if (user != null &&
        user.providerData
            .any((element) => element.providerId == 'google.com')) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isSignedInWithGoogleOrAnonymous() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }

    // Check if the user is signed in with Google
    final isGoogleSignIn = user.providerData
        .any((provider) => provider.providerId == 'google.com');
    if (isGoogleSignIn) {
      return true;
    }

    // Check if the user is signed in anonymously
    final isAnonymousSignIn = user.isAnonymous;
    if (isAnonymousSignIn) {
      return true;
    }

    return false;
  }
}
