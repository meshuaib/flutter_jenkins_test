import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:o2o/util/lib/notification/notification_manager.dart';

/// Created by mdhasnain on 16 Apr, 2020
/// Email: md.hasnain@healthcare-tech.co.jp
///  
/// Purpose of the class:
/// 1. Singleton class for Firebase Cloud Messaging
/// 2. Initializing fcm and maintaining callbacks for fcm events
/// 3. Getting fcm token and listing fcm events

class FcmManager {
  FcmManager._();
  factory FcmManager() => _instance;
  static final FcmManager _instance = FcmManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  ///Back stack for the callback functions. This helps to remember the callback
  ///functions added from different screens.
  ///1. When a new screen is initialized a new callback is added to this list
  ///2. If another screen is called from the current screen, a new callback is
  ///   added with 'observeOnMessage(Function onMessage)' function
  ///   on top of the previous callback and the notification data will be
  ///   provided on the last callback.
  ///3. When the screen is dismissed, the last added callback is also removed
  ///   from the back stack using 'removeObserver()' function. So, the callback
  ///   added before the last one will be used to provide notification data.
  List<Function> onMessageBackStack = List();

  Future<void> init() async {
    if (!_initialized) {
      print("FCM:: init()");
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(
              sound: true, badge: true, alert: true, provisional: true
          )
      );
      // Check the notification request result for iOS
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("FCM::(Settings registered) $settings");
      });

      // Configure the fcm events
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("FCM::(onMessage) $message");
          _fcmBackgroundMessageHandler(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("FCM::(onLaunch) $message");
          _notificationClickHandler(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("FCM::(onResume) $message");
        },
//        onBackgroundMessage: (Map<String, dynamic> message) async {
//          print("FCM::(onBackgroundMessage) $message");
//          _fcmBackgroundMessageHandler(message);
//        },
      );

      // For testing purposes print the Firebase Messaging token
//      _firebaseMessaging.getToken().then((String token) {
//        print("FCM::(Push Messaging token) $token");
//        assert(token != null);
//        PrefUtil.save(PrefUtil.FCM_TOKEN, token);
//      });

      _initialized = true;
    }
  }

  void observeOnMessage(Function onMessage) {
    onMessageBackStack.add(onMessage);
  }

  void removeObserver() {
    if(onMessageBackStack.isEmpty) return;
    onMessageBackStack.removeAt(onMessageBackStack.length-1);
  }

  Future<String> getFcmToken() async {
    String token = await _firebaseMessaging.getToken();
    print("FCM::(Push Messaging token) $token");
    return token;
  }

  Future<dynamic> _notificationClickHandler(Map<String, dynamic> message) {
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("FCM::(notification) $notification");
    }

    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("FCM::(data) $data");
    }

    return null;
  }

  Future<dynamic> _fcmBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("FCM::(notification) $notification");

      String title = notification['title'];
      String body = notification['body'];
      print("FCM::(notification) $title, $body");
      if(onMessageBackStack.isEmpty) {
        NotificationManager().notify(title: title, message: body, payload: '');
      } else {
        onMessageBackStack[onMessageBackStack.length-1](title, body);
      }
    }

    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("FCM::(data) $data");
    }

    return null;
  }
}