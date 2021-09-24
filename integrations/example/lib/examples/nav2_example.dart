import 'package:dart_board_core/dart_board.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DartBoard(features: [Nav2Feature()], initialRoute: '/home'));
}

class Nav2Feature extends DartBoardFeature {
  @override
  String get namespace => 'nav2';

  @override
  List<RouteDefinition> get routes => [
        NamedRouteDefinition(
            route: '/home', builder: (ctx, settings) => HomePage()),
        PathedRouteDefinition([
          /// Level 0
          [
            NamedRouteDefinition(
                route: '/root',
                builder: (ctx, settings) =>
                    Scaffold(appBar: AppBar(), body: Text('Root'))),
          ],

          /// Level 1 (e.g. /root/cata)
          [
            NamedRouteDefinition(
                route: '/cata',
                builder: (ctx, settings) =>
                    Scaffold(appBar: AppBar(), body: Text('A'))),
            NamedRouteDefinition(
                route: '/catb',
                builder: (ctx, settings) =>
                    Scaffold(appBar: AppBar(), body: Text('B')))
          ],

          /// Level 2
          [
            NamedRouteDefinition(
                route: '/details',
                builder: (ctx, settings) =>
                    Scaffold(appBar: AppBar(), body: Text('Details')))
          ],
        ])
      ];
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
            child: MaterialButton(
                onPressed: () {
                  Nav.pushRoute('/root/cata/details');
                },
                child: Text('Go To Details'))));
  }
}