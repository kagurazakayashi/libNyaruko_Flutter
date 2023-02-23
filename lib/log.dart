library libnyaruko_flutter;

import 'package:flutter/foundation.dart';

/// 輸出除錯資訊類
class Log {
  /// 每行最多輸出的字元數，超出部分將被換行輸出
  int subStrLength;

  /// 輸出除錯資訊的開關。在預設情況下，取 kDebugMode 的值（根據當前模式自動決定是否輸出）。
  static bool printInfo = kDebugMode;

  static String libraryName = "";
  String className = "";

  /// 建立時指定一個庫名 [libraryName] 類名 [className] ，用於標識輸出的除錯資訊來自哪個類。
  Log({libraryName = "", className = "", this.subStrLength = 800}) {
    this.className = ((libraryName.isNotEmpty && className.isNotEmpty) ? "/" : "") + className;
  }

  /// 輸出除錯資訊 [info]
  /// [notOnlyDebug] 為 true 時，即使非除錯模式也會輸出除錯資訊
  void d(dynamic info, {notOnlyDebug = false}) {
    if (printInfo || notOnlyDebug) {
      echo("D", info);
    }
  }

  /// 輸出資訊 [info]
  /// [notOnlyDebug] 為 true 時，即使非除錯模式也會輸出資訊
  void i(dynamic info, {notOnlyDebug = false}) {
    if (printInfo || notOnlyDebug) {
      echo("I", info);
    }
  }

  /// 輸出警告資訊 [info]
  /// [notOnlyDebug] 為 true 時，即使非除錯模式也會輸出警告資訊
  void w(dynamic info, {notOnlyDebug = false}) {
    if (printInfo || notOnlyDebug) {
      echo("W", info);
    }
  }

  /// 輸出錯誤資訊 [info]
  /// [notOnlyDebug] 為 true 時，即使非除錯模式也會輸出錯誤資訊
  void e(dynamic info, {notOnlyDebug = false}) {
    if (printInfo || notOnlyDebug) {
      echo("E", info);
    }
  }

  /// 輸出錯誤資訊 [info] 並丟擲 [Exception] 異常
  /// [notOnlyDebug] 為 true 時，即使非除錯模式也會輸出錯誤資訊
  /// [notOnlyDebugThrowException] 為 true 時，即使非除錯模式也會丟擲 [Exception] 異常
  void ee(dynamic info, {notOnlyDebug = false, bool notOnlyDebugThrowException = false}) {
    e(info, notOnlyDebug: notOnlyDebug);
    if (kDebugMode || notOnlyDebugThrowException) {
      throw Exception(info);
    }
  }

  /// 輸出帶有左右分隔符的顯著標題資訊，如: ===== [info] =====
  /// [separatorCharMaxNum] 分隔符最大數量（隨著 [info] 的長度而減少）
  /// [separatorChar] 分隔符
  void s(String info, {int separatorCharMaxNum = 20, String separatorChar = "="}) {
    if (printInfo) {
      String outInfo = "";
      int separatorCharNum = separatorCharMaxNum - info.length ~/ 2;
      if (separatorCharNum > 0) {
        outInfo = "${separatorChar.padRight(separatorCharNum, separatorChar)} $info ${separatorChar.padRight(separatorCharNum, separatorChar)}";
      } else {
        outInfo = " $info ";
      }
      printToConsole(outInfo);
    }
  }

  // eWithStackTrace(String error) {
  //   if (kDebugMode) {
  //     print("[E/$libraryName] $error");
  //     print(Chain.current().terse);
  //   }
  // }

  /// 獲取當前時間 [time] 字串（格式：HH:mm:ss）
  String timeString({DateTime? time}) {
    time ??= DateTime.now();
    // ${time.year}-${time.month}-${time.day}
    return "${addZero(time.hour)}:${addZero(time.minute)}:${addZero(time.second)}";
    // .${time.millisecond}
  }

  /// 數字 [num] 不足 2 位前面補 0
  String addZero(int num) {
    return num < 10 ? "0$num" : "$num";
  }

  /// 整合輸出字串。超過 subStrLength 個字元時，分多次輸出。
  void echo(String iconChar, dynamic info) {
    String infoString = info.toString();
    int infoLength = infoString.length;
    String head = "$libraryName$className";
    head = "$iconChar/$head ${timeString()}";
    if (infoLength <= subStrLength) {
      printToConsole("[$head] $infoString");
    } else {
      int index = 0;
      int allPage = infoLength ~/ subStrLength + 1;
      while (index < infoLength) {
        int endIndex = index + subStrLength;
        if (endIndex > infoLength) {
          endIndex = infoLength;
        }
        int page = index ~/ subStrLength + 1;
        printToConsole("[$head $page/$allPage] ${infoString.substring(index, endIndex)}");
        index += subStrLength;
      }
    }
  }

  /// 輸出字串
  void printToConsole(String info) {
    print(info);
  }
}
