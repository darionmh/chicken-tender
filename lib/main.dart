import 'dart:ffi';

import 'package:chickentender/CategoryListWidget.dart';
import 'package:chickentender/CategoryRepository.dart';
import 'package:chickentender/FilterDialog.dart';
import 'package:chickentender/HomeScreen.dart';
import 'package:chickentender/PlacesRepository.dart';
import 'package:chickentender/SearchBox.dart';
import 'package:chickentender/VenueListWidget.dart';
import 'package:chickentender/VenueRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  // NOTE: The filename will default to .env and doesn't need to be defined in this case
  await DotEnv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chicken Tender',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: LoginPage(),
                );
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.signInAnonymously(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MainPage(user: snapshot.data.user);
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final User user;

  MainPage({key, this.user}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CategoryRepository categoryRepository;
  PlacesRepository placesRepository;
  VenueRepository venueRepository;

  @override
  void initState() {
    super.initState();

    categoryRepository = CategoryRepository.getInstance();
    placesRepository = PlacesRepository.getInstance();
    venueRepository = VenueRepository.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
