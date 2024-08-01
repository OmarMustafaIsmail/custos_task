import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/modules/files/models/files_model.dart';
import 'package:custos_task/modules/files/provider/file_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final bool isImage =
        context.read<FileProvider>().isImageFile(file.publicUrl);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    void showImagePreview() {
      if (isImage) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: InteractiveViewer(
                child: Image.network(file.publicUrl),
              ),
            );
          },
        );
      }
    }
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !isImage
                      ? const Icon(Icons.insert_drive_file, size: 48.0)
                      : SizedBox(
                          height: height * 0.1,
                          width: width * 0.1,
                          child: Image.network(
                            file.publicUrl,
                            loadingBuilder: ( context,  child,
                                progress) {
                              if(progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.insert_drive_file, size: 48.0),
                          ),
                        ),
                  const SizedBox(height: 8.0),
                  AutoSizeText(file.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4.0),
                  AutoSizeText(
                    context.read<FileProvider>().formatBytes(file.size),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: onDownload,
                    child: const AutoSizeText('Download'),
                  ),
                ],
              ),
            ),
            if (isImage)
              Positioned(
                right: 8.0,
                top: 8.0,
                child: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: showImagePreview,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
