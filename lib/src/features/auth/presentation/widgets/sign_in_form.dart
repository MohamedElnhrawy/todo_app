import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:todo_app/core/common/widgets/custom_field.dart';
import 'package:todo_app/core/extensions/context_extension.dart';

class SignInForm extends StatefulWidget {
  const SignInForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomField(
              controller: widget.emailController,
              hintText: context.l10n.email,
              keyboardType: TextInputType.emailAddress,
              required: true,
            ),
            const SizedBox(height: 10,),
            CustomField(
              controller: widget.passwordController,
              hintText: context.l10n.password,
              keyboardType: TextInputType.visiblePassword,
              obSecureText: obscurePassword,
              required: true,
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(obscurePassword ? IconlyLight.show : IconlyLight.hide ,color: Colors.grey,),),
            ),
          ],
        ));
  }
}
