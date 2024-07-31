import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/modules/files/component/file_card.dart';
import 'package:custos_task/modules/files/provider/file_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText('File Upload and List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles();
              if (result != null) {
                final file = File(result.files.single.path!);
                await fileProvider.uploadFile(file);
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fileProvider.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1200
                  ? 4
                  : constraints.maxWidth > 800
                  ? 3
                  : 2;
              final childAspectRatio = constraints.maxWidth > 600 ? 4 / 3 : 3 / 2;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                padding: const EdgeInsets.all(8.0),
                itemCount: fileProvider.files.length,
                itemBuilder: (context, index) {
                  final file = fileProvider.files[index];
                  return FileCard(
                    file: file,
                    onDownload: () {}, // Placeholder, download functionality omitted
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
