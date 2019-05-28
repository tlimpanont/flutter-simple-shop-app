import 'package:flutter/material.dart';

class FullCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      width: 500,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.group),
              ),
              title: Text('Title goes here',
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.title.fontSize)),
              subtitle: Text('Secondary text',
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.subtitle.fontSize)),
            ),
            Expanded(child: Image.asset('images/lake.jpg', fit: BoxFit.cover)),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'The card container is the only required element in a card. All other elements shown here are optional.',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.body1.fontSize),
              ),
            ),
            ButtonTheme.bar(
              child: Row(
                children: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('ACTION 1'),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text('ACTION 2'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    child: ButtonBar(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
