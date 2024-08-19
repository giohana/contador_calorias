import 'package:contador_calorias/controller/open_camera_controller.dart';
import 'package:contador_calorias/screens/confirm_screen.dart';
import 'package:flutter/material.dart';

class OpenCamera extends StatefulWidget {
  const OpenCamera({super.key});

  @override
  State<OpenCamera> createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  OpenCameraController openCameraController = OpenCameraController();

  @override
  Widget build(BuildContext context) {
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
                'Para iniciar escolha uma das opcoes a baixo:',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
            ),
            openCameraController.selectedImage == null
                ? bodyImageNotSelected()
                : bodyImageSelected(),
          ],
        ),
      ),
    );
  }

  Widget bodyImageNotSelected() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              openCameraController.cameraButton();
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
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
            onPressed: () {
              openCameraController.galleryButton();
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            ),
            child: const Text(
              'Galeria',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget bodyImageSelected() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: Center(
            child: Image.file(
              openCameraController.selectedImage!,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: const Text(
            'Continuar com imagem selecionada?',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    openCameraController.selectedImage = null;
                  },
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmScreen(
                      selectedImage: openCameraController.selectedImage,
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  openCameraController.selectedImage = null;
                });
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text(
                'Tentar Novamente',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
