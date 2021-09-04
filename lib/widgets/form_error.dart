import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => buildFormError(error: errors[index])),
    );
  }

  Row buildFormError({String error}) {
    return Row(
      children: [
        // SvgPicture.asset(
        //   "assets/icons/error.svg",
        //   height: 14,
        //   width: 14,
        // ),
        // SizedBox(width: 10),
        Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}