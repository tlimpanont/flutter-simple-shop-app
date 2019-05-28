import 'package:flutter/material.dart';

class _CardWithExpansionState extends State<CardWithExpansion> {
  bool _expanded = false;
  Color _color = Colors.red;
  double _height = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'images/lake.jpg',
              fit: BoxFit.cover,
              height: 220,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                leading: CircleAvatar(
                  child: Icon(Icons.group),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Elizabeth Parker',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      'Work Contact',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ],
                ),
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        '(023) 232442 - 2323',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      subtitle: Text(
                        'Mobile',
                        style: Theme.of(context).textTheme.subtitle,
                      )),
                  ListTile(
                      leading: Icon(Icons.email),
                      title: Text(
                        'somemail@demo.com',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      subtitle: Text(
                        'Email',
                        style: Theme.of(context).textTheme.subtitle,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWithExpansion extends StatefulWidget {
  @override
  _CardWithExpansionState createState() => _CardWithExpansionState();
}
