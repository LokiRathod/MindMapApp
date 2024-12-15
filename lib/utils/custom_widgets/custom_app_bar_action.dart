import 'package:flutter/material.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  @override
  final Size preferredSize;
  final GestureTapCallback onBackPressed;
  final GestureTapCallback onPressed;
  final String title;
  final Color color;

  const CustomAppBar({
    super.key,
    required this.onBackPressed,
    required this.onPressed,
    required this.title,
    required this.color,
  })  : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: color,
      title: Center(child: Text(title, style: TextStylesConstants.textStyleBoldWhite_24, textAlign: TextAlign.center,)),
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios, size: 22.0, color: MindMapColors.colorWhite,), onPressed: onBackPressed,),
      actions: [
        Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: MindMapColors.colorWhite, // Card color
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(icon: const Icon(Icons.logout, size: 24.0, color: MindMapColors.colorRed,), onPressed: onPressed,)),
        const SizedBox(width: 15),
      ],
    );
  }
}


class CustomAppBarWithAction extends StatelessWidget implements PreferredSizeWidget{

  @override
  final Size preferredSize;
  final GestureTapCallback onBackPressed;
  final GestureTapCallback onPressed;
  final String title;
  final Color color;

  const CustomAppBarWithAction({
    super.key,
    required this.onBackPressed,
    required this.onPressed,
    required this.title,
    required this.color,
  })  : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: color,
      title: Center(child: Text(title, style: TextStylesConstants.textStyleBoldWhite_24, textAlign: TextAlign.center,)),
      // leading: IconButton(icon: const Icon(Icons.arrow_back_ios, size: 22.0, color: MindMapColors.colorBlack100,), onPressed: widget.onBackPressed,),
      actions: [
        Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: MindMapColors.colorWhite, // Card color
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(icon: const Icon(Icons.logout, size: 24.0, color: MindMapColors.colorRed,), onPressed: onPressed,)),
        const SizedBox(width: 15),
      ],
    );
  }
}
