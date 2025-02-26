import 'package:contador_calorias/controller/open_camera_controller.dart';
import 'package:contador_calorias/controller/open_gallery_controller.dart';
import 'package:contador_calorias/screens/view_image.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  OpenCameraController openCameraController = OpenCameraController();
  OpenGalleryController openGalleryController = OpenGalleryController();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: Text(
                'Para iniciar escolha uma das opções a baixo:',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final image = await openCameraController.cameraButton();
                      navigator.push(
                        MaterialPageRoute(
                          builder: (context) => ViewImage(image: image),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'Câmera',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final image = await openGalleryController.galleryButton();
                      if (image != null) {
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => ViewImage(image: image),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'Galeria',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
