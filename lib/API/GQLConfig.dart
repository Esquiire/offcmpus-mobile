import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GQLConfig {
  static HttpLink httpLink = HttpLink("http://10.0.2.2:9010/graphql");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore())));

  GraphQLClient clientToQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore()));
}
