import 'package:flutter/cupertino.dart';

class TapDetector extends StatefulWidget {
  final Widget child;
  final Function()? onTap;

  const TapDetector({super.key, required this.onTap, required this.child});

  @override
  State<TapDetector> createState() => _TapDetectorState();
}

class _TapDetectorState extends State<TapDetector> {
  bool isPreventPressed = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () async {
      if (isPreventPressed) return;
      isPreventPressed = true;

      await widget.onTap?.call();
      isPreventPressed = false;
    },
    child: widget.child,
  );
}
