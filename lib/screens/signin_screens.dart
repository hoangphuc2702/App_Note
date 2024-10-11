import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/api.dart';
import '../model/data_local/user_reference.dart';
import '../model/user.dart';
import '../provider/google_sign_in_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();

  API api = API();

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showFailDialog("Login fail", "All fields are required.");
      return;
    }

    final res = await api.loginUser(email, password);

    if (res == "true") {
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      _showFailDialog("Login fail", res);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignInProvider.signOutGoogle();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        throw Exception("Firebase user is null after sign in");
      }
    } catch (error) {
      _showFailDialog("Login fail", error.toString());
    }
  }

  void _showFailDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Daily Planner',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mật khẩu',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: _login,
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: OutlinedButton.icon(
                onPressed: _handleGoogleSignIn,
                icon: Icon(Icons.login),
                label: Text(
                  'Đăng nhập bằng Google',
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text.rich(TextSpan(
                  text: 'Chưa có tài khoản? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Đăng ký',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}