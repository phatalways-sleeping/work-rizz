import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_create_bloc/subtask_create_bloc.dart';

class DescriptionInput extends StatefulWidget {
  const DescriptionInput({
    super.key,
    required this.label,
    required this.showLabel,
  });
  final String label;
  final bool showLabel;

  @override
  State<DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<DescriptionInput> {
  late final TextEditingController _titleController;
  late final FocusNode _focusNode = FocusNode()..addListener(() {});

  @override
  void initState() {
    _titleController = TextEditingController();
    _titleController.addListener(() {
      if (_titleController.text.isNotEmpty) {
        if (widget.label == 'Description') {
          context.read<SubtaskCreateBloc>().add(
                SubTaskInputDescriptionEvent(
                  _titleController.text,
                ),
              );
        } else if (widget.label == 'Title') {
          context.read<SubtaskCreateBloc>().add(
                SubTaskInputNameEvent(
                  _titleController.text,
                ),
              );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      focusNode: _focusNode,
      controller: _titleController,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.start,
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: widget.showLabel ? widget.label : null,
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: context.textTheme.titleMedium,
        contentPadding: EdgeInsets.symmetric(
          vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.4,
          horizontal: context.mediaQuery.size.width * RATIO_PADDING * 1.2,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(MEDIUM_CORNER)),
          borderSide: BorderSide(
            color: BLACK,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(MEDIUM_CORNER)),
          borderSide: BorderSide(
            color: BLACK,
            width: 1.0,
          ),
        ),
        focusColor: context.colorScheme.onSecondary,
      ),
    );
  }
}
