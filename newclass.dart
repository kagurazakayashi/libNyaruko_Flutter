import 'dart:io';

void main(List<String> arguments) {
  List<String> allPrint = ["Yashi Flutter Class Generator 1.2"];
  if (arguments.isEmpty || arguments.length > 2) {
    allPrint.add("Usage: dart newclass.dart <ClassName (UpperCamelCase identifier)> [lower_name]");
    allPrint.add("  e.g. `dart newclass.dart MyNewClass` -> `class MyNewClass*` + `my_new_class_*.dart`");
  } else {
    String className = arguments[0];
    String lowerName = "";
    if (arguments.length == 2) {
      lowerName = arguments[1];
    }
    NewClass newClass = NewClass(className, lowerName);
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
  static const String lib = "lib/";
  static const String wrap = "\n";
  static const String material = "material";
  static const String widgetL = "widget";
  static const String stateL = "state";
  static const String funcL = "func";
  static const String stateU = "State";
  static const String funcU = "Func";
  static const String delegate = "Delegate";

  static const String importPackage = "import 'package:";
  static const String import = "import './";
  static const String dart = ".dart";
  static const String override = "  @override";
  late String name;
  late String lower;

  NewClass(String name, String lower) {
    this.name = name.substring(0, 1).toUpperCase() + name.substring(1);
    if (lower.isEmpty) {
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
      this.lower = lowerArr.join("");
    } else {
      this.lower = lower;
    }
    newDir();
  }

  void newDir() {
    Directory directory = Directory("$lib$lower");
    if (!directory.existsSync()) {
      directory.createSync();
    }
  }

  bool isUpperCase(String char) {
    return char.toUpperCase() == char;
  }

  List<String> fWidget() {
    String fileName = "${lower}_$widgetL$dart";
    List<String> code = [
      "${importPackage}flutter/$material$dart';",
      "$import${lower}_$stateL$dart';",
      "",
      "class $name extends StatefulWidget {",
      "  const $name({super.key});",
      "",
      override,
      "  State<$name> createState() => $name$stateU();",
      "}",
      "",
    ];
    fileName = "$lib$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }

  List<String> fState() {
    String fileName = "${lower}_$stateL$dart";
    List<String> code = [
      "${importPackage}flutter/$material$dart';",
      "$import${lower}_$widgetL$dart';",
      "$import${lower}_$funcL$dart';",
      "",
      "class $name$stateU extends State<$name> implements $name$funcU$delegate {",
      "",
      "  final $name$funcU f = $name$funcU();",
      "",
      override,
      "  Widget build(BuildContext context) {",
      "    return Scaffold(",
      "      appBar: AppBar(",
      "        title: const Text('$name'),",
      "      ),",
      "      body: Container(",
      "        child: const Text('$name'),",
      "      ),",
      "    );",
      "  }",
      "",
      override,
      "  void initState() {",
      "    super.initState();",
      "    print('init $name$stateU');",
      "    f.delegate = this;",
      "    setState(() {",
      "    });",
      "  }",
      "",
      override,
      "  void dispose() {",
      "    f.dispose();",
      "    print('dispose $name$stateU');",
      "    super.dispose();",
      "  }",
      "}",
      "",
    ];
    fileName = "$lib$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }

  List<String> fFunc() {
    String fileName = "${lower}_$funcL$dart";
    List<String> code = [
      "abstract class $name$funcU$delegate {",
      "  void setState(Function() fn);",
      "}",
      "",
      "class $name$funcU {",
      "  $name$funcU$delegate? delegate;",
      "",
      "  $name$funcU() {",
      "    print('init $name$funcU');",
      "    delegate?.setState(() {",
      "    });",
      "  }",
      "",
      "  void dispose() {",
      "    print('dispose $name$funcU');",
      "  }",
      "}",
      "",
    ];
    fileName = "$lib$lower/$fileName";
    File file = File(fileName);
    file.writeAsStringSync(code.join(wrap));
    return [fileName, code.join(wrap)];
  }
}
