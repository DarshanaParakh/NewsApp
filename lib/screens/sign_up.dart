import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/navbar.dart';
import 'package:newsapp/widgets/button.dart';

import '../widgets/form.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool indicator = false;

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
                  'Sign Up',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Forms(
                label: 'Full Name',
                controller: _nameController,
                icon: Icons.person,
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
                text: 'Sign Up',
                onPressed: () async {
                  setState(() {
                    indicator = true;
                  });
                  try {
                    final dynamic newUser =
                        await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (newUser != null) {
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
