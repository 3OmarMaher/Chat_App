import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
    CustomButton({
    super.key, required this.text,this.ontap
  });

  VoidCallback ? ontap;
 final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        width: double.infinity,
        height: 50,
        child:  Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
