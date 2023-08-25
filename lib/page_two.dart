
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'end_drawer.dart';

/*class FbView extends StatefulWidget {
  static const String routeName = '/web-view';
  const FbView({super.key});

  @override
  State<FbView> createState() => _FbViewState();
}
class _FbViewState extends State<FbView> {
  late InAppWebViewController _FbViewController;
  bool isLoading = false;
  final GlobalKey FbViewKey = GlobalKey();
  bool isBusy = false;
  List<dynamic>? glassesData;
  CameraController? cameraController;


  @override
  void initState() {
    Permission.mediaLibrary.request();
    Permission.phone.request();
    Permission.photos.request();
    Permission.storage.request();
    Permission.camera.request();
    super.initState();
    requestCameraPermission();
    isLoading = true;
  }

  Future<void> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        print('Camera Permission Denied');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Facebook'),
          centerTitle: true,
        ),
        endDrawer: const MyEndDrawer(),
        body: isLoading
            ? Stack(
          children: [
            InAppWebView(
              key: FbViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse('https://www.facebook.com/')),
              initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(
                  loadWithOverviewMode: true,
                  loadsImagesAutomatically: true,
                  saveFormData: true,
                  useOnRenderProcessGone: true,
                  domStorageEnabled: true,
                  clearSessionCache: true,
                  thirdPartyCookiesEnabled: true,
                  useHybridComposition: true,
                  geolocationEnabled: true,
                  hardwareAcceleration: false,
                  safeBrowsingEnabled: false,
                  allowContentAccess: true,
                  allowFileAccess: true,
                  offscreenPreRaster: true,
                  needInitialFocus: true,
                  databaseEnabled: true,
                  mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                ),
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  useOnDownloadStart: true,
                  useOnLoadResource: true,
                  mediaPlaybackRequiresUserGesture: false,
                  javaScriptEnabled: true,
                  incognito: false,
                  allowFileAccessFromFileURLs: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                  allowUniversalAccessFromFileURLs: true,
                  transparentBackground: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                _FbViewController = controller;
              },
              androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
              },
            ),
          ],
        ) : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}*/



class IconSelectionScreen extends StatefulWidget {
  const IconSelectionScreen({super.key});

  @override
  _IconSelectionScreenState createState() => _IconSelectionScreenState();
}
class _IconSelectionScreenState extends State<IconSelectionScreen> {
  final List<String> _selectedIcons = [];

  void _toggleIconSelection(String icon) {
    setState(() {
      if (_selectedIcons.contains(icon)) {
        _selectedIcons.remove(icon);
      } else {
        _selectedIcons.add(icon);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> iconsList = [
      'person.png',
      'chat_logo.png',
      'virtualAssistant.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Icons'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: iconsList.length,
              itemBuilder: (context, index) {
                String icon = iconsList[index];
                bool isSelected = _selectedIcons.contains(icon);

                return ListTile(
                  // leading: Image.asset('assets/$icon'),
                  title: Text(icon),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.check_circle_outline,
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                  onTap: () => _toggleIconSelection(icon),
                );
              },
            ),
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigator(_selectedIcons)));
          }, child: Text('next'))

        ],
      ),
    );
  }
}
class BottomNavigator extends StatelessWidget {
  final List<String> selectedIcons;

  BottomNavigator(this.selectedIcons, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: selectedIcons
            .map((icon) => BottomNavigationBarItem(
          icon: Image.asset('assets/$icon'),
          label: '',
        ))
            .toList(),
      ),
    ));
  }
}

