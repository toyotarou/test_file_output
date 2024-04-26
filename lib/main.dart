// import 'dart:io';
//
// import 'package:external_path/external_path.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({required this.title});
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   Future<void> maketxt() async {
//     String fileName = 'aaa.txt';
//     String sandFileName = 'bbb.txt';
//
//     final logDirectory = await getApplicationDocumentsDirectory();
//
//     String logPath = '${logDirectory.path}/test.txt';
//
//     File textfilePath = File(logPath);
//
//     await textfilePath.writeAsString('test');
//
//     // final downloadsDirectory = "/storage/emulated/0/Download";
//     //
//     // final newPath = downloadsDirectory + '/$fileName';
//     //
//     // final fileObj = File(sandFileName).copySync(newPath);
//     //
//     // final state = (fileObj.path.length > 0);
//
//     // print('save gallery $sandFileName : $state');
//     // print(newPath);
//
//     final directoryPath = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
//     print(directoryPath);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: maketxt,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:external_path/external_path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _exPath = [];

  @override
  void initState() {
    super.initState();

    getPath();

    getPublicDirectoryPath();
  }

  // Get storage directory paths
  // Like internal and external (SD card) storage path
  Future<void> getPath() async {
    List<String> paths;
    // getExternalStorageDirectories() will return list containing internal storage directory path
    // And external storage (SD card) directory path (if exists)
    paths = await ExternalPath.getExternalStorageDirectories();

    setState(() {
      _exPath = paths; // [/storage/emulated/0, /storage/B3AE-4D28]
    });
  }

  // To get public storage directory path like Downloads, Picture, Movie etc.
  // Use below code
  Future<void> getPublicDirectoryPath() async {
    String path;

    path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

    setState(() {
      print(path); // /storage/emulated/0/Download
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ListView.builder(
          itemCount: _exPath.length,
          itemBuilder: (context, index) {
            return Center(child: Text("${_exPath[index]}"));
          }),
    ));
  }
}
