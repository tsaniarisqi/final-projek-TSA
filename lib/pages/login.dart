import 'package:final_projek/pages/main_page.dart';
import 'package:final_projek/pages/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
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
                    showTextWidget(),
                    signInButton(),
                  ]),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          "Don't have an account ?",
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
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
            // controller: emailController,
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
            // controller: passwordController,
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
          Navigator.push(context,
              MaterialPageRoute(builder: (contex) => const MainPage()));
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // child: RaisedButton(
      //   onPressed: () async {
      //     // SignInSignUpResult result = await AuthService.signInWithEmail(
      //     //     email: emailController.text, pass: passwordController.text);
      //     // if (result.user != null) {
      //     //   Categories.userUid = _auth.currentUser.uid;
      //     //   Product.userUid = _auth.currentUser.uid;
      //     //   // Go to Profile Page
      //     //   Navigator.push(
      //     //     context,
      //     //     MaterialPageRoute(
      //     //       builder: (context) => ProductPage(),
      //     //     ),
      //     //   );
      //     // } else {
      //     //   // Show Dialog
      //     //   showDialog(
      //     //     context: context,
      //     //     builder: (context) => AlertDialog(
      //     //       title: Text("Error"),
      //     //       content: Text(result.message),
      //     //       actions: <Widget>[
      //     //         FlatButton(
      //     //           onPressed: () {
      //     //             Navigator.pop(context);
      //     //           },
      //     //           child: Text("OK"),
      //     //         )
      //     //       ],
      //     //     ),
      //     //   );
      //     // }
      //   },
      //   child: const Text(
      //     "Login",
      //     style: TextStyle(fontSize: 15, color: Colors.white),
      //   ),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      //   color: Colors.teal[300],
      //   elevation: 0,
      //   padding: const EdgeInsets.symmetric(vertical: 16),
      // ),
    );
  }

  // menampilkan text OR
  Widget showTextWidget() {
    return Row(
      children: const <Widget>[
        Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        SizedBox(width: 20),
        Text(
          "OR",
        ),
        SizedBox(width: 20),
        Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }

  // Button untuk signIn dengan account google
  Widget signInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: OutlinedButton(
        onPressed: () async {
          // SignInSignUpResult result = await AuthService.signInWithGoogle();
          // if (result.user != null) {
          //   Categories.userUid = _auth.currentUser.uid;
          //   Product.userUid = _auth.currentUser.uid;
          //   // Go to Profile Page
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ProductPage(),
          //     ),
          //   );
          // } else {
          //   // Show Dialog
          //   showDialog(
          //     context: context,
          //     builder: (context) => AlertDialog(
          //       title: Text("Error"),
          //       content: Text(result.message),
          //       actions: <Widget>[
          //         FlatButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           child: Text("OK"),
          //         )
          //       ],
          //     ),
          //   );
          // }
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Image(
                  image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png'),
                  height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
