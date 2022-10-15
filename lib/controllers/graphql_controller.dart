import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:graphql/client.dart';

class GraphQLController extends GetxController with UiLoggy {
  final _httpLink = HttpLink(
    'https://defi-kingdoms-community-api-gateway-co06z8vi.uc.gateway.dev/graphql',
  );

  late AuthLink _authLink;
  late Link _link;
  late GraphQLClient client;

  int heroID = 1;

  late QueryOptions options;
  late QueryOptions options2;

  GraphQLController() {
    // _authLink = AuthLink(
    //   getToken: () async => 'Bearer YOUR_PERSONAL_ACCESS_TOKEN',
    // );
    // _link = _authLink.concat(_httpLink);

    /// subscriptions must be split otherwise `HttpLink` will swallow them

    options = QueryOptions(
      document: gql(
        """
          query getHero(\$heroId: ID!)
          {
            hero(id: \$heroId) {
              id
              mainClass
              owner {
                id
                name
              }
            }
          }
        """,
      ),
      variables: {
        'heroId': heroID,
      },
    );

    options2 = QueryOptions(
        document: gql(
      r'''
          query {
              hero(id: 1) {
                id
                mainClass
                owner {
                  id
                  name
                }
              }
        }
        ''',
    ));

    client = GraphQLClient(
      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: _httpLink,
    );
  }

  Future<String> getHeroData() async {
    QueryResult result = await client.query(options);
    logInfo(result.toString());
    return result.toString();
  }
}
