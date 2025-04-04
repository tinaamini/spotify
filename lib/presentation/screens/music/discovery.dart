import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import 'package:spotify/core/di/di.dart';
import 'package:spotify/core/network/api_client.dart';
import 'package:spotify/data/services/music/musicServer.dart';
import 'package:spotify/logic/state/music/createMusic_state.dart';

import '../../../logic/cubit/music/createMusic_cubit.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController artistIdController = TextEditingController();
  File? audioFile;
  File? coverFile;
  final CreateMusicCubit _createMusicCubit = CreateMusicCubit(MusicServer(getIt<ApiClient>()));

  @override
  void dispose() {
    nameController.dispose();
    artistIdController.dispose();
    _createMusicCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _createMusicCubit,
      child: SafeArea(
        child: Scaffold(
          body: BlocListener<CreateMusicCubit, CreateMusicState>(
            listener: (context, state) {
              if (state is CreateMusicLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Uploading music...")),
                );
              } else if (state is CreateMusicSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Music uploaded successfully!")),
                );
                nameController.clear();
                artistIdController.clear();
                setState(() {
                  audioFile = null;
                  coverFile = null;
                });
              } else if (state is CreateMusicError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${state.message}")),
                );
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.w),
                child: _buildUploadForm(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upload New Music", style: AppTextStyle.TextButton),
        SizedBox(height: 10.w),
        TextField(
          style: const TextStyle(color: AppColor.appButtonColor),
          controller: nameController,
          decoration: const InputDecoration(
            labelText: "Music Name",
            labelStyle: TextStyle(color: AppColor.solidWhite),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.solidWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.appButtonColor),
            ),
          ),
        ),
        SizedBox(height: 10.w),
        TextField(
          style: const TextStyle(color: AppColor.appButtonColor),
          controller: artistIdController,
          decoration: const InputDecoration(
            labelText: "Artist ID",
            labelStyle: TextStyle(color: AppColor.solidWhite),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.solidWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.appButtonColor),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10.w),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.appButtonColor,
            foregroundColor: AppColor.solidWhite,
          ),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(type: FileType.audio);
            if (result != null && result.files.single.path != null) {
              setState(() {
                audioFile = File(result.files.single.path!);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No audio file selected")),
              );
            }
          },
          child: Text(audioFile == null ? "Pick Audio File" : "Audio Selected"),
        ),
        SizedBox(height: 10.w),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.appButtonColor,
            foregroundColor: AppColor.solidWhite,
          ),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null && result.files.single.path != null) {
              setState(() {
                coverFile = File(result.files.single.path!);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No cover image selected")),
              );
            }
          },
          child: Text(coverFile == null ? "Pick Cover Image" : "Cover Selected"),
        ),
        SizedBox(height: 20.w),
        BlocBuilder<CreateMusicCubit, CreateMusicState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.appButtonColor,
                foregroundColor: AppColor.solidWhite,
                minimumSize: Size(double.infinity, 50.h),
              ),
              onPressed: state is CreateMusicLoading
                  ? null
                  : () {
                if (nameController.text.isEmpty ||
                    artistIdController.text.isEmpty ||
                    audioFile == null ||
                    coverFile == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("All fields are required")),
                  );
                  return;
                }
                _createMusicCubit.createMusic(
                  name: nameController.text,
                  artistId: int.parse(artistIdController.text),
                  audioFile: audioFile!,
                  coverFile: coverFile!,
                );
              },
              child: state is CreateMusicLoading
                  ? const CircularProgressIndicator(color: AppColor.solidWhite)
                  : const Text("Upload Music"),
            );
          },
        ),
      ],
    );
  }
}