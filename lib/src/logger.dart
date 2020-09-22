import 'log_level.dart';
import 'log_message.dart';
import 'printer/common_printer.dart';
import 'printer/log_printer.dart';

class L {
  static const _kTag = "Logger";

  static LogPrinter _printer;

  static LogPrinter get printer {
    if (_printer == null) {
      _printer = CommonPrinter();
    }
    return _printer;
  }

  static set printer(LogPrinter printer) => _printer = printer;

  static set enableLog(bool enable) => printer.enableLog = enable;

  static set minLevel(LogLevel level) => printer.minLevel = level;

  static void _log(LogMessage message) {
    printer.write(message);
  }

  static void d(Object message, {String tag, bool isJson = false}) {
    _log(LogMessage(LogLevel.debug, message.toString(), _getLoggerTag(tag), isJson));
  }

  static void i(Object message, {String tag, bool isJson = false}) {
    _log(LogMessage(LogLevel.info, message.toString(),  _getLoggerTag(tag), isJson));
  }

  static void w(Object message, {String tag, bool isJson = false}) {
    _log(LogMessage(LogLevel.warn, message.toString(),  _getLoggerTag(tag), isJson));
  }

  static void e(Object message, {Object detail, String tag, bool isJson = false}) {
    var d = "${detail == null ? '' : '\n${detail.toString()}'}";
    _log(LogMessage(LogLevel.error, message.toString() + d,  _getLoggerTag(tag), isJson));
  }

  static void f(String message, {String tag, bool isJson = false}) {
    _log(LogMessage(LogLevel.fatal, message,  _getLoggerTag(tag), isJson));
  }

  //如果没有设置tag，则获取当前执行文件的文件名
  static String _getLoggerTag(String tag) {
    if (tag == null) {
      var traceString = StackTrace.current.toString();
      var curMatch = RegExp(r'[A-Za-z_]+.dart').firstMatch(traceString);
      var allMatch = RegExp(r'[A-Za-z_]+.dart').allMatches(traceString);
      if (curMatch != null && allMatch != null) {
        var stacks = allMatch.where((element) =>
        element.group(0) != curMatch.group(0)).toList();
        if (stacks != null) {
          return stacks[0].group(0);
        }else {
          return _kTag;
        }
      }
      return _kTag;
    }else {
      return tag;
    }
  }
}
