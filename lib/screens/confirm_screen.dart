import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/services/auth.dart';
import 'home screen.dart';

class ConfirmScreen extends StatefulWidget {
  static final String routeName = 'confirm_screen';

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final _formKey = GlobalKey<FormState>();
  String _code;
  String _errorLogin;

  _submit() async {
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false).checkPhone(_code);
      _errorLogin = null;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      setState(() {
        _errorLogin = error.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF56CCF2),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 150 - AppBar().preferredSize.height - 25, 20, 128),
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
                      textAlign: TextAlign.center,
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
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'sms код',
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                          ),
                          onSaved: (input) => _code = input,
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
                          'Отправить',
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
