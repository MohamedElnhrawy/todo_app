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
          const SizedBox(
            height: 30,
            child: Divider(
              color: Colors.grey,
              height: 1,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,

            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colours.neutralTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: IconButton(
                  icon: actionWidget,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: onTap,
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}