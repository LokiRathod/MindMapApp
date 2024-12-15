import 'package:flutter/material.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';


class CustomButton extends StatelessWidget {

  final GestureTapCallback onPressed;
  final String label;
  final Color colorName;
  final double widthSize;

  const CustomButton({super.key,required this.onPressed,required this.label, required this.colorName, required this.widthSize });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: RawMaterialButton(
        elevation: 0.0,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),
        child: Container(
          width: widthSize, height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: colorName, shape: BoxShape.rectangle,
          ),
          child: Center(child: Text(label, style: TextStylesConstants.textStyleBoldWhite_13),),
        ),
      ),
    );

  }
}

class CustomDisableButton extends StatelessWidget {

  final GestureTapCallback onPressed;
  final String label;
  final Color colorName;
  final double widthSize;


  const CustomDisableButton({super.key,required this.onPressed,required this.label, required this.colorName , required this.widthSize });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: RawMaterialButton(
        elevation: 0.0,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),
        child: Container(
          width: widthSize, height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: colorName, shape: BoxShape.rectangle,
          ),
          child: Center(child: Text(label, style: TextStylesConstants.textStyleBoldWhite_13),),
        ),
      ),
    );

  }
}

