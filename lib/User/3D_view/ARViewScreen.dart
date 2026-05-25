// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

// class ShoeArPage extends StatefulWidget {
//   final String shoeImageUrl; // رابط الصورة من Firebase

//   const ShoeArPage({super.key, required this.shoeImageUrl});

//   @override
//   State<ShoeArPage> createState() => _ShoeArPageState();
// }

// class _ShoeArPageState extends State<ShoeArPage> {
//   ARSessionManager? arSessionManager;
//   ARObjectManager? arObjectManager;
//   ARAnchorManager? arAnchorManager;

//   List<ARNode> nodes = [];

//   @override
//   void dispose() {
//     arSessionManager?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("AR Shoe Try-On")),
//       body: Stack(
//         children: [
//           ARView(
//             onARViewCreated: onARViewCreated,
//             planeDetectionConfig: PlaneDetectionConfig.horizontal, // اكتشاف الأرضية الأفقية
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(10)),
//                 child: const Text("حرك الموبايل لتمشيط الأرضية، ثم اضغط لوضع الحذاء"),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//     this.arAnchorManager = arAnchorManager;

//     this.arSessionManager!.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           showWorldOrigin: false,
//         );
//     this.arObjectManager!.onInitialize();

//     this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTap;
//   }

//   Future<void> onPlaneOrPointTap(List<ARHitTestResult> hitTestResults) async {
//     // إزالة أي شوز قديم لو موجود
//     for (var node in nodes) {
//       arObjectManager!.removeNode(node);
//     }
//     nodes.clear();

//     var hitTestResult = hitTestResults.first;
//     var anchor = ARPlaneAnchor(transformation: hitTestResult.worldTransform);
//     var addedAnchor = await arAnchorManager!.addAnchor(anchor);

//     if (addedAnchor != null) {
//       var newNode = ARNode(
//         type: NodeType.webImageUrl, 
//         uri: widget.shoeImageUrl, 
//         transformation: vector.Matrix4.identity(),
//         scale: vector.Vector3(0.2, 0.2, 0.2), // تحكم في حجم الشوز من هنا
//       );
      
//       bool? didAddNode = await arObjectManager!.addNode(newNode, planeAnchor: addedAnchor);
//       if (didAddNode!) {
//         nodes.add(newNode);
//       }
//     }
//   }
// }