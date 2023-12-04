import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_text_form_filed.dart';
import 'package:chat_app/widgets/custtom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Image.asset(
                  klogo,
                  width: 120,
                  height: 120,
                  // fit: BoxFit.cover,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "Scholar Chat",
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'pacifico',
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 27, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextFiled(
                    onchange: (data) {
                      email = data;
                    },
                    label: 'Email'),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextFiled(
                    obsure: true,
                    onchange: (data) {
                      password = data;
                    },
                    label: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await LoginUser(context);
                        Navigator.of(context)
                            .pushNamed(ChatPage.id, arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(
                              context, 'User Not Found , Sign Up First');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (ex) {
                        showSnackBar(context, ex.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    } else {
                      return showSnackBar(context, 'Validation Is Not True');
                    }
                  },
                  text: 'Log In',
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account ? ",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser(BuildContext context) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    showSnackBar(context, 'Succesed Log In ');
  }
}
