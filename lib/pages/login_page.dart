import 'package:final_projek/pages/main_page.dart';
import 'package:final_projek/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SafeArea(
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    loginHeaderWidget(),
                    loginForm(),
                    loginButton(),
                  ]),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 180),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          "Don't have an account ?",
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            "Register here",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // widget header
  Widget loginHeaderWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          "img/person2.png",
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Welcome to ...',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Remember Your Book',
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  // widget untuk menampilkan form inputan
  Widget loginForm() {
    return Form(
      // key: _formKey,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Enter Email",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Enter an Email Address';
            //   } else if (!value.contains('@')) {
            //     return 'Please enter a valid email address';
            //   }
            //   return null;
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Enter Password",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // The validator receives the text that the user has entered.
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Enter Password';
            //   } else if (value.length < 6) {
            //     return 'Password must be atleast 6 characters!';
            //   }
            //   return null;
            // },
          ),
        ),
      ]),
    );
  }

  // Button untuk login dengan email dan password
  Widget loginButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        onPressed: () {
          signIn();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          primary: const Color(0xffC5930B),
        ),
      ),
    );
  }
}
