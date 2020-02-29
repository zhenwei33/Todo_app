import 'package:flutter/material.dart';
import 'package:todo_app/UI/Login/loginscreen.dart';
import 'package:todo_app/UI/intray/intray_page.dart';
import 'package:todo_app/models/global.dart';
import 'package:todo_app/models/classes/user.dart';
import 'package:todo_app/bloc/blocs/user_bloc_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    // bloc.registerUser("uname1", "ding1", "ding2", "test1@email.com", "pass1");
    return FutureBuilder(
      future: getApiKey(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String apiKey = "";
        if (snapshot.hasData) {
          apiKey = snapshot.data;
        } else {
          print('No data');
        }
        return apiKey.length > 0 ? getHomePage() : 
          LoginPage(
            login: login, newUser: false
          );
        //return LoginPage();
      }
    );
  }

  void login() {
    setState(() {
      build(context);
    });
  }

// = await SharedPreferences.getInstance();

  Future signinUser() async {
    String userName = "";
    String apiKey = await getApiKey();
    if (apiKey.length > 0) {
      bloc.signinUser("", "", apiKey);
    } else {
      print("No api key");
    }
    return apiKey;
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('API_Token');
  }

  Widget getHomePage() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.yellow,
      home: SafeArea(
                child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(
                children: <Widget>[
                  TabBarView(
                    children: [
                      IntrayPage(),
                      new Container(
                        color: Colors.orange,
                      ),
                      new Container(
                        child: Center(
                          child: FlatButton(
                            color: redColor,
                            child: Text("Logout"),
                            onPressed: () {
                              logout();
                            },
                          ),
                        ),
                        color: Colors.lightGreen,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Intray",
                          style: intrayTitleStyle,
                        ),
                        Container()
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(top: 130, left: MediaQuery.of(context).size.width*0.5-40),
                    child: FloatingActionButton(
                      child: Icon(Icons.add, size: 70),
                      backgroundColor: redColor,
                      onPressed: () {},
                    ),
                  )
                ]
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
                title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("API_Token", "");
    setState(() {
      build(context);
    });
  }
  @override
  void initState() {
    super.initState();
  }
}

