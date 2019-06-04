import 'package:flutter/material.dart';

class EmptyStateIconLabel extends StatelessWidget {
  final String labelText;
  final IconData iconData;

  const EmptyStateIconLabel({Key key, this.labelText, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 50,
            foregroundColor: Colors.grey[600],
            child: Icon(
              iconData,
              size: 40,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '$labelText',
            style: Theme.of(context).textTheme.subhead,
          )
        ],
      ),
    );
  }
}
