import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routesProvider = Provider<List<RouteBase>>((ref) {
  return [
    // region Example
    // GoRoute(
    //   name: 'example',
    //   path: '/example',
    //   builder: (context, state) => const ExampleScreen(),
    // ),
    //endregion
  ];
});
