import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TfAsyncProgressButtonStates {
  yetToInit,
  inProgress,
  completed,
}

abstract class TfAsyncProgressBaseButton extends StatelessWidget {
  TfAsyncProgressBaseButton({
    Key? key,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.actionInitButtonStyle,
    this.actionInProgressButtonStyle,
    this.actionDoneButtonStyle,
    this.actionInitButtonChild = const Text('Init'),
    this.actionInProgressButtonChild = const Text('Please wait'),
    this.actionDoneButtonChild = const Text('Undo'),
    this.size = const Size(50, 100),
    required this.action,
    required this.undoAction,
    this.onActionErrored,
    this.onUndoActionErrored,
  }) : super(key: key);

  // properties related to basic flutter buttons implementation
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  // different style to apply on button for different stages of action
  final ButtonStyle? actionInitButtonStyle;
  final ButtonStyle? actionInProgressButtonStyle;
  final ButtonStyle? actionDoneButtonStyle;

  // child widgets to show with button for different stages of action
  final Widget actionInitButtonChild;
  final Widget actionInProgressButtonChild;
  final Widget actionDoneButtonChild;

  // size of button
  final Size? size;

  // async callbacks to do and undo action
  final AsyncValueGetter action;
  final AsyncValueGetter undoAction;

  // on error handlers
  final Function(dynamic)? onActionErrored;
  final Function(dynamic)? onUndoActionErrored;

  // value notifiers
  final ValueNotifier<TfAsyncProgressButtonStates> buttonStateNotifier =
      ValueNotifier(TfAsyncProgressButtonStates.yetToInit);

  Future Function()? get onButtonPressedCallback {
    if (buttonState == TfAsyncProgressButtonStates.yetToInit) {
      return onActionInit;
    } else if (buttonState == TfAsyncProgressButtonStates.completed) {
      return onUndoActionInit;
    }
    return null;
  }

  Future<dynamic> onActionInit() async {
    assert(buttonState == TfAsyncProgressButtonStates.yetToInit);
    try {
      // put the button in progress state
      buttonState = TfAsyncProgressButtonStates.inProgress;
      final result = await action.call();
      // put the button in progress state
      buttonState = TfAsyncProgressButtonStates.completed;
      return result;
    } catch (e) {
      buttonState = TfAsyncProgressButtonStates.yetToInit;
      onActionErrored?.call(e);
    }
  }

  Future<dynamic> onUndoActionInit() async {
    assert(buttonState == TfAsyncProgressButtonStates.completed);
    try {
      // put the button in progress state
      buttonState = TfAsyncProgressButtonStates.inProgress;
      final result = await action.call();
      // put the button in progress state
      buttonState = TfAsyncProgressButtonStates.yetToInit;
      return result;
    } catch (e) {
      buttonState = TfAsyncProgressButtonStates.completed;
      onUndoActionErrored?.call(e);
    }
  }

  set buttonState(TfAsyncProgressButtonStates updatedState) {
    buttonStateNotifier.value = updatedState;
  }

  TfAsyncProgressButtonStates get buttonState {
    return buttonStateNotifier.value;
  }

  Widget get childWidget {
    switch (buttonStateNotifier.value) {
      case TfAsyncProgressButtonStates.yetToInit:
        return actionInitButtonChild;
      case TfAsyncProgressButtonStates.inProgress:
        return actionInProgressButtonChild;
      case TfAsyncProgressButtonStates.completed:
        return actionDoneButtonChild;
    }
  }

  ButtonStyle? get buttonStyle {
    ButtonStyle? styleToShow;
    switch (buttonStateNotifier.value) {
      case TfAsyncProgressButtonStates.yetToInit:
        styleToShow = actionInitButtonStyle;
        break;
      case TfAsyncProgressButtonStates.inProgress:
        styleToShow = actionInProgressButtonStyle;
        break;
      case TfAsyncProgressButtonStates.completed:
        styleToShow = actionDoneButtonStyle;
        break;
    }
    // return the style appending size constraints
    return styleToShow?.copyWith(
      fixedSize: ButtonStyleButton.allOrNull<Size>(size),
    );
  }
}
