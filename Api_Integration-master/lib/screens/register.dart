import 'package:api_integrator/models/LoginReq.dart';
import 'package:api_integrator/screens/home.dart';
import 'package:api_integrator/screens/profile.dart';
import 'package:api_integrator/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../network/ApiService.dart';

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    return Provider<ApiClient>(
        create: (context) => ApiClient.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(
            builder: (BuildContext newContext) {
              return Login(newContext);
            },
          ),
        ));
  }

  Login(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('New App'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.grey.shade900,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(
                  flex: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                      controller: _email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey.shade800),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
                Spacer(flex: 1),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Password",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade800),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ]),
                Spacer(flex: 3),
                Center(
                  child: Strings.registered
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.lightGreenAccent[700]),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              )),
                          onPressed: () {
                            if (_email.text != null && _password.text != null) {
                              _Login();
                            } else {
                              print("Please fill all fields");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 60),
                            child: Text(
                              "LOGIN",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        )
                      : TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(50)),
                              )),
                          onPressed: () {
                            _SignUp();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 56),
                            child: Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                ),
                Spacer(
                  flex: 5,
                ),
              ]),
        ),
      ),
    );
  }

  _SignUp() {
    LoginReq UserData = LoginReq();
    UserData.email = _email.text;
    UserData.password = _password.text;
    var api = Provider.of<ApiClient>(ctx!, listen: false);
    api.signUp(UserData).then((response) {
      print("status ${response.status}");
      if (response.status == true) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
      }
    });
  }

  _Login() {
    LoginReq UserData = LoginReq();
    UserData.email = _email.text;
    UserData.password = _password.text;
    var api = Provider.of<ApiClient>(ctx!, listen: false);
    api.login(UserData).then((response) {
      print("status ${response.status}");

      if (response.status == true) {
        Strings.token = response.token!;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage()));
      } else {}
    });
  }
}
