import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/gen/colors.gen.dart';

class SnackBBar extends SnackBar {
  SnackBBar({
    Key? key,
    required BuildContext context,
    Widget? icon,
    required String message,
    String? actionLabel = 'Đóng',
    void Function()? onActionTap,
    Duration duration = const Duration(seconds: 4),
  }) : super(
          key: key,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          behavior: SnackBarBehavior.floating,
          duration: duration,
          dismissDirection: DismissDirection.horizontal,
          content: Row(
            children: [
              icon ?? const SizedBox.shrink(),
              if (icon != null) const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: ColorName.primary,
                  onPressed: onActionTap ?? () {},
                )
              : null,
        );
}

Future<void> showErrorSnackBBar({
  required BuildContext context,
  required String? message,
  String? actionLabel,
  void Function()? onActionTap,
  Duration duration = const Duration(seconds: 30),
}) async {
  final snackBar = SnackBBar(
    context: context,
    duration: duration,
    icon: const Icon(
      CupertinoIcons.exclamationmark_circle,
      color: ColorName.error,
      size: 24.0,
    ),
    message: message ?? "There was an error, try again",
    actionLabel: actionLabel,
    onActionTap: onActionTap,
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
