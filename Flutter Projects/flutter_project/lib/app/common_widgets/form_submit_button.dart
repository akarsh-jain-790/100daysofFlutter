
import 'package:flutter/material.dart';
import 'package:flutter_project/app/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton{
  FormSubmitButton({
    required String text,
    required VoidCallback onPressedCall,
  }): super(
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    // color: Colors.indigo,
    borderRadius: 4.0,
    onPressed: onPressedCall,
    height: 44.0,
  );
}
