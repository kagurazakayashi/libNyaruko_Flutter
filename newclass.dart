import 'dart:io';

void main(List<String> arguments) {
  List<String> allPrint = ["Flutter Class Generator by KagurazakaYashi"];
  if (arguments.length != 1) {
    allPrint.add("Usage: dart newclass.dart <classname(UpperCamelCase identifier)>");
    allPrint.add("  e.g. `dart newclass.dart MyNewClass` -> `class MyNewClass*` + `my_new_class_*.dart`");
  } else {
    String className = arguments[0];
    NewClass newClass = NewClass(className);
    allPrint.add("Input class name: $className");
    allPrint.add("Class name: ${newClass.name}");
    allPrint.add("Lower file name: ${newClass.lower}.dart");
    allPrint.add("");
    List<String> widget = newClass.fWidget();
    List<String> state = newClass.fState();
    List<String> func = newClass.fFunc();
    String l = "=" * 5;
    allPrint.add("$l ${widget[0]} $l");
    allPrint.add(widget[1]);
    allPrint.add("$l ${state[0]} $l");
    allPrint.add(state[1]);
    allPrint.add("$l ${func[0]} $l");
    allPrint.add(func[1]);
  }
  print(allPrint.join(NewClass.wrap));
}

class NewClass {
  static const String wrap = "\n";
  static const String importPackage = "import 'package:";
  static const String import = "import './";
  static const String dart = ".dart";
  static const String widget = "widget";
  static const String state = "state";
  static const String func = "func";
  static const String material = "material";
  late String name;
  late String lower;

  NewClass(String name) {
    this.name = name.substring(0, 1).toUpperCase() + name.substring(1);
    List<String> lowerArr = [];
    for (int i = 0; i < this.name.length; i++) {
      String char = this.name[i];
      if (isUpperCase(char)) {
        if (i > 0) {
          lowerArr.add("_");
        }
        lowerArr.add(char.toLowerCase());
      } else {
        lowerArr.add(char);
      }
    }
    lower = lowerArr.join("");
    newDir();
  }

  void newDir() {
    Directory directory = Directory(lower);
    if (!directory.existsSync()) {
      directory.createSync();
    }
  }

  bool isUpperCase(String char) {
    return char.toUpperCase() == char;
  }

  List<String> fWidget() {
    String fileName = "${lower}_$widget$dart";
    List<String> code = [
      "${importPackage}flutter/$material$dart';",
      "$import${lower}_$state$dart';",
      "",
      "class $name extends StatefulWidget {",
      "  const $name({super.key});",
      "",
      "  @override",
      "  State<$name> createState() => ${name}State();",
      "}",
      "",
    ];
    fileName = "$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }

  List<String> fState() {
    String fileName = "${lower}_$state$dart";
    List<String> code = [
      "${importPackage}flutter/$material$dart';",
      "$import${lower}_$widget$dart';",
      "$import${lower}_$func$dart';",
      "",
      "class ${name}State extends State<$name> implements ${name}FuncDelegate {",
      "",
      "  final ${name}Func f = ${name}Func();",
      "",
      "  @override",
      "  Widget build(BuildContext context) {",
      "    return Container(",
      "      child: Text('$name'),",
      "    );",
      "  }",
      "",
      "  @override",
      "  void initState() {",
      "    super.initState();",
      "    print('init ${name}State');",
      "    f.delegate = this;",
      "    setState(() {",
      "    });",
      "  }",
      "",
      "  @override",
      "  void dispose() {",
      "    f.dispose();",
      "    print('dispose ${name}State');",
      "    super.dispose();",
      "  }",
      "}",
      "",
    ];
    fileName = "$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }

  List<String> fFunc() {
    String fileName = "${lower}_$func$dart";
    List<String> code = [
      "abstract class ${name}FuncDelegate {",
      "  void setState(Function() fn);",
      "}",
      "",
      "class ${name}Func {",
      "  late ${name}FuncDelegate delegate;",
      "",
      "  ${name}Func() {",
      "    print('init ${name}Func');",
      "    delegate?.setState(() {",
      "    });",
      "  }",
      "",
      "  void dispose() {",
      "    print('dispose ${name}Func');",
      "  }",
      "}",
      "",
    ];
    fileName = "$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }
}
