import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/commons/router/router.gr.dart';
import 'package:todo/gen/colors.gen.dart';

final _appRouter = AppRouter();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.mulishTextTheme(textTheme.apply(
          bodyColor: ColorName.text,
          displayColor: ColorName.text,

        )),
      ),
      builder: (context, child) {
        return Router(
          routerDelegate: AutoRouterDelegate(_appRouter),
          routeInformationParser: _appRouter.defaultRouteParser(),
          routeInformationProvider: _appRouter.routeInfoProvider(),
        );
      },
    );
  }
}
