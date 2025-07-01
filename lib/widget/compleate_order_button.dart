import 'package:flutter/material.dart';
import 'package:mekto/utility/app_color.dart';

class CompleteOrderButton extends StatelessWidget {
  final String? labelText;
  final Function()? onPressed;

  const CompleteOrderButton({
    super.key,
    this.onPressed,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          foregroundColor: Colors.white,
          backgroundColor: AppColor.halloween,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onPressed: onPressed,
        child: Text(
          labelText ?? 'Complete Order',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
