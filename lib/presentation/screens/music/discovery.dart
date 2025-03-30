import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import 'package:spotify/core/di/di.dart';
import 'package:spotify/core/network/api_client.dart';
import 'package:spotify/data/models/music/artistmodel.dart';
import 'package:spotify/data/models/music/playlistModel.dart';
import 'package:spotify/data/services/music/musicServer.dart';
import 'package:spotify/logic/cubit/music/createMusic_cubit.dart';
import 'package:spotify/logic/cubit/music/tab_cubit.dart';
import 'package:spotify/logic/state/music/tabState.dart';
import '../../widgets/btn_play.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<DiscoveryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController artistIdController = TextEditingController();
  File? audioFile;
  File? coverFile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateMusicCubit(
        MusicServer(getIt<ApiClient>()),
      ),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.w),
                      child: _buildUploadForm(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
          style: TextStyle(color: AppColor.appButtonColor),
          controller: nameController,
          decoration: InputDecoration(
            labelText: "Music Name",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10.w),
        TextField(
          style: TextStyle(color: AppColor.appButtonColor),
          controller: artistIdController,
          decoration: InputDecoration(
            labelText: "Artist ID",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10.w),
        ElevatedButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(type: FileType.audio);
            if (result != null && result.files.single.path != null) {
              setState(() {
                audioFile = File(result.files.single.path!);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No audio file selected")),
              );
            }
          },
          child: Text(audioFile == null ? "Pick Audio File" : "Audio Selected"),
        ),
        SizedBox(height: 10.w),
        ElevatedButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null && result.files.single.path != null) {
              setState(() {
                coverFile = File(result.files.single.path!);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No cover image selected")),
              );
            }
          },
          child: Text(coverFile == null ? "Pick Cover Image" : "Cover Selected"),
        ),
        SizedBox(height: 10.w),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isEmpty ||
                artistIdController.text.isEmpty ||
                audioFile == null ||
                coverFile == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("All fields are required")),
              );
              return;
            }
            context.read<CreateMusicCubit>().createMusic(
              name: nameController.text,
              artistId: int.parse(artistIdController.text),
              audioFile: audioFile!,
              coverFile: coverFile!,
            );
            nameController.clear();
            artistIdController.clear();
            setState(() {
              audioFile = null;
              coverFile = null;
            });
          },
          child: Text("Upload Music"),
        ),
      ],
    );
  }
}