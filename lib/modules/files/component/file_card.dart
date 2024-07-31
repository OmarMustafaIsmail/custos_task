import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/modules/files/models/files_model.dart';
import 'package:flutter/material.dart';


class FileCard extends StatelessWidget {
  final FileModel file;
  final VoidCallback onDownload;

  const FileCard({
    super.key,
    required this.file,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.insert_drive_file, size: 48.0),
            const SizedBox(height: 8.0),
            AutoSizeText(
              file.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(height: 4.0),
            AutoSizeText(
              file.url,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: onDownload,
              child:const AutoSizeText('Download'),
            ),
          ],
        ),
      ),
    );
  }
}
