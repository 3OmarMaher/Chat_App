import 'package:flutter/material.dart';

class CustomFormTextFiled extends StatelessWidget {
  CustomFormTextFiled({super.key,this.obsure=false , this.onchange, required this.label});
  final String label;
   bool? obsure;
 Function (String)? onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Invalid Value ';
        }
      },
      obscureText: obsure!,
      onChanged: onchange,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
