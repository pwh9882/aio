import 'package:aio/controllers/theme_controller.dart';
import 'package:aio/views/widgets/custom_main_drawer.dart';
import 'package:aio/views/widgets/menu_drawer/custom_menu_drawer.dart';
import 'package:aio/views/widgets/menu_drawer/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        drawer: isLargeScreen ? null : CustomMenuDrawer(),
        endDrawer: const CustomMainDrawer(),
        drawerEdgeDragWidth: isLargeScreen
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.5,
        body: const Center(child: MyHomePage(title: 'Flutter Demo Home Page')));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

// 이 위젯은 애플리케이션의 홈 페이지입니다. 이는 상태를 가지는 위젯으로,
// 아래에 정의된 State 객체에 영향을 주는 필드를 포함합니다.

// 이 클래스는 상태에 대한 구성입니다.
// (이 경우 제목) 부모 (이 경우 App 위젯)에서 제공되는 값 (이 경우 제목)을 보유하고
// State의 build 메서드에서 사용합니다. 위젯 하위 클래스의 필드는 항상 "final"로 표시됩니다.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // 이 setState 호출은 Flutter 프레임워크에게 이 상태에서 무언가가 변경되었음을 알려줍니다.
      // 이로 인해 아래의 build 메서드가 다시 실행되어 화면에 업데이트된 값을 반영합니다.
      // 만약 setState()를 호출하지 않고 _counter를 변경한다면, build 메서드가 다시 호출되지 않으므로
      // 아무런 변화도 일어나지 않을 것입니다.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    // 이 메서드는 setState가 호출될 때마다 다시 실행됩니다.
    // 예를 들어 _incrementCounter 메서드에서 수행됩니다.
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ThemeChangeButton(),
            Text(
              themeController.theme == ThemeMode.dark
                  ? 'Dark Mode'
                  : 'Light Mode',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
