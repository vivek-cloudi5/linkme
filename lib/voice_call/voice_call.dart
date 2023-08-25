import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

const appId = 1347256715;
const appSign = "d2721181a00b9b406e2351c04dfb3e472a841f82edf1b321ca7606ea6b7c9feb";

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}
class _CallPageState extends State<CallPage> {
  final String _callId = '123456789';
  late final String _userId;

  @override
  void initState() {
    super.initState();
    _userId = const Uuid().v4();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appId, // Set the appID found in your Dashboard
      appSign: appSign, // Set the appSign found in your Dashboard
      userID: _userId,
      userName: 'My Voice Call',
      callID: _callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}