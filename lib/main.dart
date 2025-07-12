import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'helpers/app_export.dart';
import 'inject_container.dart';
import 'localization/app_localization.dart';
import 'localization/bloc/local_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LocalBloc(),
            ),
          ],
          child: BlocBuilder<LocalBloc, LocalState>(
            builder: (context, localState) {
              return MaterialApp(
                scaffoldMessengerKey:
                    getIt<GlobalKey<ScaffoldMessengerState>>(),
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: localState.locale,
                localizationsDelegates: const [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale(
                    'en',
                  ),
                  Locale(
                    'fr',
                  ),
                ],
                initialRoute: AppRoutes.initialRoute,
                routes: AppRoutes.routes,
              );
            },
          ),
        );
      },
    );
  }
}
