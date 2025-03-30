import 'dart:io';
import 'package:bellagio_mobile_user/data/models/air_tickets_model/air_tickets_model.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:open_file/open_file.dart';

import 'boarding_pass.dart';

class AirTicketBoardingPass extends StatefulWidget {
  final AirTicketModel? airTicketModel;

  AirTicketBoardingPass({Key? key, this.airTicketModel}) : super(key: key);

  @override
  State<AirTicketBoardingPass> createState() => _AirTicketBoardingPassState();
}

class _AirTicketBoardingPassState extends State<AirTicketBoardingPass> {
  final Dio _dio = Dio();
  bool _isDownloading = false;
  String? _downloadProgress;

  Future<String?> downloadFile(String url) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          throw Exception('Storage permission denied');
        }
      }

      String fileName = url.split('/').last;
      Directory saveDir = Platform.isAndroid
          ? (await getExternalStorageDirectory() ?? Directory.systemTemp)
          : await getApplicationDocumentsDirectory();

      String savePath = '${saveDir.path}/$fileName';

      // Start download
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = '${(received / total * 100).toStringAsFixed(0)}%';
            });
          }
        },
      );

      return savePath;
    } catch (e) {
      return null;
    }
  }

  void _handleDownload() async {
    String? url = widget.airTicketModel!.Ticket![0];
    String? filePath = await downloadFile(url);

    setState(() {
      _isDownloading = false;
    });

    if (filePath != null) {
      OpenFile.open(filePath);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open the file.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: ""),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                BoardingPassCard(airTicketModel: widget.airTicketModel!),
                SizedBox(height: 60),
                _isDownloading
                    ? Column(
                        children: [
                          CupertinoActivityIndicator(),
                          SizedBox(height: 10),
                          Text(_downloadProgress ?? 'Downloading...')
                        ],
                      )
                    : PrimaryButton(
                        label: "View boardpass",
                        onPressed: _handleDownload,
                        buttonStyleType: ButtonStyleType.filled,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
