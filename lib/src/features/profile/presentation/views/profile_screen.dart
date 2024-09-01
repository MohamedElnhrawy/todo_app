import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/common/widgets/app_bar.dart';
import 'package:todo_app/core/common/widgets/gradient_background.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/media_res.dart';
import 'package:todo_app/core/services/injection_container.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/src/features/auth/data/datasources/cache_local_data_source.dart';
import 'package:todo_app/src/features/auth/presentation/views/sign_in_screen.dart';
import 'package:todo_app/src/features/profile/presentation/widgets/profile_section_tile.dart';
import 'package:workmanager/workmanager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.isAR;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: context.currentUser?.fullName ?? context.l10n.account),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.only(left: 0,right: 0,top: 0),
          children: [
            ProfileSectionTile(
              title: context.l10n.change_language,
              actionWidget: Image.asset(
                width: 35,
                height: 35,
                language ? MediaRes.usIcon : MediaRes.egIcon,
              ),
              onTap: ()  {
                CoreUtils.showCustomDialog(
                    context: context,
                    title: context.l10n.confirmation,
                    message: context.l10n.change_language_message,
                    action1Title: context.l10n.cancel,
                    action2Title: context.l10n.ok,
                    action2: () async {
                      // change language
                      Navigator.of(context).pop();
                        context.currentLocale
                            .setLocale(Locale(language ? AppConstants.EN : AppConstants.AR));
                    });
              },
            ),
            ProfileSectionTile(
              title: context.l10n.logout,
              actionWidget: const Icon(
                Icons.logout_outlined,
                color: Colours.primaryColor,
              ),
              onTap: () async {
                CoreUtils.showCustomDialog(
                    context: context,
                    title: context.l10n.confirmation,
                    message: context.l10n.logout_message,
                    action1Title: context.l10n.cancel,
                    action2Title: context.l10n.ok,
                    action2: () {
                      // logout
                      Navigator.of(context).pop();
                      logout();
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                    });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(
                  color: Colors.grey.withOpacity(.5),
                  height: 1,
                ),
            ),

          ],
        ),
      ),
    );
  }

  void logout() async {
    await sl<SharedPreferences>().setBool(isUserLoggedIn, false);
    await sl<FirebaseAuth>().signOut();
    cancelWorkManagerTasks();
  }

  void cancelWorkManagerTasks() async {
    // Cancel all tasks
    await Workmanager().cancelAll();
    if (kDebugMode) {
      print('WorkManager tasks have been cancelled.');
    }
  }
}
