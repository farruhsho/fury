import 'package:graphql_flutter/graphql_flutter.dart';
import '../constants/api_constants.dart';

/// GraphQL client service for API communication
class GraphQLService {
  late GraphQLClient _client;
  GraphQLClient get client => _client;

  /// Initialize GraphQL client
  Future<void> initialize({String? authToken}) async {
    // Initialize Hive for caching
    await initHiveForFlutter();

    // Create HTTP Link
    final HttpLink httpLink = HttpLink(
      ApiConstants.graphqlEndpoint,
    );

    // Create WebSocket Link for subscriptions
    final WebSocketLink wsLink = WebSocketLink(
      ApiConstants.graphqlWsEndpoint,
      config: const SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    );

    // Create Auth Link
    final AuthLink authLink = AuthLink(
      getToken: () async => authToken != null ? 'Bearer $authToken' : null,
    );

    // Combine links
    Link link = authLink.concat(httpLink);

    // Use WebSocket link for subscriptions
    link = Link.split(
      (request) => request.isSubscription,
      wsLink,
      link,
    );

    // Create GraphQL Client
    _client = GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: link,
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.cacheAndNetwork,
          error: ErrorPolicy.all,
          cacheReread: CacheRereadPolicy.mergeOptimistic,
        ),
        mutate: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.all,
        ),
        subscribe: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.all,
        ),
      ),
    );
  }

  /// Update auth token
  void updateAuthToken(String token) {
    initialize(authToken: token);
  }

  /// Execute a query
  Future<QueryResult> query(
    String query, {
    Map<String, dynamic>? variables,
    FetchPolicy? fetchPolicy,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        variables: variables ?? {},
        fetchPolicy: fetchPolicy ?? FetchPolicy.cacheAndNetwork,
      ),
    );

    return result;
  }

  /// Execute a mutation
  Future<QueryResult> mutate(
    String mutation, {
    Map<String, dynamic>? variables,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: variables ?? {},
      ),
    );

    return result;
  }

  /// Subscribe to real-time updates
  Stream<QueryResult> subscribe(
    String subscription, {
    Map<String, dynamic>? variables,
  }) {
    return _client.subscribe(
      SubscriptionOptions(
        document: gql(subscription),
        variables: variables ?? {},
      ),
    );
  }

  /// Clear cache
  Future<void> clearCache() async {
    _client.cache.store.reset();
  }
}
