import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/tasklist/tasklist_view.dart';

// ignore: must_be_immutable
class CustomItemWidget extends StatefulWidget {
  CustomItemWidget(
      {super.key,
      required this.isDone,
      this.isFixed = true,
      required this.name,
      required this.subtext,
      required this.firstChild,
      required this.secondChild,
      required this.controller});

  bool isDone;
  final bool isFixed;
  final String name;
  final String subtext;
  final Widget secondChild;
  final Widget firstChild;
  final SubTaskController controller;

  @override
  // ignore: no_logic_in_create_state
  State<CustomItemWidget> createState() => _CustomItemWidgetState(controller);
}

class _CustomItemWidgetState extends State<CustomItemWidget> {
  bool isDone = false;

  void changeColor(bool? value) {
    if (widget.isFixed) {
      return;
    }
    setState(() {
      widget.isDone = value!;
      isDone = widget.isDone;
    });
  }

  _CustomItemWidgetState(SubTaskController controller) {
    controller.changeColor = changeColor;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MEDIUM_CORNER),
            side: const BorderSide(
              color: BLACK,
              width: 1,
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => isDone ? GREEN : WHITE),
        elevation: MaterialStateProperty.resolveWith(
          (states) => states.isPressed ? 4.0 : 0.0,
        ),
        overlayColor: const MaterialStatePropertyAll(
          PALE,
        ),
        splashFactory: InkSparkle.splashFactory,
        animationDuration: const Duration(
          seconds: 2,
        ),
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.firstChild,
              SizedBox(width: MediaQuery.of(context).size.width * RATIO_SPACE),
              Text(
                widget.name,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.secondChild,
              SizedBox(width: MediaQuery.of(context).size.width * RATIO_SPACE),
              Text(
                widget.subtext,
                style: context.textTheme.bodyMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
