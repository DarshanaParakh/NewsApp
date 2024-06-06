import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/widgets/button.dart';

import '../navbar.dart';
import '../widgets/form.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool indicator = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: ModalProgressHUD(
          inAsyncCall: indicator,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text(
                  'Login',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Forms(
                label: 'Email',
                controller: _emailController,
                icon: Icons.email,
              ),
              Forms(
                label: 'Password',
                controller: _passwordController,
                icon: Icons.lock,
                obscure: true,
              ),
              Button(
                text: 'Login',
                onPressed: () async {
                  setState(() {
                    indicator = true;
                  });
                  try {
                    final dynamic user = await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => NavigationBarPage()));
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    indicator = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
