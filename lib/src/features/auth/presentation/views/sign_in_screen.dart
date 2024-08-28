import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/common/app/providers/user_provider.dart';
import 'package:todo_app/core/common/views/loader.dart';
import 'package:todo_app/core/common/widgets/gradient_background.dart';
import 'package:todo_app/core/common/widgets/rounded_button.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/fonts.dart';
import 'package:todo_app/core/res/media_res.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todo_app/src/features/auth/presentation/widgets/sign_in_form.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CoreUtils.showSnakeBar(context, state.message);
          }if (state is CachingError) {
            CoreUtils.showSnakeBar(context, state.message);
          }else if(state is UserLoggedInCached || (state is UserLoggedInStatus && state.status)){
            //TODO(PUSH HOME SCREEN)
            Navigator.pushReplacementNamed(context, "Dashboard.routeName");
          }

          else if (state is SignedInSuccess) {
            context.read<UserProvider>().initUser(state.user);
            context.read<AuthBloc>().add(const CacheUserLoggedInEvent(true));
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.onBoardingBackground,
            child: SafeArea(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                     Text(
                      context.l10n.sign_in,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: Fonts.aeonik,
                          fontSize: 32),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            context.l10n.sign_in_header,
                            style:const TextStyle(fontSize: 14),
                          ),
                          Baseline(
                            baseline: 100,
                            baselineType: TextBaseline.alphabetic,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignUpScreen.routeName);
                              },
                              child:  Text(
                                context.l10n.register_account,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: formKey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    state is AuthLoading
                        ? const Center(child: Loader())
                        : RoundedButton(
                            label: context.l10n.sign_in,
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              FirebaseAuth.instance.currentUser?.reload();
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(SignInEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim()));
                              }
                            },
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
