import 'package:flutter/foundation.dart';
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
    Widget actionCompleteButtonChild = const Text('Init'),
    Size size = const Size(100, 50),
    required AsyncValueGetter action,
    required AsyncValueGetter undoAction,
    Function(dynamic)? onActionErrored,
    Function(dynamic)? onUndoActionErrored,
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
          actionDoneButtonChild: actionCompleteButtonChild,
          size: size,
          action: action,
          undoAction: undoAction,
          onActionErrored: onActionErrored,
          onUndoActionErrored: onUndoActionErrored,
        );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: buttonStateNotifier,
      builder: (context, buttonStateValue, _) {
        return ElevatedButton(
          onPressed: onButtonPressedCallback,
          child: childWidget,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          style: buttonStyle,
        );
      },
    );
  }
}
