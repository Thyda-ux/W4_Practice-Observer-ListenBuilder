import 'package:flutter/material.dart';
import 'download_controler.dart';
import '../../../providers/theme_color_provider.dart';
import '../../../theme/theme.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO IMPLEMENTED

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Resource icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: currentThemeColor.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.insert_drive_file,
                  color: currentThemeColor.color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              // Resource info and progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Resource name and size
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.ressource.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${controller.ressource.size} MB',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Three states as per PDF
                    if (controller.status == DownloadStatus.downloading) ...[
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: controller.progress,
                          backgroundColor: AppColors.greyLight,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            currentThemeColor.color,
                          ),
                          minHeight: 8,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Progress shows percentage and current size
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Downloading...',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight,
                            ),
                          ),
                          Text(
                            '${(controller.progress * 100).toInt()}% '
                            '(${(controller.ressource.size * controller.progress).toInt()} MB)',
                            style: TextStyle(
                              fontSize: 12,
                              color: currentThemeColor.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ] else if (controller.status ==
                        DownloadStatus.downloaded) ...[
                      // Downloaded state
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Downloaded',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Action buttons
              if (controller.status == DownloadStatus.notDownloaded)
                ElevatedButton(
                  onPressed: controller.startDownload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentThemeColor.color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Download'),
                )
              else if (controller.status == DownloadStatus.downloading)
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: controller.progress,
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      currentThemeColor.color,
                    ),
                  ),
                )
              else if (controller.status == DownloadStatus.downloaded)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.check, color: Colors.green),
                ),
            ],
          ),
        );
      },
    );
  }
}
