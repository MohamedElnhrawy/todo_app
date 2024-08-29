import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/app/locale/presentation/providers/locale_provider.dart';
import 'package:todo_app/core/common/app/providers/user_provider.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/fonts.dart';
import 'package:todo_app/core/services/injection_container.dart';
import 'package:todo_app/core/services/router.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/src/features/dashboard/presentation/providers/dashboard_controller.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

    await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => sl<LocaleProvider>()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            locale: localeProvider.locale,
            title: "TODO App",
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColor),
              useMaterial3: true,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: Fonts.poppins,
              appBarTheme: const AppBarTheme(
                color: Colors.transparent,
              ),
            ),
            onGenerateRoute: generateRoute,
          );
        },
      ),
    );
  }
}
