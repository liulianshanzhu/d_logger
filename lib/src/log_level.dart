

class LogLevel implements Comparable<LogLevel> {

  static const debug = LogLevel(1, '[DEBUG]');
  static const info = LogLevel(2, '[INFO]');
  static const warn = LogLevel(3, '[WARN]');
  static const error = LogLevel(4, '[ERROR]');
  static const fatal = LogLevel(5, '[FATAL]');

  final int value;
  final String name;

  const LogLevel(this.value, this.name);

  bool operator <(LogLevel other) => value < other.value;

  @override
  int compareTo(LogLevel other) => value - other.value;

}