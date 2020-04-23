import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BeautifulButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final MaterialRaisedButtonData materialRaisedButtonData;
  final CupertinoButtonData cupertinoButtonData;

  BeautifulButton({this.child, this.onPressed, this.materialRaisedButtonData, this.cupertinoButtonData, this.padding});

  @override
  Widget build(BuildContext context) {
    return PlatformButton(
      child: child,
      onPressed: onPressed,
      padding: padding,
      android: (_) => materialRaisedButtonData,
      ios: (_) => cupertinoButtonData,
    );
  }
}
