import 'package:coffee_app/shared/constants.dart';
import 'package:coffee_app/shared/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/services/auth_service.dart';
import 'package:coffee_app/shared/loading.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  ErrorDialog errorDialog = ErrorDialog();

  bool loading = false;

  String email = "";
  String password = "";
  String password2 = "";

  bool validatePassword() {
    if (password == password2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('SignUp'),
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  label: Text(
                    'Sign In',
                  ),
                  textColor: Colors.white,
                  icon: Icon(Icons.person),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) {
                        return value.isEmpty ? 'Email cannot be empty' : null;
                      },
                      onChanged: (val) {
                        setState(() {
                          return email = val.trim();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (!validatePassword()) {
                          return "passwords do not match";
                        } else if (value.length < 6) {
                          return "password must be more than 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          return password = val.trim();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Repeat Password'),
                      obscureText: true,
                      validator: (value) {
                        if (!validatePassword()) {
                          return "passwords do not match";
                        } else if (value.length < 6) {
                          return "password must be more than 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          return password2 = val.trim();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _authService
                              .signUpWithEmailAndPass(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                            });
                            errorDialog.information(
                                context, "Error", _authService.error_message);
                          }
                        }
                      },
                      color: Colors.pink,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
