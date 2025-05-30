import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/instance_manager.dart';
import 'package:post_app/controller/c_user.dart';

class FirebaseAuthService {
  //this methode is to check if the user already login or not
  static Future<bool> isLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  //this method to change password in firebaseAuth
  Future changePassword(String newPassword) async {
    final auth = FirebaseAuth.instance.currentUser;
    final user = Get.put(CUser());
    final credentials = EmailAuthProvider.credential(
        email: auth!.email!, password: user.data.password!);
    await auth.reauthenticateWithCredential(credentials);
    await auth.updatePassword(newPassword);
  }
}
