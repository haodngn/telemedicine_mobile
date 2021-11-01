import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

import '../../constant.dart';

//appID in Agora
const appID = "834dec7fc5144086a2fe803cb3e51fff";
//token to get in room of Agora
// const token =
//     "006834dec7fc5144086a2fe803cb3e51fffIABR16jJtM+hfS4WT9ZxVJqnzvzsApLRgvAZicdfUEJn4p/w5cEh39v0KADCh505agF6YQUAAQAAAAAAAgAAAAAAAwAAAAAABAAAAAAA6AMAAAAA";

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  static final _users = <int>[];
  bool muted = false, disableCamera = false;
  late RtcEngine _engine;
  final patientProfileController = Get.put(PatientProfileController());

  @override
  void initState() {
    super.initState();
    initAgora();
    print("object: " + listDoctorController.healthCheckToken.value.token);
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    // _engine.destroy();
    super.dispose();
  }

  final listDoctorController = Get.put(ListDoctorController());
  final accountController = Get.put(AccountController());
  Future<void> initAgora() async {
    //create the engine
    await initializeAgoraEngine();
    addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);

    await _engine.joinChannel(
        listDoctorController.healthCheckToken.value.token,
        "SLOT_" +
            listDoctorController.healthCheckToken.value.slots[0].id.toString(),
        null,
        0);

    _engine.enableLocalVideo(!disableCamera);
  }

  Future<void> initializeAgoraEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appID));
    await _engine.enableVideo();
  }

  void addAgoraEventHandlers() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {},
        joinChannelSuccess: (channel, uid, elapsed) {},
        leaveChannel: (stats) {
          setState(() {
            _users.clear();
          });
        },
        userJoined: (uid, elapsed) {
          print(uid);
          setState(() {
            if (!_users.contains(uid)) {
              _users.add(uid);
            }
          });
        },
        userOffline: (uid, elapsed) {
          setState(() {
            _users.remove(uid);
          });
        },
      ),
    );
  }

  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    list.add(RtcLocalView.SurfaceView());
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tele Medicine Video Call'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: kBackgroundVideoColor,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  Widget _viewRows() {
    final views = _getRenderViews();
    print("TEST" + views.length.toString());
    print(views);
    switch (views.length) {
      case 1:
        return Container(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  _expandedVideoRow([views[0]])
                ],
              ),
              Positioned.fill(
                top: 10,
                child: Align(
                  alignment:
                      !disableCamera ? Alignment.center : Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'Đang kết nối với bác sĩ tư vấn của bạn...',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      case 2:
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow([views[0]]),
              _expandedVideoRow([views[1]])
            ],
          ),
        );
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      case 5:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4)),
            _expandedVideoRow(views.sublist(4, 5)),
          ],
        ));
      case 6:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4)),
            _expandedVideoRow(views.sublist(4, 5)),
            _expandedVideoRow(views.sublist(4, 6)),
          ],
        ));
      default:
    }
    return Container();
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: _onToggleCamera,
            child: Icon(
              !disableCamera
                  ? Icons.videocam_outlined
                  : Icons.videocam_off_outlined,
              color: disableCamera ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: disableCamera ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    // destroy sdk
    _engine.leaveChannel();
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onToggleCamera() {
    setState(() {
      disableCamera = !disableCamera;
    });
    _engine.enableLocalVideo(!disableCamera);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
}

// class ShowAvatar extends StatelessWidget {
//   const ShowAvatar({
//     Key? key,
//     required this.patientProfileController,
//     required this.width,
//     required this.height,
//   }) : super(key: key);
//
//   final PatientProfileController patientProfileController;
//   final double width, height;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.all(10.0),
//             width: width,
//             height: height,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white70, width: 2),
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(patientProfileController
//                     .patient.value.avatar ==
//                     ""
//                     ? 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
//                     : patientProfileController.patient.value.avatar),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
