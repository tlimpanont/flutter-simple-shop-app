import 'package:flutter/material.dart';

class CardWithDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'images/lake.jpg',
              fit: BoxFit.cover,
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 10,
                      children: <Widget>[
                        Text(
                          'Cafe Badilicico',
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Wrap(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('4.5 (413)'))
                          ],
                        ),
                        Text(
                          '\$ Italian, Cafe',
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dapibus dignissim laoreet. Suspendisse '
                        'tincidunt vulputate libero a pretium. Cras eget tortor nec orci pretium commodo a eu ante. ',
                        softWrap: true,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Tonight\'s availabilty',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Chip(
                          label: Text('5:30PM'),
                        ),
                        Chip(
                            label: Text('5:30PM'),
                            backgroundColor: Theme.of(context).accentColor,
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        Chip(
                          label: Text('5:30PM'),
                        ),
                        Chip(
                          label: Text('5:30PM'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    child: Text('RESERVE'),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ]),
    );
  }
}
