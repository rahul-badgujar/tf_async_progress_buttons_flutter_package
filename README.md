# tf_async_progress_buttons

Provides buttons to perform asynchronous tasks with support for all Flutter Framework Buttons. Styles and child widgets for different phases of async tasks viz., Beginning, Progressing, Completion can be configured. Also fascilate undo action to be specified. Supports results and errors handling.

## Supported Dart Versions

**Dart SDK version ">=2.15.1 <3.0.0"**

**Flutter SDK version ">=1.17.0"**

## Installation

Add the Package

```yaml
dependencies:
  tf_async_progress_buttons: ^1.0.0
```

## How to use

Import the package in your dart file

```dart
import 'package:tf_async_progress_buttons/tf_async_progress_button.dart';
```

### **To add Elevated Button for Async Task with Undo Async Task**

```dart
TfAsyncProgressElevatedButton(
    action: () async {
        // specify your async task here as action.
        // this callback will be executed when button will be clicked.

        // async code here to connnect to the server

        // return result if any
    }, 
    undoAction: () async {
        // specify reverse async task of action here.
        // this callback will be executed when button will be clicked for undo-ing the action. 

        // async code here to disconnect from the server

        // return result if any
    }, 
    size: const Size(120, 40),
    // specify different widget to show for different phases of an async task
    actionInitButtonChild: const Text('Connect'),
    actionInProgressButtonChild: const Text('Connecting...'),
    actionCompleteButtonChild: const Text('Disconnect'),
    // specify different button styles button should have for different phases of an async task
    actionInitButtonStyle: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.green),
    ),
    actionInProgressButtonStyle: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.amber),
    ),
    actionDoneButtonStyle: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.red),
    ),
    // handlers to handle results and errors
    onActionResulted: (result, isError) {
        if (isError) {
            print('Error in action: $result');
        } else {
            print('Result in action: $result');
        }
    },
    onUndoActionResulted: (result, isError) {
        if (isError) {
            print('Error in undo action: $result');
        } else {
            print('Result in undo action: $result');
        }
    },
),
```

![](https://github.com/rahul-badgujar/tf_async_progress_buttons_flutter_package/raw/main/assets/gif/elevated-button-demo.gif)

Note: Please ignore the watermark in above GIF. It is the watermark of the software used for taking screencast.

### **To add Text Button for Async Task with Undo Async Task**

```dart
TfAsyncProgressTextButton(
    // specify button parameters here similar to TfAsyncProgressElevatedButton
)
```

![](https://github.com/rahul-badgujar/tf_async_progress_buttons_flutter_package/raw/main/assets/gif/text-button-demo.gif)

### **To add Outlined Button for Async Task with Undo Async Task**

```dart
TfAsyncProgressOutlinedButton(
    // specify button parameters here similar to TfAsyncProgressElevatedButton
)
```

![](https://github.com/rahul-badgujar/tf_async_progress_buttons_flutter_package/raw/main/assets/gif/outlined-button-demo.gif)
