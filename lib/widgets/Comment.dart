import 'package:flutter/material.dart';
import '../Firebase/FireStore/posts_interactioons.dart';

class CommentsSheet extends StatefulWidget {
  final String postUrl;

  const CommentsSheet({super.key, required this.postUrl});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final service = PostsInteractions();
  final controller = TextEditingController();

  List<Map<String, dynamic>> comments = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> loadComments() async {
    final result = await service.getComments(widget.postUrl);

    if (!mounted) return;
    setState(() {
      comments = result;
      loading = false;
    });
  }

  Future<void> sendComment() async {
    final text = controller.text.trim();

    if (text.isEmpty || service.getUid().isEmpty) return;

    controller.clear();
    await service.addComment(widget.postUrl, text);
    await loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: 400,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFFD5EAF4),
              ],
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Comments',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: buildList()),
              buildInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: Colors.black54,));
    }

    if (comments.isEmpty) {
      return const Center(child: Text('No comments yet. Be the first!'));
    }

    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];

        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(comment['userName']),
          subtitle: Text(comment['text']),
        );
      },
    );
  }

  Widget buildInput() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                filled: true,
                fillColor:  Colors.white,//(0xFFEAF6F9),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF008A92),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: sendComment,
            ),
          ),
        ],
      ),
    );
  }
}