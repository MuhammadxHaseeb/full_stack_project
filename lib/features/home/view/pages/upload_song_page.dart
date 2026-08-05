import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:full_stack_project/core/theme/app_pallete.dart';
import 'package:full_stack_project/core/utils.dart';
import 'package:full_stack_project/core/widgets/custom_field.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:full_stack_project/features/home/widegts/audio_wave.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final formKey = GlobalKey<FormState>();
  final artistNameController = TextEditingController();
  final songNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  
  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if(pickedAudio != null) {
      setState((){
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if(pickedImage != null) {
      setState((){
        selectedImage = pickedImage;
      });
    }
  }

  @override   
  void dispose() {
    songNameController.dispose();
    artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [
        IconButton(
          onPressed: () {
            // Your action here
          },
          icon: const Icon(Icons.check),
        ),
      ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: selectImage,
                  child: selectedImage != null ? 
                  SizedBox(
                    height: 150,
                    width: double.infinity,  
                    child: ClipRRect(
                      borderRadius:  BorderRadius.circular(10),
                      child: Image.file(selectedImage!, fit: BoxFit.cover,))) :DottedBorder(
                    options: const RoundedRectDottedBorderOptions(
                      color: Pallete.borderColor,
                      radius: Radius.circular(10),
                      dashPattern: const [10, 4],
                    ),
                    child: const SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open, size: 40),
                          SizedBox(height: 15),
                          Text(
                            'Select the thumbnail',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                selectedAudio != null ? AudioWave(path: selectedAudio!.path):
                CustomField(
                  hintText: 'Pick a Song',
                  controller: null,
                  obscureText: false,
                  readOnly: true,
                  onTap: selectAudio,
                ),
                const SizedBox(height: 20),
                CustomField(
                  hintText: 'Artist',
                  controller: artistNameController,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                CustomField(
                  hintText: 'Song Name',
                  controller: songNameController,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.wheel: true,
                  },
                  color: selectedColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      selectedColor=color;
                    });
                  },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}