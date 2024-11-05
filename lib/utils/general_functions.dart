import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wellcheck/utils/extensions.dart';
import 'package:wellcheck/utils/spacings.dart';
import 'package:wellcheck/utils/styles.dart';

Future<bool?> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String body,
}) async {
  return await showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      iconColor: Colors.black,
      icon: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: InkWell(
          onTap: () => Navigator.of(context).maybePop(null),
          child: const Icon(
            CupertinoIcons.clear,
            size: 18,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 8,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style:
                context.textTheme().titleLarge!.copyWith(color: Styles.mainRed),
          ),
          Spacings.verticalElementsSpacing(factor: 1),
          Text(
            body,
            style: context.textTheme().titleMedium,
          ),
          Spacings.verticalElementsSpacing(factor: 1),
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Cancel',
                    style: context.textTheme().titleMedium,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.of(context).pop(true),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Confirm',
                    style: context
                        .textTheme()
                        .titleMedium!
                        .copyWith(color: Styles.mainRed),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
