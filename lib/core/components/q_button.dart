import 'package:clean_architecture_flutter/core/utils/common.dart';
import 'package:flutter/material.dart';

enum QButtonType { elevated, filled, tonal, outlined, text, icon }

enum QButtonState { enabled, disabled, loading }

class QButton extends StatelessWidget {
  const QButton({
    super.key,
    this.onPress,
    required this.text,
    this.state = QButtonState.enabled,
    this.type = QButtonType.filled,
  });

  final String text;
  final QButtonType? type;
  final QButtonState state;
  final Function()? onPress;

  WidgetStateProperty<OutlinedBorder> _shape() {
    return WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  dynamic _buttonState() {
    return state == QButtonState.disabled
        ? WidgetStateProperty.all(Colors.grey)
        : null;
  }

  Widget _elevated() {
    return ElevatedButton(
        onPressed: state == QButtonState.disabled ? null : _onPress,
        style: ButtonStyle(
          shape: _shape(),
          backgroundColor: _buttonState(),
        ),
        child: _buttonContent());
  }

  Widget _text() {
    return TextButton(
      onPressed: state == QButtonState.disabled ? null : _onPress,
      child: _buttonContent(),
    );
  }

  Widget _outlined() {
    return OutlinedButton(
      onPressed: state == QButtonState.disabled ? null : _onPress,
      style: ButtonStyle(shape: _shape()),
      child: _buttonContent(),
    );
  }

  Widget _filled() {
    return FilledButton(
      onPressed: state == QButtonState.disabled ? null : _onPress,
      style: ButtonStyle(shape: _shape()),
      child: _buttonContent(),
    );
  }

  Widget _tonal() {
    return FilledButton.tonal(
        onPressed: state == QButtonState.disabled ? null : _onPress,
        style: ButtonStyle(
          shape: _shape(),
        ),
        child: _buttonContent());
  }

  Widget _buttonContent() {
    return state == QButtonState.loading
        ? CircularProgressIndicator(value: 2)
        : Text(text, style: TextStyle(fontSize: 13));
  }

  @override
  Widget build(BuildContext context) {
    if (type == QButtonType.text) {
      return _text();
    } else if (type == QButtonType.outlined) {
      return _outlined();
    } else if (type == QButtonType.elevated) {
      return _elevated();
    } else if (type == QButtonType.tonal) {
      return _tonal();
    } else {
      return _filled();
    }
  }

  dynamic _onPress() async {
    if (onPress != null && state != QButtonState.disabled) {
      QCommon.hideKeyboard();
      onPress!();
    } else {
      return null;
    }
  }
}
