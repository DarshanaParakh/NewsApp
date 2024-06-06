import 'package:flutter/material.dart';
import 'package:newsapp/screens/login.dart';
import 'package:newsapp/screens/sign_up.dart';
import 'package:newsapp/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/splash_screen_image_2.png',
              scale: 4,
            ),
            Column(
              children: [
                Button(
                  text: 'Sign Up using email',
                  padding: const EdgeInsets.only(right: 10),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
                Button(
                  text: 'Login using email',
                  padding: const EdgeInsets.only(right: 10),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
