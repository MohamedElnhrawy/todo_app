import 'package:flutter/material.dart';
import 'package:todo_app/core/res/colours.dart';

class ProfileSectionTile extends StatelessWidget {
  const ProfileSectionTile({super.key, required this.title, required this.actionWidget, required this.onTap, });

  final String title;
  final Widget actionWidget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
           SizedBox(
            height: 30,
            child: Divider(
              color: Colors.grey.withOpacity(.5),
              height: 1,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.neutralTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              IconButton(
                    icon: actionWidget,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: onTap,
                  ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}