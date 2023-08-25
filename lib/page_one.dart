
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import 'end_drawer.dart';

class WebView extends StatefulWidget {
  static const String routeName = '/web-view';
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late InAppWebViewController _webViewController;
  bool isLoading = false;
  final GlobalKey webViewKey = GlobalKey();
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
        // Handle denied permission
        // Show a message or dialog to the user explaining why camera permission is required
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Len web view'),
          centerTitle: true,
        ),
        endDrawer: const MyEndDrawer(),
        body: isLoading
            ? Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse('https://mirror.virtooal.com/app/7af8d58c19eef8a066e7fab8a5088ce8/arun.raj@solstium.net?c=000000&l=en')),
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
                  hardwareAcceleration: true,
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
                _webViewController = controller;
              },
              androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
              },

              /* onDownloadStartRequest: (controller, downloadStartRequest) async {
                Directory downloadsDirectory =
                await getApplicationDocumentsDirectory();
                await FlutterDownloader.enqueue(
                  url: downloadStartRequest.url.toString(),
                  savedDir: downloadsDirectory.absolute.path,
                  showNotification: true,
                  openFileFromNotification: true,
                );
              },*/
              /* onDownloadStart: (controller, url) async {
                print("onDownloadStart $url");
                final taskId = await FlutterDownloader.enqueue(
                  url:  url.toString(),
                  savedDir: (await getExternalStorageDirectory())!.path,
                  showNotification: true, // show download progress in status bar (for Android)
                  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                );
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                if (navigationAction.request.url.toString() == 'about:print') {
                  // Handle print request here
                  await _webViewController.android;
                  return NavigationActionPolicy.CANCEL;
                }
                return NavigationActionPolicy.ALLOW;
              },*/
            ),
          ],
        ) : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
