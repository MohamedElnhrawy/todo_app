
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/common/app/providers/user_provider.dart';
import 'package:todo_app/core/common/views/loader.dart';
import 'package:todo_app/core/common/widgets/gradient_background.dart';
import 'package:todo_app/core/common/widgets/rounded_button.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/fonts.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todo_app/src/features/auth/presentation/views/sign_in_screen.dart';
import 'package:todo_app/src/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:todo_app/src/features/dashboard/presentation/views/dashboard.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = 'sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CoreUtils.showSnakeBar(context, state.message);
          } else if (state is SignedUpSuccess) {
            context.read<AuthBloc>().add(SignInEvent(email: _emailController.text.trim(), password: _passwordController.text.trim()));
          }else if(state is SignedInSuccess){
            context.read<UserProvider>().initUser(state.user);
            context.read<AuthBloc>().add(const CacheUserLoggedInEvent(true));
          }else if (state is CachingError) {
            CoreUtils.showSnakeBar(context, state.message);
          }else if(state is UserLoggedInCached || (state is UserLoggedInStatus && state.status)){
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackground(
            child: SafeArea(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                     Text(
                      context.l10n.sign_up,
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
                            context.l10n.sign_up_header,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Baseline(
                            baseline: 100,
                            baselineType: TextBaseline.alphabetic,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignInScreen.routeName);
                              },
                              child:  Text(
                                context.l10n.already_have_account,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignUpForm(
                      fullNameController: _fullNameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      formKey: formKey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    state is AuthLoading
                        ? const Center(child: Loader())
                        : RoundedButton(
                      label: context.l10n.sign_up,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        FirebaseAuth.instance.currentUser?.reload(); //case:  logout and try to signup
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SignUpEvent(
                            fullName: _fullNameController.text.trim(),
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
    _passwordController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
