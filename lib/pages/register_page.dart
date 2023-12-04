import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_text_form_filed.dart';
import 'package:chat_app/widgets/custtom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  'Sign Up',
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
                          await registerUser(context);
                          Navigator.of(context).pushNamed(ChatPage.id, arguments: email);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            showSnackBar(context, 'Password Is Weak');
                          } else if (ex.code == 'email-already-in-use') {
                            showSnackBar(context, 'Email is Already Exists');
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
                    text: 'Register'),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "already have an account ? ",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Log In",
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

  Future<void> registerUser(BuildContext context) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    showSnackBar(context, 'Succesed Sign Up');
  }
}
