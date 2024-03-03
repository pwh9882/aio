import 'package:aio/controllers/list_drawer_controller.dart';
import 'package:aio/controllers/theme_controller.dart';
import 'package:aio/views/widgets/custom_main_drawer.dart';
import 'package:aio/views/widgets/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<ListDrawerController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: "drawer test");
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
    final drawerController = Get.find<ListDrawerController>();

    // 이 메서드는 setState가 호출될 때마다 다시 실행됩니다.
    // 예를 들어 _incrementCounter 메서드에서 수행됩니다.
    //
    // 플러터 프레임워크는 빌드 메서드를 다시 실행해야 하는 위젯의 인스턴스를 개별적으로 변경하는 대신,
    // 업데이트가 필요한 모든 것을 다시 빌드하는 것을 가능하게하는 최적화되었습니다.
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        // App.build 메서드에서 생성된 MyHomePage 객체에서 값을 가져와서
        // 앱바 제목으로 설정합니다.
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      endDrawer: const CustomMainDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.5,
      body: Center(
        // Center는 레이아웃 위젯입니다. 하나의 자식을 가지고 있으며,
        // 부모의 가운데에 위치시킵니다.
        child: Column(
          // Column은 레이아웃 위젯입니다. 자식들을 수직으로 정렬합니다.
          // 기본적으로 가로로 자식들을 맞추고, 부모의 높이만큼 높이를 조절합니다.
          //
          // "debug painting"을 활성화하면 (콘솔에서 "p"를 누르고, Android Studio의 Flutter Inspector에서 "Toggle Debug Paint" 작업을 선택하거나, Visual Studio Code에서 "Toggle Debug Paint" 명령을 선택),
          // 각 위젯의 와이어프레임을 볼 수 있습니다.
          //
          // Column은 자신의 크기와 자식들의 위치를 제어하는 다양한 속성을 가지고 있습니다.
          // 여기서는 mainAxisAlignment을 사용하여 자식들을 수직으로 가운데 정렬합니다.
          // 주축은 수직축이며 Column은 수직 방향으로 정렬됩니다. (교차축은 수평 방향입니다.)
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
            ElevatedButton(
              onPressed: drawerController.toggleDrawer,
              child: const Text("Toggle Drawer"),
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
