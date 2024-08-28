import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:todo_app/core/common/widgets/custom_field.dart';
import 'package:todo_app/core/extensions/context_extension.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {super.key,
      required this.emailController,
      required this.fullNameController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.formKey});

  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignUpForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomField(
              required: true,
              controller: widget.fullNameController,
              hintText: context.l10n.full_name,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomField(
              required: true,
              controller: widget.emailController,
              hintText: context.l10n.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomField(
              required: true,
              controller: widget.passwordController,
              hintText: context.l10n.password,
              keyboardType: TextInputType.visiblePassword,
              obSecureText: obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  obscurePassword ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomField(
              required: true,
              controller: widget.confirmPasswordController,
              hintText: context.l10n.confirm_password,
              keyboardType: TextInputType.visiblePassword,
              obSecureText: obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  obscurePassword ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                ),
              ),
              overrideValidator: true,
              validator: (value) {
                if (value?.trim() != widget.passwordController.text.trim()) {
                  return context.l10n.password_not_match;
                }
                return null;
              },
            ),
          ],
        ));
  }
}
