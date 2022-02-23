# tf_async_progress_buttons



## Supported Dart Versions

**Dart SDK version ">=2.15.1 <3.0.0"**

**Flutter SDK version ">=1.17.0"**

## Installation

Add the Package

```yaml
dependencies:
  tf_async_progress_dialog: ^1.0.0
```

## How to use

Import the package in your dart file

```dart
import 'package:tf_async_progress_dialog/tf_async_progress_dialog.dart';
```

### **Using TfAsyncProgressDialog**

```dart
// Asynchronous Task to show progress dialog for
Future<bool> demoProcess() async {
    final task = Future.delayed(const Duration(seconds: 3));
    await task;
    // for exception handling demo
    final shouldThrowError = Random().nextInt(3) == 0;
    if (shouldThrowError) {
    throw "demo error";
    }
    return true;
}

// Show progress dialog using showAsyncProgressDialog function
await showAsyncProgressDialog(
    context: context,
    dialog: TfAsyncProgressDialog<bool>(
        demoProcess,
        message: const Text('In progress...'),
        progress: AspectRatio(
        aspectRatio: 1.0,
        child: Image.asset(
                'assets/gif/loading.gif',
            ),
        ),
        decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        ),
    ),
);

// To handle the exception that might get thrown in the async task, wrap around try...catch block
try {
    final result = await showAsyncProgressDialog(
    context: context,
    dialog: TfAsyncProgressDialog<bool>(
        demoProcess,
        message: const Text('In progress...'),
        progress: AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(
                'assets/gif/loading.gif',
            ),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
        ),
    ),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Success: $result')));
} catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Failed: $e')));
}
```