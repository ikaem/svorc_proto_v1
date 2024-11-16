import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  const DialogWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Dialog(
      // child: Text("No daily budget found"),
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          // TODO not sure if it is needed
          // TODO leave for now
          // bottom: MediaQuery.of(context).viewInsets.bottom,
          bottom: 15,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: child,
      ),
    );
  }
}
