import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArkitTestTap extends StatefulWidget {
  @override
  _ArkitTestTapState createState() => _ArkitTestTapState();
}

class _ArkitTestTapState extends State<ArkitTestTap> {
  ARKitController arkitController;
  ARKitSphere sphere;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Tap Gesture Sample')),
    body: Container(
      child: ARKitSceneView(
        enableTapRecognizer: true,
        onARKitViewCreated: onARKitViewCreated,
      ),
    ),
  );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodeTap = (name) => onNodeTapHandler(name);

    final material = ARKitMaterial(
        diffuse: ARKitMaterialProperty(
          color: Colors.yellow,
        ));
    sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );

    final node = ARKitNode(
      name: 'sphere',
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.5),
    );
    this.arkitController.add(node);
  }

  void onNodeTapHandler(String name) {
    final color = sphere.materials.value.first.diffuse.color == Colors.yellow
        ? Colors.blue
        : Colors.yellow;
    sphere.materials.value = [
      ARKitMaterial(diffuse: ARKitMaterialProperty(color: color))
    ];
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('You tapped on $name')),
    );
  }
}