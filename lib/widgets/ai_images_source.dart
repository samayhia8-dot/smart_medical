import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showImageSourceActionSheet({
  required BuildContext context,
  required Function(ImageSource) onImageSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading:  Icon(Icons.photo_library, color: Color(0xFF0284C7)),
                  title:  Text('اختيار صورة من المعرض', style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context);
                    onImageSelected(ImageSource.gallery);
                  },
                ),
                Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  tileColor: Colors.white,
                  leading:  Icon(Icons.camera_alt, color: Color(0xFF0284C7)),
                  title:  Text('التقاط صورة بالكاميرا', style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context);
                    onImageSelected(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}