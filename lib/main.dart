import 'package:chickentender/CategoryListWidget.dart';
import 'package:chickentender/FilterDialog.dart';
import 'package:chickentender/VenueListWidget.dart';
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
          appBar: AppBar(
            toolbarHeight: 8,
          ),
          body: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return LoginPage();
              }

              return CircularProgressIndicator();
            },
          )),
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
          return HomePage(user: snapshot.data.user);
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final User user;

  HomePage({key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOpen;

  @override
  void initState() {
    super.initState();

    isOpen = false;
  }

  void showSlideupView(BuildContext context) {
    if (!isOpen) {
      setState(() {
        isOpen = true;
      });
      var bottomSheetController = showBottomSheet(

          context: context,
          builder: (context) {
            return SizedBox(
              width: double.infinity,
              height: 300,
              child: DecoratedBox(
                child: CategoryListWidget(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            );
          });

      bottomSheetController.closed.then((value) => setState(() => isOpen = false));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (c) {
        if(isOpen) {
          Navigator.pop(context);
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text('Chicken Tender', style: TextStyle(fontSize: 24),),
                  ),
                  TextButton(
                    onPressed: () => showSlideupView(context),
                    child: Row(
                      children: [
                        Text('Filter'),
                        Icon(Icons.menu),
                      ],
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
            ),
            VenueListWidget(),
          ],
        ),
      ),
    );
  }
}
