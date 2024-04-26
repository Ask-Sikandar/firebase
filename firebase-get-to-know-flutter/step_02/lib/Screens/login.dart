import 'package:flutter/material.dart';
import 'package:gtk_flutter/Screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide EmailAuthProvider, PhoneAuthProvider;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> loginPass(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text('Email')
              ),
            ),
            TextFormField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(
                  label: Text('Password'),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){
                  loginPass(emailController.text, passController.text);
                },
                child: const Text('Login')
            ),
            const SizedBox(height: 20,),
            const Center(child: Text("Register if you haven't already")),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: const Center(child: Text('Register')),
            )
          ],
        ),
      ),
    );
  }
}
