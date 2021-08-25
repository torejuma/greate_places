import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  final Function onSelectImage;


  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File? _storedImage;

  Future<void> _takePicture () async {
    final XFile? imageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300
    );

    if (imageFile !=null ) {
      setState(() {
        _storedImage = File(imageFile.path);
      });

      final appDir = await syspath.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);

    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('No Image Taken'), //image file
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            label: Text('Take Picture'),
            icon: Icon(Icons.camera_alt),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
    );
  }
}
