import 'package:flutter/material.dart';

class ModalBottomSheetWrapper extends StatelessWidget {
  const ModalBottomSheetWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      color: Colors.white,
      // padding: const EdgeInsets.all(15.0),
      padding: EdgeInsets.only(
        // bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        // TODO this causes overdflow when keyboard is shown - come back to it
        bottom: MediaQuery.of(context).viewInsets.bottom,
        // bottom: 15,
        top: 15,
        left: 15,
        right: 15,
      ),
      child: child,
    );
  }
}
