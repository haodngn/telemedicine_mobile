import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:telemedicine_mobile/controller/invite_videocall_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';

class DynamicLinkScreen extends StatefulWidget {
  const DynamicLinkScreen({Key? key}) : super(key: key);

  @override
  _DynamicLinkScreenState createState() => _DynamicLinkScreenState();
}

class _DynamicLinkScreenState extends State<DynamicLinkScreen> {
  TextEditingController textNameController = TextEditingController();
  final storage = new Storage.FlutterSecureStorage();
  String token = "";
  @override
  void initState() {
    super.initState();
    initStore();
  }

  initStore() async {
    // token = await storage.read(key: "accessToken") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final listDoctorController = Get.put(ListDoctorController());
    final inviteVideoCallController = Get.put(InviteVideoCallController());
    return Scaffold(
      body: FutureBuilder<String?>(
          future: storage.read(key: "accessToken"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image(
                        image: NetworkImage(
                            "https://png.pngtree.com/element_our/20190530/ourlarge/pngtree-520-couple-avatar-boy-avatar-little-dinosaur-cartoon-cute-image_1263411.jpg"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (snapshot.data == "" || snapshot.data == null) ...[
                      Text("Hãy đăng kí để sử dụng dịch vụ!"),
                      ElevatedButton(
                          onPressed: () {
                            Future.microtask(() => Navigator.pop(context));
                          },
                          child: Text("Trở về trang đăng nhập")),
                    ] else ...[
                      Text("Bạn hiện tại đã có thể tham gia cuộc gọi!"),
                      ElevatedButton(
                          onPressed: () {
                            Future.microtask(() => {
                                  Navigator.pop(context),
                                  listDoctorController.getTokenHealthCheck(
                                      inviteVideoCallController
                                          .healthCheckIDInvite.value)
                                });
                          },
                          child: Text("Bắt đầu"))
                    ]
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("cc"),
              );
            }
          }),
    );
  }
}
