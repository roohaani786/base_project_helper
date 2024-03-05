import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/config/logger_config.dart';
import 'network_manager.dart';

class NetworkStatusWrapper extends StatelessWidget {
  final Widget child;

  const NetworkStatusWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red, // You can customize the background color
        textColor: Colors.white, // You can customize the text color
        fontSize: 16.0,
      );
    }

    return StreamBuilder<bool>(
      stream: networkManager.connectionStatus,
      initialData: true, // Assume there's an internet connection initially
      builder: (context, snapshot) {
        if (!snapshot.data!) {
          // No internet access
          showToast('No Internet Access');
        } else {
          // Internet connection is available
          if (networkManager.internetSpeedTested) {
            // Speed test already performed
          } else {
            Future.delayed(const Duration(seconds: 3), () {
              bool isSlow = networkManager.isInternetSlow(0.1);
              if (isSlow) {
                // Internet speed is slow, show toast
                logger.i("Internet Slow");
                networkManager.internetSpeedTested = true;
                // if(networkManager.getCurrentInternetSpeed() != 0.0){
                //   showToast('Your Internet looks Slow');
                // }
                // else{
                //   showToast('No Internet');
                // }
              }
            });
          }
        }

        return child;
      },
    );
  }
}
