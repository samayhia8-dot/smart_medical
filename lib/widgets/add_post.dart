import 'package:flutter/material.dart';
import '../Firebase/FireStore/posts_interactioons.dart';

class AddPostSheet extends StatefulWidget {
  const AddPostSheet({super.key});

  @override
  State<AddPostSheet> createState() => _AddPostSheetState();
}

class _AddPostSheetState extends State<AddPostSheet> {
  final service = PostsInteractions();
  final titleController = TextEditingController();
  final textController = TextEditingController();
  bool saving = false;

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }

  Future<void> publish() async {
    final title = titleController.text.trim();
    final text = textController.text.trim();
    if (title.isEmpty || text.isEmpty) return;

    setState(() => saving = true);

    try {
      await service.addDoctorPost(title, text);
      if (mounted)Navigator.pop(context, true);
    } catch (e) {
      if (mounted) setState(() => saving = false);
    }
  }

  Widget field(TextEditingController controller, String hint, int lines) {
    return TextField(
      controller: controller,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFD5EAF4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFF1AA6B0), width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFD5EAF4)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.edit_note, color: Color(0xFF1AA6B0), size: 28),
                SizedBox(width: 8),
                Text(
                  'Add Post',
                  style: TextStyle(
                    color: Color(0xFF1B4F7A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            field(titleController, 'Title', 1),
            SizedBox(height: 12),
            field(textController, 'Write your post...', 6),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (!saving) publish();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Color(0xFF1AA6B0),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: saving
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    'Publish',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}