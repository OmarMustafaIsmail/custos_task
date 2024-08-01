import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/modules/files/component/file_card.dart';
import 'package:custos_task/modules/files/provider/file_provider.dart';
import 'package:custos_task/utils/responsive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);

    // Initialize file provider if not already initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!fileProvider.isInitialized) {
        fileProvider.initialize(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText('File Upload and List'),
        actions: [
          if (fileProvider.isUploading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          if (!fileProvider.isUploading)
            IconButton(
              icon: const Icon(Icons.upload_file),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.any,
                  withData: true,
                );
                if (result != null) {
                  Uint8List fileBytes = result.files.first.bytes!;
                  String fileName = result.files.first.name;
                  if(context.mounted) {
                    fileProvider.uploadFile(fileName, fileBytes, context);
                  }
                }
              },
            ),
        ],
      ),
      body: Consumer<FileProvider>(
        builder: (context, provider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              // Determine layout based on screen size
              final isTablet = Responsive.isTablet(context);
              final isDesktop = Responsive.isDesktop(context);

              final crossAxisCount = isDesktop
                  ? 4
                  : isTablet
                      ? 3
                      : 2;
              final childAspectRatio = isDesktop
                  ? 4 / 3
                  : isTablet
                      ? 3 / 2
                      : 2 / 3;
              if (!fileProvider.isInitialized) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                padding: const EdgeInsets.all(8.0),
                itemCount: provider.files.length,
                itemBuilder: (context, index) {
                  final file = provider.files[index];
                  return FileCard(
                    file: file,
                    onDownload: () {
                      provider.downloadFile(fileName: file.name);
                    }, // Placeholder, download functionality omitted
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
