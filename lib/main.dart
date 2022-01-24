import 'package:boost_getx/pages.dart';
import 'package:boost_getx/utils/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'package:get/get.dart';

import 'controller.dart';

void main() {
  CustomFlutterBinding();
  runApp(GetMaterialApp(
    home: MyApp(),
    getPages: RouteGet.getPages,
    darkTheme: ThemeData.dark(),
  ));
  // runApp(MyApp());
}

class CustomFlutterBinding extends WidgetsFlutterBinding
    with BoostFlutterBinding {}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 由于很多同学说没有跳转动画，这里是因为之前exmaple里面用的是 [PageRouteBuilder]，
  /// 其实这里是可以自定义的，和Boost没太多关系，比如我想用类似iOS平台的动画，
  /// 那么只需要像下面这样写成 [CupertinoPageRoute] 即可
  /// (这里全写成[MaterialPageRoute]也行，这里只不过用[CupertinoPageRoute]举例子)
  ///
  /// 注意，如果需要push的时候，两个页面都需要动的话，
  /// （就是像iOS native那样，在push的时候，前面一个页面也会向左推一段距离）
  /// 那么前后两个页面都必须是遵循CupertinoRouteTransitionMixin的路由
  /// 简单来说，就两个页面都是CupertinoPageRoute就好
  /// 如果用MaterialPageRoute的话同理

  Map<String, FlutterBoostRouteFactory> routerMap = {
    'mainPage': (RouteSettings settings, String? uniqueId) {
      return CupertinoPageRoute(
          settings: settings,
          builder: (_) {
            var map = (settings.arguments ?? {}) as Map<dynamic, dynamic>;
            var data = map['data'] ?? "";
            return MainPage(
              data: data,
            );
          });
    },
    'simplePage': (settings, uniqueId) {
      return CupertinoPageRoute(
          settings: settings,
          builder: (_) {
            var map = (settings.arguments ?? {}) as Map<dynamic, dynamic>;
            var data = map['data'] ?? "";
            return SimplePage(
              data: data,
            );
          });
    },
  };

  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  Widget appBuilder(Widget home) {
    // home = GetMaterialApp(
    //   home: MainPage(),
    //   getPages: RouteGet.getPages
    // );
    return MaterialApp(
      home: home,
      debugShowCheckedModeBanner: true,

      ///必须加上builder参数，否则showDialog等会出问题
      builder: (_, __) {
        return home;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(
      routeFactory,
      appBuilder: appBuilder,
      initialRoute: "simplePage",
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({dynamic data});

  void _press() {
    Log.d("jump to simple page");
    // BoostNavigator.instance.push("simplePage");
    Get.toNamed("/simplePage");
    // Get.to(SimplePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Main Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: _press,
        tooltip: "Increment",
        child: Icon(Icons.share),
      ),
    );
  }
}

class SimplePage extends StatelessWidget {
  const SimplePage({dynamic data});

  void _incrementCounter() {
    Log.d("jump to main page");
    // BoostNavigator.instance.push("mainPage");
    Get.toNamed("/mainPage");
    // Get.to(MainPage());
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(Controller());
    return Scaffold(
      body: Center(child: Obx(() => Text('SimplePage${c.count}'))),
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: "Increment",
          child: Icon(Icons.add)),
      bottomSheet: BackButton(
        onPressed: () => Get.toNamed("/main"),
      ),
    );
  }
}
