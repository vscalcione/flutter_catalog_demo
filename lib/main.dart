import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog_demo/app_theme.dart';
import 'package:flutter_catalog_demo/routes/router.gr.dart';
import 'package:flutter_catalog_demo/values/values.dart';

import 'bloc/theme_bloc.dart';

void main() {
  runApp(FlutterCatalogDemo());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class FlutterCatalogDemo extends StatefulWidget {
  @override
  _FlutterCatalogDemoState createState() => _FlutterCatalogDemoState();
}

class _FlutterCatalogDemoState extends State<FlutterCatalogDemo> {
  ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = ThemeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuider<ThemeData>(
      initialData: _themeBloc.initialTheme().data,
      stream: _themeBloc.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: snapshot.data,
          darkTheme: null,
          builder: ExtendedNavigator<AppRouter>(
            router: AppRouter(),
            initialRoute: Routes.rootScreen,
            initialRouteArgs: RouteScreenArguments(themeBloc: _themeBloc),
            observers: [routeObserver],
          ),
        );
      },
    );
  }
}
