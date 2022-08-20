import 'package:api_integrator/models/LoginRes.dart';
import 'package:api_integrator/models/NotifReq.dart';
import 'package:api_integrator/utils/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/ApiService.dart';
import 'home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

List<Data>? _Users;
bool _isLoading = true;
var _body = ListView();
bool clicked = false;
String? Token;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance!.addPostFrameCallback((_) => _GetUsers());
  }

  BuildContext? ctx;
  @override
  Widget build(BuildContext context) {
    return Provider<ApiClient>(
      create: (context) => ApiClient.create(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(builder: (BuildContext newContext) {
          return Profil(newContext);
        }),
      ),
    );
  }

  Profil(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.orange),
                    child: Stack(
                      children: [
                        Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        Positioned(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ListTile(
                              title: Text(
                                "Strings.token",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    tileColor: Colors.grey.withOpacity(0.1),
                    leading: Icon(
                      Icons.info,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    tileColor: Colors.grey.withOpacity(0.1),
                    leading: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Change your details",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    tileColor: Colors.grey.withOpacity(0.1),
                    leading: Icon(
                      Icons.notifications_active,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Send notification",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () async {
                      String? token =
                          await FirebaseMessaging.instance.getToken();
                      print("token generated----->" + token.toString());
                      Token = token;
                      print(Token);
                      _NotifToken();
                    },
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    tileColor: Colors.grey.withOpacity(0.1),
                    leading: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Delete Your Account",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 0,
              child: ListTile(
                  tileColor: Colors.black,
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()));
                  }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('New App'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.grey.shade200,
        child: _isLoading
            ? Container()
            : ListView.builder(
                itemCount: _Users!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        // Text(_Users![index].name.toString()),
                        // Text(_Users![index].designation.toString()),
                        // Text(_Users![index].phoneNum.toString())
                      ],
                    ),
                  );
                }),
      ),
    );
  }

  _NotifToken() {
    print("notif starts");
    NotifReq notif = NotifReq();
    notif.token = Token;
    final api = Provider.of<ApiClient>(ctx!, listen: false);
    api.notification(notif);
  }

  // _GetUsers() {
  //   final api = Provider.of<ApiClient>(ctx!, listen: false);
  //   api.getUsers().then((response) {
  //     print(response.status);
  //     if (response.status == true) {
  //       _Users = response.data;

  //       setState(() {
  //         print("Users:" + _Users![0].toJson().toString());
  //         _isLoading = false;
  //       });
  //       print("data: ${_Users!.length.toString()}");
  //     } else {
  //       print(response.status.toString());
  //       SnackBar(content: Text(response.status.toString()));
  //     }
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }
}
