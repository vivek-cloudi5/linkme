import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:linkme/page_one.dart';
import 'package:linkme/page_two.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import 'chat_gpt/main.dart';
import 'voice_AI/home_page.dart';
import 'voice_call/voice_call.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      defaultTransition: Transition.fade,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7)).then((value) => setState(() {
          isLoaded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      navigateRoute: const LockScreen(),
      backgroundColor: Colors.transparent,
      linearGradient: const LinearGradient(
          colors: [
            Colors.black,
            Colors.white,
            // Color(0xFF3366FF),
            // Color(0xFF00CCFF),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.repeated),
      text: WavyAnimatedText(
        "Link Me",
        textStyle: const TextStyle(
          color: Colors.white54,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: "assets/logo_light_lottie.json",
      //  displayLoading: false,
    );
  }
}

class LockScreen extends StatelessWidget {
  static const String routeName = '/welcome';

  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenLock(
      correctString: '1100',
      useBlur: true,
      keyPadConfig: KeyPadConfig(clearOnLongPressed: true),
      onCancelled: Navigator.of(context).pop,
      onUnlocked: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const BottomNavSelectionScreen()));
      },
    );
  }
}

class BottomNavSelectionScreen extends StatefulWidget {
  static const String routeName = '/bottom_nav_selection';

  const BottomNavSelectionScreen({super.key});

  @override
  _BottomNavSelectionScreenState createState() =>
      _BottomNavSelectionScreenState();
}
class _BottomNavSelectionScreenState extends State<BottomNavSelectionScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    IconSelectionScreen(),
    const VoiceChat(),
    const CallPage(),
    const WebView(),
    const ChatMe(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Bottom Navigation Selection'),
        //   backgroundColor: Colors.transparent,
        //   centerTitle: true,
        // ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: 'Facebook',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.business, color: Colors.black),
                label: 'Instagram',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.school, color: Colors.black),
                label: 'Twitter',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.language_outlined, color: Colors.black),
                label: 'WebView',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.chair_outlined, color: Colors.black),
                label: 'GPT',
                backgroundColor: Colors.blue),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
