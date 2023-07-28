import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          'LogIn',
          style: GoogleFonts.manrope(
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
            fontSize: 17,
          ),
        ),

        /// Going to REGISTER page
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.black87,
              ),
              label: Text(
                'Register',
                style: GoogleFonts.manrope(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                validator: (val) => (val!.isEmpty) || (val.trim().length < 6)
                    ? 'Enter an email'
                    : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (val) => (val!.length < 6) || (val.trim().length < 6)
                    ? 'Enter a password 6+ chars long'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(
                height: 60,
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          foregroundColor: Colors.red[400],
                          backgroundColor: Colors.grey[100]?.withAlpha(100)),
                      child: Text(
                        'Log In',
                        style: GoogleFonts.manrope(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() != null) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email, password);

                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Could not sign in with those credentials';
                            });
                          } else {
                            setState(() {
                              loading = true;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => TamagotchiScreen()),
                              // );
                              Navigator.pushReplacementNamed(context, '/Tamagotchi');
                              loading = false;
                            });
                          }
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
