import 'package:atlas_coins/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  
  final String label;
  final void Function()? onSaved;
  
  const ButtonWidget({ 
    Key? key,
    this.onSaved,
    required this.label 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 20),     
      height: 50,
      child: ElevatedButton(
        onPressed: onSaved,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ), 
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}