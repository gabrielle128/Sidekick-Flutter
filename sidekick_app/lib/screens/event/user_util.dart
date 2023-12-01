import 'package:firebase_auth/firebase_auth.dart';

class UserUtil {
  static String getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return '';
  }

  static String getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email ?? '';
    }
    return '';
  }
}
