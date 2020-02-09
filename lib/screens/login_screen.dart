import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/services/auth.dart';
import 'confirm_screen.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phone;
  String _errorLogin;

  _submit() async {
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false).login(_phone);
      _errorLogin = null;
      Navigator.pushNamed(context, ConfirmScreen.routeName);
    } catch (error) {
      setState(() {
        _errorLogin = error.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF56CCF2),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 150, 20, 128),
                child: const Text(
                  'App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48.0,
                      color: Color(0xFF4F4F4F)),
                  textAlign: TextAlign.center,
                ),
              ),
              _errorLogin == null
                  ? const SizedBox()
                  : Text(
                      _errorLogin,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFEB5757),
                      ),
                    ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        height: 36,
                        width: 250,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'номер телефона',
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                          ),
                          onSaved: (input) => _phone = input,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36.0),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        onPressed: _submit,
                        color: Colors.blue,
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
