import 'package:flutter/material.dart';

import 'login_form_body.dart';

/// Bottom-sheet sign-in — the primary entry point (Home avatar, Profile tab,
/// and any Bearer-gated screen's CTA). Rounded top corners + dark scrim come
/// from the app's `bottomSheetTheme`.
class LoginSheet {
  LoginSheet._();

  /// Returns `true` if the user signed in, `false` if they dismissed or
  /// chose "continue as guest".
  static Future<bool> show(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            4,
            20,
            20 + MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: LoginFormBody(
            onResolved: ({required signedIn}) =>
                Navigator.of(sheetContext).pop(signedIn),
          ),
        );
      },
    );
    return result ?? false;
  }
}
