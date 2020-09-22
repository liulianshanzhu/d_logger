import '../log_level.dart';
import '../log_message.dart';
import 'log_printer.dart';

class CommonPrinter extends LogPrinter {
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const verticalLine = '│';
  static const divider = '─';

  int printMaxLength = 800; //print的打印有字数限制，过长则不显示超出部分，因此再次限制输出长度
  int lineLength = 120;
  String _topBorder = '';
  String _bottomBorder = '';

  CommonPrinter({bool enableLog, LogLevel level, String tag})
      : super(enableLog, level, tag) {
    //初始化分割线
    var dividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      dividerLine.write(divider);
    }
    _topBorder = '$topLeftCorner$dividerLine';
    _bottomBorder = '$bottomLeftCorner$dividerLine';
  }

  // 预先整合日志信息至StringBuffer，当StringBuffer存储的长度超过规定的输出值，
  // 则输出当前缓存日志。输出清空后继续遍历直至输出所有
  @override
  Future<void> write(LogMessage message) async {
    if (shouldShowLog(message)) {
      var info = StringBuffer();
      var startInfo = "${message.level.name} ${message.tag}";
      info.write("$startInfo $_topBorder\n");
      var lines = message.toString().split("\n");
      for (var line in lines) {
        var midStr = "$startInfo $verticalLine $line\n";
        if (info.length + midStr.length >= printMaxLength) {
          print(midStr);
        } else {
          print(info);
          info.clear();
          info.write(midStr);
        }
      }
      print(info);
      print("$startInfo $_bottomBorder");
    }
  }
}
