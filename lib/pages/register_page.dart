import 'package:final_projek/pages/login_page.dart';
import 'package:final_projek/services/database/goal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    var now = DateTime.now();
    var formatedDate = DateFormat('dd MMM yyyy').format(now);
    var yearFormate = DateFormat('yyyy').format(now);
    await Goal.addProgress(
      year: yearFormate,
      goal: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  headerWidget(),
                  registerForm(),
                  registerButton(),
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
                        "Already have an account ?",
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          "Sign In",
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
    );
  }

  // widget header
  Widget headerWidget() {
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
          'Get On Board',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Create Your Account',
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  // widget untuk menampilkan form inputan
  Widget registerForm() {
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
          ),
        ),
      ]),
    );
  }

  // Button untuk login dengan email dan password
  Widget registerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: signUp,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Register",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
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
