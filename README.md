# libNyaruko_Flutter

- 雅诗编程封装代码 libNyaruko ( Dart/Flutter 版 )
- 通用工具库，一些跨项目常用的代码会放在里面。
- 其他平台: [libNyaruko_TS](https://github.com/kagurazakayashi/libNyaruko_TS), [libNyaruko_Go](https://github.com/kagurazakayashi/libNyaruko_Go), [libNyaruko_PHP](https://github.com/kagurazakayashi/libNyaruko_PHP)

## 组件

### Log (log.dart)

用于输出调试信息，规避 Flutter 输出调试信息时的强制截断；并优化输出调试信息的便捷性。

- 开始使用时，只需要创建一个 Log 类型的类属性即可。
- 在构造时，可以指定以下参数（皆为可选）：
  - `libraryName`: 库名
  - `className`: 类名
  - `subStrLength`: 分割字符数，规避 Flutter 输出调试信息时的强制截断。
- 然后即可使用 `.d()` `.i()` `.w()` `.e()` 来输出信息。例如：
  - `Log log = Log(libraryName: "SettingsPageFlutter", className: "XMLConvert"); log.i("DefaultValue = $val");` 输出：
  - `[I/SettingsPageFlutter/XMLConvert 15:03:22] DefaultValue = 200`
- 可以用 `.ee()` 输出错误信息的同时继续抛出异常。
- 使用 `.s()` 可以输出显著信息，例如:
  - `========== info ==========`
  - 字符和长度均可自定义。

## LICENSE

Copyright (c) 2023 KagurazakaYashi libNyaruko_Flutter is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.