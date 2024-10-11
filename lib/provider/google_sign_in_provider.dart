import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Kiểm tra xem người dùng đã đăng nhập hay chưa
      final GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();

      // Nếu không có tài khoản đã đăng nhập, hiển thị hộp thoại
      if (googleUser == null) {
        final GoogleSignInAccount? newUser = await googleSignIn.signIn();
        if (newUser == null) {
          return null; // Người dùng hủy đăng nhập
        }
      }

      // Tiếp tục với quy trình đăng nhập
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Kiểm tra xem googleAuth có null không
      if (googleAuth == null) {
        throw Exception("Google authentication failed");
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}