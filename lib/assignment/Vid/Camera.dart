// import 'dart:io';
// import 'dart:convert'; // Import for base64Encode and base64Decode
// import 'dart:typed_data'; // Import for Uint8List
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:camera/camera.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Camera extends StatefulWidget {
//   const Camera({Key? key}) : super(key: key);

//   @override
//   State<Camera> createState() => _CameraState();
// }

// class _CameraState extends State<Camera> {
//   Uint8List? _image; // Updated to use Uint8List
//   File? selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     _loadImageFromPrefs();
//   }

//   void _loadImageFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final imageData = prefs.getString('imageData');
//     if (imageData != null) {
//       setState(() {
//         _image = base64Decode(imageData);
//       });
//     }
//   }

//   void _saveImageToPrefs(Uint8List imageBytes) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('imageData', base64Encode(imageBytes));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple[100],
//       body: Center(
//         child: Stack(
//           children: [
//             _image != null
//                 ? CircleAvatar(
//                     radius: 100,
//                     backgroundImage: MemoryImage(_image!),
//                   )
//                 : const CircleAvatar(
//                     radius: 100,
//                     backgroundImage: NetworkImage(
//                         'https://imgv3.fotor.com/images/slider-image/Female-portrait-picture-enhanced-with-better-clarity-and-higher-quality-using-Fotors-free-online-AI-photo-enhancer.jpg'),
//                   ),
//             Positioned(
//               bottom: -10,
//               left: 140,
//               child: IconButton(
//                 onPressed: () {
//                   showImagePickerOption(context);
//                 },
//                 icon: const Icon(Icons.add_a_photo),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void showImagePickerOption(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.blue[100],
//       context: context,
//       builder: (builder) {
//         return Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 4.5,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickImageFromGallery();
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(Icons.image, size: 70),
//                           Text("Gallery"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickImageFromCamera();
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(Icons.camera_alt, size: 70),
//                           Text("Camera"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _pickImageFromGallery() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile == null) return;

//     final bytes = await pickedFile.readAsBytes();
//     _saveImageToPrefs(
//         Uint8List.fromList(bytes)); // Save image to shared preferences
//     setState(() {
//       selectedImage = File(pickedFile.path);
//       _image = bytes;
//     });
//     Navigator.of(context).pop();
//   }

//   Future<void> _pickImageFromCamera() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     final cameras = await availableCameras();

//     final controller = CameraController(cameras[0], ResolutionPreset.medium);

//     try {
//       await controller.initialize();
//       final XFile pictureFile = await controller.takePicture();
//       final bytes = await pictureFile.readAsBytes();

//       _saveImageToPrefs(
//           Uint8List.fromList(bytes)); // Save image to shared preferences
//       setState(() {
//         selectedImage = File(pictureFile.path);
//         _image = bytes;
//       });
//     } catch (e) {
//       print('Error capturing image: $e');
//     } finally {
//       controller.dispose();
//     }

//     Navigator.of(context).pop();
//   }
// }
