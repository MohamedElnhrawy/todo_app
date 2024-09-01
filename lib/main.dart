import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/app/locale/presentation/providers/locale_provider.dart';
import 'package:todo_app/core/common/app/providers/user_provider.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/fonts.dart';
import 'package:todo_app/core/services/injection_container.dart';
import 'package:todo_app/core/services/router.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/src/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:todo_app/src/features/tasks/data/models/task.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case AppConstants.taskName:
        try {
          if (Firebase.apps.isEmpty) {
            await Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            );
          }
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            return false;
          }
          final userId = user.uid;

          final fireStore = FirebaseFirestore.instance;

          await Hive.initFlutter();
          //
          if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
            Hive.registerAdapter(TaskModelAdapter());
          }
          await Hive.openBox<TaskModel>(AppConstants.hiveBox);
          final box = Hive.box<TaskModel>(AppConstants.hiveBox);
          final tasks = box.values.toList();

         // Fetch remote tasks to compare
          final remoteTasksSnapshot = await fireStore
              .collection(AppConstants.storeUsersCollection)
              .doc(userId)
              .collection(AppConstants.storeTasksCollection)
              .get();

          final remoteTasks = remoteTasksSnapshot.docs
              .map((doc) => TaskModel.fromFireStore(doc.id, doc.data()))
              .toList();

          final remoteTasksMap = {for (var task in remoteTasks) task.id: task};

          // Delete tasks in Firestore that are not in Hive
          for (final remoteTaskId in remoteTasksMap.keys) {
            if (!tasks.any((task) => task.id == remoteTaskId)) {
              await fireStore
                  .collection(AppConstants.storeUsersCollection)
                  .doc(userId)
                  .collection(AppConstants.storeTasksCollection)
                  .doc(remoteTaskId)
                  .delete();

              if (kDebugMode) {
                print('Deleted task $remoteTaskId from Firestore.');
              }
            }
          }

          // Update or add tasks in Firestore
          for (final task in tasks) {
            final remoteTask = remoteTasksMap[task.id];

            if (remoteTask == null || task.updatedAt.isAfter(remoteTask.updatedAt)) {
              try {
                await fireStore
                    .collection(AppConstants.storeUsersCollection)
                    .doc(userId)
                    .collection(AppConstants.storeTasksCollection)
                    .doc(task.id)
                    .set(task.toMap());
                await showNotification(
                    'Sync Successful', 'Task ${task.id} synced successfully.');
                if (kDebugMode) {
                  print('Synced task ${task.id} to Firestore.');
                }
              } catch (e) {
                await showNotification(
                    'Sync Failed', 'Failed to sync task ${task.id}.');
                if (kDebugMode) {
                  print('Failed to sync task ${task.id}: $e');
                }
              }
            }
          }

          await showNotification(
              'Sync Completed', 'All tasks have been synced with Firebase.');
        } catch (e) {
          if (kDebugMode) {
            print('Failed during sync operation: $e');
          }
          await showNotification(
              'Sync Failed', 'Failed during sync operation.');
        }
        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await initHive();

    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await _initNotifications();

    await init();
  } catch (e) {
    if (kDebugMode) {
      print('Error during app initialization: $e');
    }
  }

  runApp(const MyApp());
}

Future<void> _initNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSwatch(accentColor: Colours.primaryColor),
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

Future<void> showNotification(String title, String body) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    AppConstants.channelID,
    AppConstants.channelName,
    // 'Channel for sync notifications',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: AppConstants.payload,
  );
}
