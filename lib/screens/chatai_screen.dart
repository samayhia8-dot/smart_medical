
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/chatai_session.dart';
import '../Service/AI/gemini_service.dart';
import '../widgets/ai_images_source.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/wave_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Color _primaryColor = const Color(0xFF0284C7);

  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'أنت');

  final ChatUser _healixBot = ChatUser(
    id: '2',
    firstName: 'Healix AI',
    profileImage: 'https://cdn-icons-png.flaticon.com/512/4712/4712109.png',
  );

  final TextEditingController _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();

  final List<ChatSession> _sessions = [];
  static const String _storageKey = 'healix_chat_sessions';
  bool _isInitializing = true;
  String? _currentSessionId;

  XFile? _selectedXFile;
  Uint8List? _selectedImageBytes;

  bool _isLoading = false;

  ChatSession get _currentSession {
    return _sessions.firstWhere((session) => session.id == _currentSessionId);
  }



  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedData = prefs.getString(_storageKey);

      if (savedData != null) {
        final List<dynamic> decoded = jsonDecode(savedData);

        _sessions
          ..clear()
          ..addAll(
            decoded.map(
                  (item) => ChatSession.fromJson(
                Map<String, dynamic>.from(item as Map),
              ),
            ),
          );
      }
    } catch (e) {
      debugPrint('Error loading chats: $e');
    }

    if (!mounted) return;

    if (_sessions.isEmpty) {
      _createNewChat();
    } else {
      setState(() {
        _currentSessionId = _sessions.first.id;
        _isInitializing = false;
      });
    }
  }

  Future<void> _saveSessions() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      jsonEncode(_sessions.map((session) => session.toJson()).toList()),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _createNewChat() {
    final now = DateTime.now();

    final welcomeMessage = ChatMessage(
      user: _healixBot,
      createdAt: now,
      text:
          'أهلاً بيك في Healix AI 👋\n\n'
          'أنا مساعدك الطبي الذكي. تقدر تسألني عن معلومات طبية عامة '
          'أو ترفع صورة لتحليلها مبدئيًا.\n\n'
          'اكتب سؤالك أو اختار صورة للبدء.',
    );

    final session = ChatSession(
      id: now.microsecondsSinceEpoch.toString(),
      title: 'محادثة جديدة',
      messages: [welcomeMessage],
    );

    setState(() {
      _sessions.insert(0, session);
      _currentSessionId = session.id;
      _selectedXFile = null;
      _selectedImageBytes = null;
      _textController.clear();
      _isInitializing = false;
    });
    _saveSessions();

  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      final Uint8List bytes = await pickedFile.readAsBytes();

      if (!mounted) return;

      setState(() {
        _selectedXFile = pickedFile;
        _selectedImageBytes = bytes;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تعذر اختيار الصورة: $e')));
    }
  }


  void _clearSelectedImage() {
    setState(() {
      _selectedXFile = null;
      _selectedImageBytes = null;
    });
  }



  Future<void> _handleSendMessage() async {
    final String prompt = _textController.text.trim();
    final Uint8List? imageBytes = _selectedImageBytes;
    final XFile? imageFile = _selectedXFile;

    if (_isLoading) return;

    if (prompt.isEmpty && imageBytes == null) return;

    final ChatSession session = _currentSession;
    final DateTime now = DateTime.now();

    final List<ChatMedia> media = [];

    if (imageFile != null) {
      media.add(
        ChatMedia(
          url: imageFile.path,
          fileName: imageFile.name,
          type: MediaType.image,
        ),
      );
    }

    final ChatMessage userMessage = ChatMessage(
      user: _currentUser,
      createdAt: now,
      text: prompt,
      medias: media,
      customProperties: imageBytes != null
          ? {
        'imageBytes': imageBytes,
        'imageName': imageFile?.name,
      }
          : null,
    );

    final DateTime botCreatedAt = DateTime.now();

    final ChatMessage loadingMessage = ChatMessage(
      user: _healixBot,
      createdAt: botCreatedAt,
      text: 'جاري تحليل طلبك... ⏳',
    );

    setState(() {
      session.messages.insert(0, userMessage);
      session.messages.insert(0, loadingMessage);

      // تغيير اسم المحادثة حسب أول رسالة
      if (session.title == 'محادثة جديدة') {
        session.title = prompt.isNotEmpty
            ? prompt
            : 'استشارة بصورة';
      }

      _isLoading = true;
      _textController.clear();
      _selectedXFile = null;
      _selectedImageBytes = null;
    });

    await _saveSessions();

    String answer = '';

    try {
      await for (final String chunk in GeminiService.streamMessage(
        prompt: prompt,
        imageBytes: imageBytes,
        imageName: imageFile?.name,
      )) {
        answer += chunk;

        if (!mounted) return;

        setState(() {
          session.messages[0] = ChatMessage(
            user: _healixBot,
            createdAt: botCreatedAt,
            text: answer,
          );
        });

        await _saveSessions();
      }

      if (answer.trim().isEmpty && mounted) {
        setState(() {
          session.messages[0] = ChatMessage(
            user: _healixBot,
            createdAt: botCreatedAt,
            text: 'لم يصل رد. حاول مرة أخرى.',
          );
        });

        await _saveSessions();
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        session.messages[0] = ChatMessage(
          user: _healixBot,
          createdAt: botCreatedAt,
          text: 'حصل خطأ أثناء إرسال الرسالة. حاول مرة أخرى.',
        );
      });

      await _saveSessions();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openSession(ChatSession session) {
    setState(() {
      _currentSessionId = session.id;
      _selectedXFile = null;
      _selectedImageBytes = null;
      _textController.clear();
    });

    Navigator.pop(context);
  }

  void _deleteSession(ChatSession session) {
    setState(() {
      _sessions.removeWhere((item) => item.id == session.id);

      if (_currentSessionId == session.id) {
        if (_sessions.isNotEmpty) {
          _currentSessionId = _sessions.first.id;
        } else {
          _currentSessionId = null;
        }
      }
    });
    _saveSessions();
    if (_currentSessionId == null) {
      _createNewChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSession =
        _currentSessionId != null &&
        _sessions.any((s) => s.id == _currentSessionId);

    if (!hasSession) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 72,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: SizedBox(height: 24),
        ),

        flexibleSpace: const WaveBackground(),
        title: Row(
          children: [
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Healix",style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                Text("Your Health .. Our Priority",style: TextStyle(
                    color: Color(0xFFD0EDEE),
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                ),)
              ],)
          ],
        ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF0F172A)),//0xFF0F172A close_rounded
              onPressed: () {
                Navigator.maybePop(context);
              },
              tooltip: 'إغلاق',
            ),
          ],

      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFF8FAFC),
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFE0F2FE)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: Image.asset(
                        'assets/images/Hospital mark.png',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.local_hospital_outlined,
                            size: 40,
                            color: Color(0xFF0284C7),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'سجل استشارات Healix',
                      style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ElevatedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () {
                        Navigator.pop(context);
                        _createNewChat();
                      },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'محادثة جديدة',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            Divider(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  final session = _sessions[index];
                  final bool isSelected = session.id == _currentSessionId;

                  return Material(
                      color: isSelected
                          ? const Color(0xFFE2E8F0)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),

                      child: ListTile(
                        title: Text(
                          session.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        leading: const Icon(
                          Icons.chat_bubble_outline,
                          size: 18,
                          color: Color(0xFF0284C7),
                        ),
                        onTap: () {
                          setState(() {
                            _currentSessionId = session.id;
                            _selectedXFile = null;
                            _selectedImageBytes = null;
                            _textController.clear();
                          });
                          Navigator.pop(context);
                        },
                        trailing: IconButton(
                          tooltip: 'حذف المحادثة',
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            _deleteSession(session);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
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

        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DashChat(
                    key: ValueKey(_currentSessionId),
                    currentUser: _currentUser,
                    messages: _currentSession.messages,
                    onSend: (_) {},
                    readOnly: true,

                    messageOptions: MessageOptions(
                      showTime: true,
                      messagePadding: const EdgeInsets.all(12),
                      currentUserContainerColor: _primaryColor,
                      containerColor: Colors.white,
                      textColor: Colors.black87,

                      messageMediaBuilder: (message, previousMessage, nextMessage) {

                        final imageBytes = message.customProperties?['imageBytes'];

                        if (imageBytes is Uint8List) {
                          return Container(
                            margin: const EdgeInsets.only(top: 6, bottom: 8),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Color(0xFF2F80ED).withOpacity(0.15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                imageBytes,
                                width: 240,
                                height: 190,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }

                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Color(0xFFE1EAF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedImageBytes != null) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 112,
                height: 112,
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.memory(
                        _selectedImageBytes!,
                        width: 112,
                        height: 112,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: -7,
                      right: -7,
                      child: Material(
                        color: Colors.white,
                        shape: CircleBorder(),
                        elevation: 2,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: _isLoading ? null : _clearSelectedImage,
                          child:  Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.close,
                              size: 17,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  enabled: !_isLoading,
                  minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: 'اكتب سؤالك هنا...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                tooltip: 'إضافة صورة',
                onPressed: _isLoading
                    ? null
                    : () => showImageSourceActionSheet(
                  context: context,
                  onImageSelected: _pickImage,
                ),
                icon: Icon(
                  Icons.attach_file_rounded,
                  color: _primaryColor,
                  size: 26,
                ),
              ),
              SizedBox(width: 4),
              SizedBox(
                width: 44,
                height: 44,
                child: Material(
                  color: _primaryColor,
                  shape: CircleBorder(),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: _isLoading ? null : _handleSendMessage,
                    child: Center(
                      child: _isLoading
                          ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
