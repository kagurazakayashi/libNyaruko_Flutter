# libNyaruko_Flutter

- 雅诗编程封装代码 libNyaruko ( Dart/Flutter 版 )
- 通用工具库，一些跨项目常用的代码会放在里面。
- 其他平台: [libNyaruko_TS](https://github.com/kagurazakayashi/libNyaruko_TS), [libNyaruko_Go](https://github.com/kagurazakayashi/libNyaruko_Go), [libNyaruko_PHP](https://github.com/kagurazakayashi/libNyaruko_PHP)

## 组件

### Log `log.dart`

**调试输出** : 用于输出调试信息，规避 Flutter 输出调试信息时的强制截断；并优化输出调试信息的便捷性。

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

### NotificationCenter `notification_center.dart`

**通知中心** : 方便跨组件通信，一个页面/组件订阅，一个或多个页面/组件发送，免去写 Delegate 等麻烦。无需手动构造对象，随处直接使用：

- 接收方订阅 `name` 并接收对象 `object`：
  - `NotificationCenter.add("通知名称", (object) { print("收到了 $object"); });`
- 发送方向 `name` 发送对象 `object`：
  - `NotificationCenter.post("通知名称", object: "要传过去的内容");`
- 记得不用时取消订阅，可在 `dispose()` 中添加：
  - `NotificationCenter.remove("通知名称");`
- 若要查询某个名称是否已被订阅，可以使用：
  - `NotificationCenter.has("通知名称");`
- 以上操作均会返回一个 `bool` 结果值用于查看是否成功。

### NewClass `newclass.dart`

**类文件新建工具** : 根据雅诗个人代码习惯，一键创建 Flutter 类的工具。

- **该脚本在终端中独立工作** ，不是 `library libnyaruko_flutter` 的内容。
- 在命令行中使用：
  - dart newclass.dart <类名> [小写类名]
  - 需要先 cd 到 lib 的上一级文件夹执行此命令。
  - **类名需要使用驼峰式命名法** ，首字母将自动转为大写。
  - 小写类名可选，如果不填写，则使用类名的 小写 + `_` 分隔形式。
  - 示例: `dart newclass.dart MyNewClass` :

| 生成的文件                              | 文件中的类名       |
| --------------------------------------- | ------------------ |
| `my_new_class/my_new_class_widget.dart` | `MyNewClassWidget` |
| `my_new_class/my_new_class_state.dart`  | `MyNewClassState`  |
| `my_new_class/my_new_class_func.dart`   | `MyNewClassFunc`   |

- 创建的代码包括：
  - 构造函数, 析构函数
  - `Widget build` 函数, `createState` 函数
  - `initState` 函数, `setState` 函数
  - `func` 类 `Delegate` 创建和 `implements` , 及其 `setState` 函数
- 可配置项：
  - 以下配置项均为 `class NewClass` 中的 `static const String`
    - 换行符：修改常量 `wrap`
    - 外观库：修改常量 `material`
    - 后缀名：修改常量 `widgetL, stateL, funcL, stateU, funcU, delegate`
    - 基本目录: 修改常量 `lib`

## LICENSE

Copyright (c) 2023 KagurazakaYashi libNyaruko_Flutter is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
