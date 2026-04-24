// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/widgets/ar_view.dart';
// import 'package:flutter/material.dart';

// class ARViewScreen extends StatefulWidget {
//   const ARViewScreen({super.key});

//   @override
//   State<ARViewScreen> createState() => _ARViewScreenState();
// }

// class _ARViewScreenState extends State<ARViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: ARView(onARViewCreated: onARViewCreated));
//   }

//   void onARViewCreated(
//     ARSessionManager sessionManager,
//     ARObjectManager objectManager,
//     ARAnchorManager anchorManager,
//     ARLocationManager locationManager,
//   ) {
//     sessionManager.onInitialize(
//       showFeaturePoints: false,
//       showPlanes: true,
//       showWorldOrigin: false,
//     );
//   }
// }
