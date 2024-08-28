import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/app/providers/user_provider.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:todo_app/src/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:todo_app/src/features/dashboard/presentation/utils/dashboard_utils.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUser>(
        stream: DashboardUtils.userDataStream,
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data is LocalUser) {
            context.read<UserProvider>().user = snapshot.data;
          }
          return Consumer<DashboardController>(builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                showSelectedLabels: false,
                backgroundColor: Colors.white,
                elevation: 8,
                onTap: controller.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 0 ? IconlyBold.bookmark : IconlyLight.bookmark,
                      color: controller.currentIndex == 0 ? Colours.primaryColor : Colors.grey,
                    ),
                    label: context.l10n.tasks,
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 1 ? IconlyBold.paper_plus : IconlyLight.paper_plus,
                      color: controller.currentIndex == 1 ? Colours.primaryColor : Colors.grey,
                    ),
                      label: context.l10n.add,
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 2 ? IconlyBold.profile : IconlyLight.profile,
                      color: controller.currentIndex == 2 ? Colours.primaryColor : Colors.grey,
                    ),
                    label:  context.l10n.profile,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            );
          });
        });
  }
}
