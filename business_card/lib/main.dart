import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('images/abbey.jpeg'), fit: BoxFit.fill),
                ),
              ),
              // CircleAvatar(
              //   radius: 50.0,
              //   // minRadius: 50.0,
              //   // maxRadius: 100.0,
              //   backgroundImage: AssetImage('images/abbey.jpeg'),
              // ),
              Text(
                'abiodun akindipe',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FULLSTACK DEVELOPER',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Source Sans',
                  letterSpacing: 2.5,
                  color: Colors.teal.shade100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.teal.shade100,
                  )),
              Card(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25.0,
                ),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '+2348085576707',
                    style: TextStyle(
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 2.5,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25.0,
                ),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'hafeezakindipe@gamil.com',
                    style: TextStyle(
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 2.5,
                      color: Colors.teal,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
