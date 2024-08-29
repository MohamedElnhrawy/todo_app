import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/app/providers/user_provider.dart';
import 'package:todo_app/core/res/media_res.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      final user = provider.user;
      return Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 50,
            backgroundImage: AssetImage(MediaRes.userDefault) as ImageProvider,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            user?.fullName ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),

        ],
      );
    });
  }
}
