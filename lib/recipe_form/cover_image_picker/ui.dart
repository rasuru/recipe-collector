import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/ui/padding.dart';
import 'package:recipe_collector/ui/theme.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

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
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(theme.borderRadius),
                child: BlocBuilder<CoverImage$, Option<Uint8List>>(
                  builder: (context, maybeImage) {
                    return maybeImage.fold(
                      buildNoImageSign,
                      buildPreview,
                    );
                  },
                ),
              ),
            ),
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
      child: BlocBuilder<CoverImage$, Option<Uint8List>>(
        builder: (context, maybeImage) {
          return maybeImage.fold(
            () {
              return Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(theme.borderRadius),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: buildImageSelectors(),
                ),
              );
            },
            (_) => buildResetButton(),
          );
        },
      ),
    );
  }

  Widget buildResetButton() {
    return Builder(builder: (context) {
      return OutlinedButton.icon(
        onPressed: context.watch<CoverImage$>().reset,
        style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
        icon: Icon(Icons.close),
        label: Text('Reset image'),
      );
    });
  }

  List<Widget> buildImageSelectors() {
    return [
      SizedBox(width: 10),
      Builder(builder: buildGalleryButton),
      SizedBox(width: 10),
      Builder(builder: buildCameraButton),
      SizedBox(width: 10),
    ];
  }

  OutlinedButton buildGalleryButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        setCoverImage(
          context,
          await imagePicker(
            source: ImageSource.gallery,
          ),
        );
      },
      icon: Icon(Icons.photo),
      label: Text('Gallery'),
    );
  }

  OutlinedButton buildCameraButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        setCoverImage(
          context,
          await imagePicker(
            source: ImageSource.camera,
          ),
        );
      },
      icon: Icon(Icons.camera),
      label: Text('Camera'),
    );
  }

  Future<void> setCoverImage(BuildContext context, XFile? file) async {
    if (file == null) return;
    final image = await file.readAsBytes();
    context.read<CoverImage$>().set(image);
  }

  Widget buildPreview(Uint8List image) {
    return Image.memory(image, fit: BoxFit.cover);
  }

  Widget buildNoImageSign() {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey.shade200,
      child: Icon(
        Icons.local_dining,
        size: 80,
        color: Colors.grey.shade400,
      ),
    );
  }
}
