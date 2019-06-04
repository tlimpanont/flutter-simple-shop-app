import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://api.graph.cool/simple/v1/cjwgpfmwi49h4018345iwgiks',
);

final AuthLink _authLink = AuthLink(
  getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  // OR
  // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
);

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
