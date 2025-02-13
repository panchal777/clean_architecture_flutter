import 'package:logger/logger.dart';
import 'dart:developer' as developer;

abstract class LogService {
  void e(String message, dynamic e, StackTrace? stack);

  void i(String message);

  void w(String message);
}

class LogServiceImpl implements LogService {
  LogServiceImpl({Logger? logger}) {
    _logger = logger ??
        Logger(
          printer: PrefixPrinter(
            PrettyPrinter(
              methodCount: 0,
              errorMethodCount: 500,
              lineLength: 100,
            ),
          ),
          output: _MyConsoleOutput(),
        );
  }

  late final Logger _logger;

  @override
  void e(String message, dynamic e, StackTrace? stack) {
    _logger.e(message, error: e, stackTrace: stack);
  }

  @override
  void i(String message) {
    _logger.i(message);
  }

  @override
  void w(String message) {
    _logger.w(message);
  }
}

class _MyConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(developer.log);
  }
}
