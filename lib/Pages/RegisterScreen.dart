import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              backgroundColor: Colors.grey[400],
              elevation: 5.0,
              title: Text(
                'Sign up',
                style: GoogleFonts.manrope(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                  fontSize: 17,
                ),
              ),

              /// Going to SIGN IN page
              actions: <Widget>[
                TextButton.icon(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.black87,
                    ),
                    label: Text(
                      'Sign In',
                      style: GoogleFonts.manrope(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      //widget.toggleView(),ss
                    }),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 12.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (val) =>
                          (val!.isEmpty) || (val.trim().length < 6)
                              ? 'Enter an email'
                              : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) =>
                          (val!.length < 6) || (val.trim().length < 6)
                              ? 'Enter a password 6+ chars long'
                              : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 60,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Colors.grey[100]?.withAlpha(100),
                              foregroundColor: Colors.pink[400],
                            ),
                            child: Text(
                              'RegisterScreen',
                              style: GoogleFonts.manrope(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontSize: 17,
                              ),
                            ),
                            onPressed: () async {
                              // if the user has interracted with this form and button
                              if (_formKey.currentState?.validate() != null) {
                                setState(() {
                                  loading = true;
                                });

                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);

                                print('AM INTRODUS IN BAZA DE DATE');

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Please supply a valid email';
                                  });
                                } else {
                                  print('NU E NUUUUUUUUUUUL');

                                  setState(() {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           TamagotchiScreen()),
                                    // );
                                    Navigator.pushReplacementNamed(context, '/Tamagotchi');
                                    loading = false;
                                  });
                                }
                              }
                            }),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
