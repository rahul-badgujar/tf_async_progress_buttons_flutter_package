import 'package:flutter/material.dart';
import 'package:tf_async_progress_button/src/tf_async_progress_base_button_impl.dart';

class TfAsyncProgressElevatedButton extends TfAsyncProgressBaseButton {
  TfAsyncProgressElevatedButton({
    Key? key,
    FocusNode? focusNode,
    bool autoFocus = false,
    Clip clipBehaviour = Clip.none,
    ButtonStyle? actionInitButtonStyle,
    ButtonStyle? actionInProgressButtonStyle,
    ButtonStyle? actionDoneButtonStyle,
    Widget actionInitButtonChild = const Text('Init'),
    Widget actionInProgressButtonChild = const Text('Init'),
    Widget actionDoneButtonChild = const Text('Init'),
    Size size = const Size(100, 50),
    required Future Function() action,
    required Future Function() undoAction,
  }) : super(
          key: key,
          focusNode: focusNode,
          autofocus: autoFocus,
          clipBehavior: clipBehaviour,
          actionInitButtonStyle: actionInitButtonStyle,
          actionInProgressButtonStyle: actionInProgressButtonStyle,
          actionDoneButtonStyle: actionDoneButtonStyle,
          actionInitButtonChild: actionInitButtonChild,
          actionInProgressButtonChild: actionInProgressButtonChild,
          actionDoneButtonChild: actionDoneButtonChild,
          size: size,
          action: action,
          undoAction: undoAction,
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onButtonPressedCallback,
      child: childWidget,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      style: buttonStyle,
    );
  }
}
