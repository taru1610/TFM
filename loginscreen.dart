import 'package:finance_manager/resetscreen.dart';
import 'package:finance_manager/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'financescreen.dart';
import 'models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login'; 
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState>_formKey = GlobalKey();

  Map<String,String> _authData = {
    'email' : '',
    'password': '',
  };

  void _showErrorDialog(String msg){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
          onPressed: (){
            Navigator.of(ctx).pop();
          },
          child: Text('Okay')
          )
        ],
      ),
    );
  }

  Future<void> _login() async{
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logIn(
      _authData['email'],
      _authData['password'],
      );
      Navigator.of(context).pushReplacementNamed(FinanceScreen.routeName);
    }catch(error){
      var errorMessage = 'Authentication Failed. Please try later.';
      _showErrorDialog(errorMessage);
    }
    
  }

  showErrorDialog(String errormessage) => _showErrorDialog(errormessage);

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xFF26A69A);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Log in and continue',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),

                SizedBox(height: 50,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      keyboardType:TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                          icon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                      // prefix: Icon(icon),
                      border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: secondaryColor),
                ),
                    ),
                    validator: (value){
                      if(value.isEmpty || !value.contains('@')){
                    return 'invalid email';
                  }
                  return null;
                },
                onSaved: (value){
                  _authData['email'] = value;
                },
              ),

              SizedBox(height:30),

            TextFormField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              keyboardType:TextInputType.emailAddress,
              decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
              icon: Icon(
                    Icons.lock,
                    color: Colors.white,
              ),
              // prefix: Icon(icon),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: secondaryColor),
                ),
              ),
              validator: (value){
                    if(value.isEmpty || value.length <= 5){
                      return 'invalid password';
                    }
                    return null;
                },
                onSaved: (value){
                  _authData['password'] = value;
                },
              ),
             ]
            )
          ),
        ),
                SizedBox(height: 50),

                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    _login();
                  },
                  color: logoGreen,
                  child: Text('Login',
                   style: TextStyle(color: Colors.white, fontSize: 16)),
                   textColor: Colors.white,
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ResetScreen()));
                  },
                  child: Text('Forget Password ?',
                  textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 12)
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height : 20),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignupScreen()));
                  },
                  child: Text('Create an Account',
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 12)
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                )
              ],
            ),
          ),
        )
      );
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/splash-image.png',
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: Text('The Finance Manager',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
