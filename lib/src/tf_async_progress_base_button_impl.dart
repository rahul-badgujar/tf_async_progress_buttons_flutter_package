import 'package:flutter/material.dart';

enum TfActionStatus {
  yetToInit,
  inProgress,
  completed,
  errored,
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
  final Future Function() action;
  final Future Function() undoAction;

  // value notifiers
  final ValueNotifier<TfActionStatus?> actionStateNotifier =
      ValueNotifier(null);
  final ValueNotifier<TfActionStatus?> undoActionStateNotifier =
      ValueNotifier(null);

  Future Function()? get onButtonPressedCallback {
    if (actionStateNotifier.value == TfActionStatus.yetToInit) {
      return action;
    }
    return null;
  }

  Widget get childWidget {
    return const SizedBox();
  }

  ButtonStyle? get buttonStyle {
    ButtonStyle? styleToShow;
    // return the style appending size constraints
    return styleToShow?.copyWith(
      fixedSize: ButtonStyleButton.allOrNull<Size>(size),
    );
  }
}
