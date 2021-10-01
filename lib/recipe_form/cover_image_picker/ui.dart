import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/ui/padding.dart';
import 'package:recipe_collector/ui/theme.dart';
import 'package:image_picker/image_picker.dart';

class CoverImagePicker extends StatelessWidget {
  final bottomInset = 20.0;
  final imagePicker = ImagePicker().pickImage;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<UITheme>();

    return Padding(
      padding: paddingOf(bottom: bottomInset),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            buildPreview(theme),
            Positioned(
              bottom: -bottomInset,
              left: 0,
              right: 0,
              child: buildButtons(theme),
            ),
          ],
        ),
      ),
    );
  }

  Center buildButtons(UITheme theme) {
    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(theme.borderRadius),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: buildNoCoverImageButtons(),
        ),
      ),
    );
  }

  List<Widget> buildNoCoverImageButtons() {
    return [
      SizedBox(width: 10),
      buildGalleryButton(),
      SizedBox(width: 10),
      buildCameraButton(),
      SizedBox(width: 10),
    ];
  }

  OutlinedButton buildGalleryButton() {
    return OutlinedButton.icon(
      onPressed: () async {
        final coverImage = await imagePicker(
          source: ImageSource.gallery,
        );
      },
      icon: Icon(Icons.photo),
      label: Text('Gallery'),
    );
  }

  OutlinedButton buildCameraButton() {
    return OutlinedButton.icon(
      onPressed: () async {
        final coverImage = await imagePicker(
          source: ImageSource.camera,
        );
      },
      icon: Icon(Icons.camera),
      label: Text('Camera'),
    );
  }

  Container buildPreview(UITheme theme) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(theme.borderRadius),
      ),
      child: Text(
        'No cover image',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
