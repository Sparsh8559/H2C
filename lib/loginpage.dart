import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';

class Mylogin extends StatefulWidget {
  const Mylogin({Key? key}) : super(key: key);

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
      final _formKey = GlobalKey<FormState>();

    String email="";
    String password="";
    bool remember = false;
    bool loading = false;
    final List<String> errors = [];


    void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

    Container LoadingContainer() {
    return Container(
      // color: Colors.green[200],
      child: Center(
        child: SpinKitRing(
          color: Colors.green,
          size: 45.0,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
return loading ? LoadingContainer() : Form(key: _formKey,
child: 
Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_background.png'), fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35,top: 130),
              child: Text(
                'Welcome\nUser',style: TextStyle(color: Colors.white,fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5, right: 40,left: 40),
                child: Column(
                  children: [
                    buildEmailFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
                    SizedBox(
                      height: 40,
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle
                            (
                              fontSize: 27,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              _formKey.currentState!.save();
                              int responseCode = await LoginInfo(email, password);
                              if (responseCode == 200){
                                Navigator.pushReplacementNamed(context, 'home');
                              }
                              else {
                              setState(() => loading = false);
                                LoginFailureAlertBox(context);
                              }
                              }
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, 'register');
                        },
                            child: Text(
                          'Sign up',
                          style: TextStyle(decoration: TextDecoration.underline,
                        fontSize: 18,
                        color: Colors.blue),)),
                        TextButton(onPressed: (){}, child: Text('Forgot Password',
                          style: TextStyle(decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.blue),))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
 
);

  }
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}





Future<int> LoginInfo(email, password) async {
  print(email);
  print(password );
  print("Come here baby");
  final response = await http.post(
    Uri.parse('http://52.66.31.173/login/IKkS5YPBWP6GPZiuvPB91hk0Qbm0JNsn/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',

    },
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String acessToken = jsonDecode(response.body)['access_token'];
    // prefs.setString('access', acessToken);
    // Access_token = acessToken;
    final storage = new FlutterSecureStorage();
    String acessTokenSecure = jsonDecode(response.body)['token'];
    print(acessTokenSecure);
    await storage.write(key: 'accessToken', value: acessTokenSecure);
    // print('******************************************** access token *******************************8');
    // print(await storage.read(key: 'accessToken'));
    await storage.write(key: 'email', value: email);

  }
  return response.statusCode;

}


void LoginFailureAlertBox(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 24.0,
        backgroundColor: Colors.red[400],
        title: Text(
          "User Not Logged In !",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content:Text("Use Could not be loggedin ",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black ),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text(
              "Okay",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      );
    },
  );
}
