import 'package:finance_manager/financescreen.dart';
import 'package:finance_manager/resetscreen.dart';
import 'package:finance_manager/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loginscreen.dart';
import 'models/authentication.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication())
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finance Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: 'Finance Login Screen'
          ),
        routes: {
          LoginScreen.routeName:(ctx) => LoginScreen(),
          SignupScreen.routeName:(ctx) => SignupScreen(),
          FinanceScreen.routeName:(ctx) => FinanceScreen(),
          ResetScreen.routeName:(ctx) => ResetScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _MyHomePageState extends State<MyHomePage> {

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xFF311B92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: primaryColor,
      ),
      body:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //We take the image from the assets
                Image.asset(
                  'images/splash-image.png',
                  height: 250,
                ),
                SizedBox(
                  height: 20,
                ),
                //Texts and Styling of them
                Text(
                  'Welcome to The Finance Manager !',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(5.5),
                child:Text(
                  'A one-stop portal for you to learn the latest technologies from SCRATCH',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                ),
                SizedBox(
                  height: 30,
                ),
                //Our MaterialButton which when pressed will take us to a new screen named as 
                //LoginScreen
                Padding(
                  padding: const EdgeInsets.only(left:30.0, right:30.0,top:30),
                  child: MaterialButton(
                    elevation: 0,
                    height: 50,
                    minWidth: double.maxFinite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    color: secondaryColor,
                    child:Text('LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 20)
                        ),
                    textColor: Colors.white,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: MaterialButton(
                    elevation: 0,
                    height: 50,
                    minWidth: double.maxFinite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignupScreen()));
                    },
                    color: secondaryColor,
                    child:Text('SIGNUP',
                          style: TextStyle(color: Colors.white, fontSize: 20)
                        ),
                      
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
    );
  }
}
