import 'package:coffee_app/services/auth_service.dart';
import 'package:coffee_app/shared/constants.dart';
import 'package:coffee_app/shared/error_dialog.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  ErrorDialog errorDialog = ErrorDialog();

  bool loading = false;

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('SignIn'),
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  label: Text(
                    'Sign Up',
                  ),
                  icon: Icon(Icons.person),
                  textColor: Colors.white,
                ),
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
                        return value.isEmpty ? "email cannot be empty" : null;
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
                      validator: (value) {
                        return value.isEmpty
                            ? "password cannot be empty"
                            : null;
                      },
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          return password = val.trim();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                      child: Text(
                        'Sign In',
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
                              .signInWithEmailAndPas(email, password);
                          if (result == null) {
                            errorDialog.information(
                                context, "Error", _authService.error_message);
                            setState(() {
                              loading = false;
                            });
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
