import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationApp(),
    );
  }
}

class NotificationApp extends StatefulWidget {
  const NotificationApp({Key? key}) : super(key: key);

  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {

  late FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings =  new InitializationSettings(android:  androidInitialize, iOS:  iosInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Already push notification'),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Future _showNotification() async{
    var androidDetails = new AndroidNotificationDetails(
        'channelId',
        'Local Notification',
        importance: Importance.high,

    );

    var iOSDetails = new IOSNotificationDetails();

    var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await localNotification.show(1, 'title', 'body', generalNotificationDetails);
  }

  void _pushNotification(BuildContext context){
    _showToast(context);
    _showNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Click the button to receive a notification'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.notifications),
        onPressed: () => _pushNotification(context),
      ),
    );
  }
}
