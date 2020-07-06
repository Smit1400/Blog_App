import 'package:blog_app/authentication/auth.dart';
import 'package:blog_app/signin/login.dart';
import 'package:blog_app/widgets/constants/constants.dart';
import 'package:blog_app/widgets/customized_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static Widget create() {
    return Provider<AuthService>(
      create: (context) => Auth(),
      child: Register(),
    );
  }

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _submit() async {
    try {
      setState(() {
        loading = true;
      });
      final auth = Provider.of<AuthService>(context, listen: false);
      String email = _emailController.text;
      String password = _passwordController.text;
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      if (firstName.isEmpty || lastName.isEmpty) {
        throw PlatformException(
            code: 'Field empty error',
            details: 'First Name and Last Name Cannot be empty');
      } else {
        await auth.createUserWithEmailAndPassword(
            email, password, firstName, lastName);
        Navigator.pop(context);
      }
    } on PlatformException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: backgroundColor,
            title: new Text("${e.code}"),
            content: new Text("${e.details}"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  height: 220,
                  width: MediaQuery.of(context).size.width - 100,
                  fit: BoxFit.contain,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomizedWidget(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextField(
                                controller: _firstNameController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    labelText: 'First Name',
                                    hintText: 'Smit'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: CustomizedWidget(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextField(
                                controller: _lastNameController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    labelText: 'Last Name',
                                    hintText: 'Shah'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 35),
                    CustomizedWidget(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              labelText: 'Email',
                              hintText: 'test@abc.com'),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    CustomizedWidget(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextField(
                          controller: _passwordController,
                          cursorColor: Colors.black,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    CustomizedWidget(
                      child: SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: RaisedButton(
                            color: backgroundColor,
                            elevation: 0,
                            onPressed: loading ? (){} : _submit,
                            child: loading
                                ? CircularProgressIndicator(
                              backgroundColor: backgroundColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blueGrey))
                                : Text('Sign Up'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'or',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login.create(),
                              ),
                            );
                          },
                          child: Text('Already Have an Account? Log in'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
