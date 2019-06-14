import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://api.graph.cool/simple/v1/cjwgpfmwi49h4018345iwgiks',
);

final AuthLink _authLink = AuthLink(getToken: () async {
  final prefs = await SharedPreferences.getInstance();
  final token = (prefs.get('user') != null)
      ? 'Bearer ${AuthenticatedUser.fromJSON(jsonDecode(prefs.get('user'))).token}'
      : '';
  return token;
});

final Link _link = _authLink.concat(_httpLink);

final GraphQLClient graphQLClient = GraphQLClient(
  cache: InMemoryCache(),
  link: _link,
);
final ValueNotifier<GraphQLClient> _client = ValueNotifier(graphQLClient);

class CustomGraphQLProvider extends StatelessWidget {
  final Widget child;

  CustomGraphQLProvider({this.child});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: _client, child: CacheProvider(child: this.child));
  }
}
