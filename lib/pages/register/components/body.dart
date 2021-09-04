import 'package:flutter/material.dart';
import 'package:photo_tips/pages/register/components/register_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [RegisterForm()],
        ),
      ),
    );
  }
}