// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TfAsyncProgressButtonStatus {
  NoInit,
  InProgress,
  Completed,
  Errored,
}

class TfAsyncProgressButton<T> extends StatelessWidget {
  final actionStatusNotifier = ValueNotifier<TfAsyncProgressButtonStatus>(
      TfAsyncProgressButtonStatus.NoInit);
  TfAsyncProgressButton({
    Key? key,
    this.buttonStyleInitial,
    this.buttonStyleOnActionComplete,
    required this.height,
    required this.width,
    required this.actionInitWidget,
    this.actionInProgressWidget,
    required this.actionCompletedWidget,
    required this.actionCallback,
    required this.actionReversedCallback,
  }) : super(key: key);

  final ButtonStyle? buttonStyleInitial;
  final ButtonStyle? buttonStyleOnActionComplete;
  final Widget actionInitWidget;
  final Widget? actionInProgressWidget;
  final Widget actionCompletedWidget;
  final double height;
  final double width;

  final AsyncCallback actionCallback;
  final AsyncCallback actionReversedCallback;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: actionStatusNotifier,
      builder: (context, status, _) {
        // decide which widget to show
        Widget widgetToShow;
        switch (status) {
          case TfAsyncProgressButtonStatus.NoInit:
            widgetToShow = actionInitWidget;
            break;
          case TfAsyncProgressButtonStatus.InProgress:
            widgetToShow =
                actionInProgressWidget ?? _defaultActionInProgressWidget;
            break;
          case TfAsyncProgressButtonStatus.Completed:
            widgetToShow = actionCompletedWidget;
            break;
          default:
            widgetToShow = actionInitWidget;
            break;
        }

        // decide which callback to register
        AsyncCallback? onTapCallback;
        switch (status) {
          case TfAsyncProgressButtonStatus.NoInit:
            onTapCallback = _onActionTriggered;
            break;
          case TfAsyncProgressButtonStatus.Completed:
            onTapCallback = _onActionReversedTriggered;
            break;
        }

        // decide what style to apply to button
        ButtonStyle? buttonStyleToApply;
        switch (status) {
          case TfAsyncProgressButtonStatus.NoInit:
            buttonStyleToApply = buttonStyleInitial;
            break;
          case TfAsyncProgressButtonStatus.Completed:
            buttonStyleToApply =
                buttonStyleOnActionComplete ?? buttonStyleInitial;
            break;
          case TfAsyncProgressButtonStatus.InProgress:
            buttonStyleToApply = buttonStyleInitial?.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            );
            break;
          default:
            buttonStyleToApply = buttonStyleInitial;
            break;
        }

        // return the button
        return ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widgetToShow,
          ),
          style: buttonStyleToApply?.copyWith(
            fixedSize: MaterialStateProperty.all<Size>(
              Size(width, height),
            ),
          ),
          onPressed: onTapCallback,
        );
      },
    );
  }

  Widget get _defaultActionInProgressWidget {
    return const AspectRatio(
      aspectRatio: 1.0,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Future<void> _onActionTriggered() async {
    // put the button to in-progress status
    actionStatusNotifier.value = TfAsyncProgressButtonStatus.InProgress;
    await actionCallback.call();
    // put the button to completed status
    actionStatusNotifier.value = TfAsyncProgressButtonStatus.Completed;
  }

  Future<void> _onActionReversedTriggered() async {
    // put the button to in-progress status
    actionStatusNotifier.value = TfAsyncProgressButtonStatus.InProgress;
    await actionReversedCallback.call();
    // put the button to no-init status again
    actionStatusNotifier.value = TfAsyncProgressButtonStatus.NoInit;
  }
}
