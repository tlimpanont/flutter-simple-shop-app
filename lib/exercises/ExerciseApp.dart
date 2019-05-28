import 'package:flutter/material.dart';

import 'package:flutter_app/exercises/CardWithDivider.dart';
import 'package:flutter_app/exercises/CardWithExpansion.dart';
import 'package:flutter_app/exercises/FullCard.dart';

class ExerciseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        initialRoute: '/',
        routes: {
          // When we navigate to the "/" route, build the FirstScreen Widget
          '/home': (context) => FullCard(),
          // When we navigate to the "/second" route, build the SecondScreen Widget
          '/second': (context) => CardWithDivider(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: "My App",
        home: Scaffold(
          appBar: AppBar(
            title: Text('Demo App'),
          ),
          drawer: Drawer(
            child: Center(child: Text('Drawer')),
          ),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Hello!')));
                Navigator.pushNamed(context, '/second');
              },
              child: Icon(Icons.device_hub),
            );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Builder(
            builder: (context) {
              return BottomNavigationBar(
                onTap: (int index) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Tapped on $index'),
                    duration: Duration(milliseconds: 10),
                  ));
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text('home')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.edit), title: Text('Edit')),
                ],
              );
            },
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  CardWithExpansion(),
                  CardWithDivider(),
                  FullCard()
                ],
              )
            ],
          ),
        ));
  }
}
