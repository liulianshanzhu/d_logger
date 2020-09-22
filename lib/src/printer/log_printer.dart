import '../log_level.dart';
import '../log_message.dart';

abstract class LogPrinter {
  bool _enableLog; //是否开启输出日志
  LogLevel _minLevel; //控制输入的日志等级

  static const bool _isProduct =
      bool.fromEnvironment('dart.vm.product', defaultValue: false);  //是否是正式环境

  LogPrinter([bool enableLog, LogLevel level, String tag])
      : _enableLog = enableLog ?? true,
        _minLevel = level ?? LogLevel.debug;

  Future<void> write(LogMessage message);

  bool shouldShowLog(LogMessage message) {
    //如果是正式环境或者手动关闭日志显示，则返回false不输出日志
    if (_isProduct || !_enableLog) {
      return false;
    }
    //日志级别小于设置的最小输入日志级别，返回false
    if (message.level < _minLevel) {
      return false;
    }
    return true;
  }

  set enableLog(bool enable) {
    _enableLog = enable;
  }

  set minLevel(LogLevel level) {
    _minLevel = level;
  }
}

