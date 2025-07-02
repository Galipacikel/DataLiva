import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Map<String, dynamic>> users = [
    {
      'name': 'Galip',
      'avatar': 'G',
      'active': true,
      'lastMessage': 'Nasılsın?',
      'lastTime': '13:45',
      'read': true,
      'pinned': false,
      'muted': false,
      'blocked': false,
      'unread': false,
      'deleted': false,
    },
    {
      'name': 'Ayşe',
      'avatar': 'A',
      'active': false,
      'lastMessage': 'Toplantı saat kaçta?',
      'lastTime': '12:10',
      'read': false,
      'pinned': false,
      'muted': false,
      'blocked': false,
      'unread': true,
      'deleted': false,
    },
    {
      'name': 'Mehmet',
      'avatar': 'M',
      'active': true,
      'lastMessage': 'Teşekkürler!',
      'lastTime': '09:30',
      'read': true,
      'pinned': false,
      'muted': false,
      'blocked': false,
      'unread': false,
      'deleted': false,
    },
    {
      'name': 'Zeynep',
      'avatar': 'Z',
      'active': false,
      'lastMessage': 'Görüşürüz.',
      'lastTime': 'Dün',
      'read': false,
      'pinned': false,
      'muted': false,
      'blocked': false,
      'unread': true,
      'deleted': false,
    },
  ];
  List<Map<String, dynamic>> archivedUsers = [];
  String _search = '';
  bool showArchived = false;

  // Her kullanıcı için mesaj geçmişi
  Map<String, List<Map<String, dynamic>>> chatHistory = {
    'Galip': [
      {'text': 'Merhaba!', 'isMe': false, 'time': '13:40', 'read': true, 'type': 'text'},
      {'text': 'Nasılsın?', 'isMe': false, 'time': '13:41', 'read': true, 'type': 'text'},
      {'text': 'İyiyim, sen?', 'isMe': true, 'time': '13:42', 'read': true, 'type': 'text'},
    ],
    'Ayşe': [
      {'text': 'Merhaba!', 'isMe': false, 'time': '13:40', 'read': true, 'type': 'text'},
      {'text': 'Nasılsın?', 'isMe': false, 'time': '13:41', 'read': true, 'type': 'text'},
      {'text': 'İyiyim, sen?', 'isMe': true, 'time': '13:42', 'read': true, 'type': 'text'},
    ],
    'Mehmet': [
      {'text': 'Teşekkürler!', 'isMe': false, 'time': '09:30', 'read': true, 'type': 'text'},
    ],
    'Zeynep': [
      {'text': 'Görüşürüz.', 'isMe': false, 'time': 'Dün', 'read': false, 'type': 'text'},
    ],
  };

  void _moveUserToTop(String name, String lastMessage, String lastTime) {
    final idx = users.indexWhere((u) => u['name'] == name);
    if (idx != -1) {
      final user = users.removeAt(idx);
      user['lastMessage'] = lastMessage;
      user['lastTime'] = lastTime;
      user['read'] = true;
      users.insert(0, user);
      _sortUsers();
      setState(() {});
    }
  }

  void _sortUsers() {
    users.sort((a, b) {
      if (a['pinned'] && !b['pinned']) return -1;
      if (!a['pinned'] && b['pinned']) return 1;
      return 0;
    });
  }

  void _archiveUser(int index) {
    setState(() {
      archivedUsers.insert(0, users.removeAt(index));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GestureDetector(
          onTap: () {
            setState(() {
              showArchived = true;
            });
          },
          child: Row(
            children: [
              Icon(Icons.archive, color: Colors.white),
              SizedBox(width: 8),
              Text('Arşivlenmiş sohbetler'),
            ],
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey[900],
      ),
    );
  }

  void _unarchiveUser(int index) {
    setState(() {
      users.insert(0, archivedUsers.removeAt(index));
      _sortUsers();
    });
  }

  void _showActions(BuildContext context, Map<String, dynamic> user, int index, bool isArchived) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!user['blocked'])
            ListTile(
              leading: Icon(user['muted'] ? Icons.notifications_off : Icons.notifications_off_outlined),
              title: Text(user['muted'] ? 'Sessizden çıkar' : 'Sessize al'),
              onTap: () {
                setState(() {
                  user['muted'] = !user['muted'];
                });
                Navigator.pop(context);
              },
            ),
          if (!user['blocked'])
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Kişi bilgisi'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePageMock(user: user)));
              },
            ),
          if (!user['blocked'])
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Sohbeti kilitle'),
              onTap: () => Navigator.pop(context),
            ),
          if (!user['blocked'])
            ListTile(
              leading: Icon(Icons.clear),
              title: Text('Sohbeti temizle'),
              onTap: () => Navigator.pop(context),
            ),
          if (!user['blocked'])
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text('Favorilere ekle'),
              onTap: () => Navigator.pop(context),
            ),
          if (!user['blocked'])
            ListTile(
              leading: Icon(Icons.list_alt_outlined),
              title: Text('Listeye ekle'),
              onTap: () => Navigator.pop(context),
            ),
          if (user['blocked'])
            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text('${user['name']} engeli kaldır', style: TextStyle(color: Colors.red)),
              onTap: () {
                setState(() {
                  user['blocked'] = false;
                });
                Navigator.pop(context);
              },
            ),
          if (!user['blocked'])
            Divider(),
          if (!user['blocked'])
            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text('${user['name']} kişisini engelle', style: TextStyle(color: Colors.red)),
              onTap: () {
                setState(() {
                  user['blocked'] = true;
                });
                Navigator.pop(context);
              },
            ),
          if (!user['deleted'])
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Sohbeti sil', style: TextStyle(color: Colors.red)),
              onTap: () {
                setState(() {
                  user['deleted'] = true;
                });
                Navigator.pop(context);
              },
            ),
          if (user['deleted'])
            ListTile(
              leading: Icon(Icons.restore, color: Colors.green),
              title: Text('Sohbeti geri al', style: TextStyle(color: Colors.green)),
              onTap: () {
                setState(() {
                  user['deleted'] = false;
                });
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }

  void _pinUser(int index) {
    setState(() {
      users[index]['pinned'] = !users[index]['pinned'];
      _sortUsers();
    });
  }

  void _markAsRead(int index) {
    setState(() {
      users[index]['unread'] = false;
      users[index]['read'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sohbet listesinde sadece aktif, engellenmemiş ve silinmemiş kullanıcılar
    final filteredUsers = users.where((user) => user['name'].toLowerCase().contains(_search.toLowerCase()) && !user['blocked'] && !user['deleted']).toList();
    final filteredArchived = archivedUsers.where((user) => user['name'].toLowerCase().contains(_search.toLowerCase()) && !user['blocked'] && !user['deleted']).toList();
    // Arama modunda tüm kullanıcılar (engelli/silinmiş dahil)
    final allSearchedUsers = users.where((user) => user['name'].toLowerCase().contains(_search.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Kullanıcı ara...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
              onChanged: (val) {
                setState(() {
                  _search = val;
                });
              },
            ),
          ),
          if (_search.isNotEmpty)
            Expanded(
              child: ListView.separated(
                itemCount: allSearchedUsers.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = allSearchedUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(user['avatar']),
                      backgroundColor: Colors.orange.shade200,
                    ),
                    title: Row(
                      children: [
                        Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                        if (user['pinned'])
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(Icons.push_pin, size: 16, color: Colors.yellow),
                          ),
                        if (user['blocked'])
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(Icons.block, size: 16, color: Colors.red),
                          ),
                        if (user['deleted'])
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(Icons.delete, size: 16, color: Colors.grey),
                          ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Text(user['lastMessage'], maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                        Icon(
                          user['read'] ? Icons.done_all : Icons.done,
                          size: 18,
                          color: user['read'] ? Colors.blue : Colors.grey,
                        ),
                      ],
                    ),
                    trailing: Text(user['lastTime'], style: TextStyle(color: Colors.black54, fontSize: 12)),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DummyChatPage(
                            userName: user['name'],
                            userAvatar: user['avatar'],
                            user: user,
                            chatHistory: chatHistory,
                            onSendMessage: (msg, time, type) {
                              setState(() {
                                chatHistory[user['name']] ??= [];
                                chatHistory[user['name']]!.add({
                                  'text': msg,
                                  'isMe': true,
                                  'time': time,
                                  'read': false,
                                  'type': type,
                                });
                                user['lastMessage'] = msg;
                                user['lastTime'] = time;
                                user['read'] = false;
                                user['deleted'] = false;
                                user['blocked'] = false;
                              });
                              _moveUserToTop(user['name'], msg, time);
                            },
                            onUnblock: () {
                              setState(() {
                                user['blocked'] = false;
                              });
                            },
                            onRestore: () {
                              setState(() {
                                user['deleted'] = false;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    onLongPress: () => _showActions(context, user, users.indexOf(user), false),
                  );
                },
              ),
            )
          else if (archivedUsers.isNotEmpty && !showArchived)
            GestureDetector(
              onTap: () => setState(() => showArchived = true),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.archive, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Arşivlenmiş (${archivedUsers.length})', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          if (!showArchived && _search.isEmpty)
            Expanded(
              child: ListView.separated(
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Slidable(
                    key: ValueKey(user['name']),
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (ctx) => _pinUser(users.indexOf(user)),
                          icon: Icons.push_pin,
                          backgroundColor: Colors.blueGrey,
                          foregroundColor: user['pinned'] ? Colors.yellow : Colors.white,
                          label: user['pinned'] ? 'Sabitlendi' : 'Basa Tuttur',
                        ),
                        SlidableAction(
                          onPressed: (ctx) => _markAsRead(users.indexOf(user)),
                          icon: Icons.mark_chat_read,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          label: 'Okundu',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (ctx) => _showActions(context, user, users.indexOf(user), false),
                          icon: Icons.more_horiz,
                          backgroundColor: Colors.grey[800]!,
                          foregroundColor: Colors.white,
                        ),
                        SlidableAction(
                          onPressed: (ctx) => _archiveUser(users.indexOf(user)),
                          icon: Icons.archive,
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            child: Text(user['avatar']),
                            backgroundColor: Colors.orange.shade200,
                          ),
                          if (user['muted'])
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Icon(Icons.notifications_off, size: 16, color: Colors.grey),
                            )
                          else
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: user['active'] ? Colors.green : Colors.grey,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Row(
                        children: [
                          Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                          if (user['pinned'])
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Icon(Icons.push_pin, size: 16, color: Colors.yellow),
                            ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(user['lastMessage'], maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                          Icon(
                            user['read'] ? Icons.done_all : Icons.done,
                            size: 18,
                            color: user['read'] ? Colors.blue : Colors.grey,
                          ),
                        ],
                      ),
                      trailing: Text(user['lastTime'], style: TextStyle(color: Colors.black54, fontSize: 12)),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DummyChatPage(
                              userName: user['name'],
                              userAvatar: user['avatar'],
                              user: user,
                              chatHistory: chatHistory,
                              onSendMessage: (msg, time, type) {
                                setState(() {
                                  chatHistory[user['name']] ??= [];
                                  chatHistory[user['name']]!.add({
                                    'text': msg,
                                    'isMe': true,
                                    'time': time,
                                    'read': false,
                                    'type': type,
                                  });
                                  user['lastMessage'] = msg;
                                  user['lastTime'] = time;
                                  user['read'] = false;
                                  user['deleted'] = false;
                                  user['blocked'] = false;
                                });
                                _moveUserToTop(user['name'], msg, time);
                              },
                              onUnblock: () {
                                setState(() {
                                  user['blocked'] = false;
                                });
                              },
                              onRestore: () {
                                setState(() {
                                  user['deleted'] = false;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          if (showArchived)
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => setState(() => showArchived = false),
                      ),
                      Text('Arşivlenmiş Sohbetler', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: filteredArchived.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final user = filteredArchived[index];
                        return Slidable(
                          key: ValueKey(user['name']),
                          endActionPane: ActionPane(
                            motion: DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (ctx) => _showActions(context, user, index, true),
                                icon: Icons.more_horiz,
                                backgroundColor: Colors.grey[800]!,
                                foregroundColor: Colors.white,
                              ),
                              SlidableAction(
                                onPressed: (ctx) => _unarchiveUser(index),
                                icon: Icons.unarchive,
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                label: 'Arşivden Çıkar',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(user['avatar']),
                              backgroundColor: Colors.orange.shade200,
                            ),
                            title: Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              children: [
                                Expanded(
                                  child: Text(user['lastMessage'], maxLines: 1, overflow: TextOverflow.ellipsis),
                                ),
                                Icon(
                                  user['read'] ? Icons.done_all : Icons.done,
                                  size: 18,
                                  color: user['read'] ? Colors.blue : Colors.grey,
                                ),
                              ],
                            ),
                            trailing: Text(user['lastTime'], style: TextStyle(color: Colors.black54, fontSize: 12)),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DummyChatPage(
                                    userName: user['name'],
                                    userAvatar: user['avatar'],
                                    user: user,
                                    chatHistory: chatHistory,
                                    onSendMessage: (msg, time, type) {
                                      setState(() {
                                        chatHistory[user['name']] ??= [];
                                        chatHistory[user['name']]!.add({
                                          'text': msg,
                                          'isMe': true,
                                          'time': time,
                                          'read': false,
                                          'type': type,
                                        });
                                        user['lastMessage'] = msg;
                                        user['lastTime'] = time;
                                        user['read'] = false;
                                        user['deleted'] = false;
                                        user['blocked'] = false;
                                      });
                                      _moveUserToTop(user['name'], msg, time);
                                    },
                                    onUnblock: () {
                                      setState(() {
                                        user['blocked'] = false;
                                      });
                                    },
                                    onRestore: () {
                                      setState(() {
                                        user['deleted'] = false;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ProfilePageMock extends StatelessWidget {
  final Map<String, dynamic> user;
  const ProfilePageMock({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['name']),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              child: Text(user['avatar'], style: TextStyle(fontSize: 32)),
              backgroundColor: Colors.orange.shade200,
            ),
            SizedBox(height: 16),
            Text(user['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(user['active'] ? 'Aktif' : 'Çevrimdışı', style: TextStyle(color: user['active'] ? Colors.green : Colors.grey)),
            SizedBox(height: 24),
            Text('Profil ekranı (örnek)'),
          ],
        ),
      ),
    );
  }
}

class DummyChatPage extends StatefulWidget {
  final String userName;
  final String userAvatar;
  final Map<String, dynamic> user;
  final Map<String, List<Map<String, dynamic>>> chatHistory;
  final void Function(String lastMessage, String lastTime, String type)? onSendMessage;
  final VoidCallback? onUnblock;
  final VoidCallback? onRestore;
  const DummyChatPage({required this.userName, required this.userAvatar, required this.user, required this.chatHistory, this.onSendMessage, this.onUnblock, this.onRestore});

  @override
  _DummyChatPageState createState() => _DummyChatPageState();
}

class _DummyChatPageState extends State<DummyChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage({String type = 'text', String? filePath}) {
    if (type == 'text' && _controller.text.trim().isEmpty) return;
    final msg = type == 'text' ? _controller.text.trim() : filePath ?? '';
    widget.onSendMessage?.call(msg, TimeOfDay.now().format(context), type);
    setState(() {
      widget.chatHistory[widget.userName] ??= [];
      widget.chatHistory[widget.userName]!.add({
        'text': msg,
        'isMe': true,
        'time': TimeOfDay.now().format(context),
        'read': false,
        'type': type,
      });
    });
    _controller.clear();
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showFilePicker() async {
    // Şimdilik sadece sahte dosya ekleme
    // Gerçek dosya seçimi için image_picker veya benzeri paket eklenebilir
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Kameradan çek'),
            onTap: () {
              Navigator.pop(context);
              _sendMessage(type: 'image', filePath: '[Kamera ile çekilen fotoğraf]');
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Galeriden yükle'),
            onTap: () {
              Navigator.pop(context);
              _sendMessage(type: 'image', filePath: '[Galeriden seçilen fotoğraf]');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.chatHistory[widget.userName] ?? [];
    final isBlocked = widget.user['blocked'] == true;
    final isDeleted = widget.user['deleted'] == true;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(widget.userAvatar),
              backgroundColor: Colors.orange.shade200,
            ),
            SizedBox(width: 10),
            Text(widget.userName),
          ],
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          if (isBlocked || isDeleted)
            Container(
              color: Colors.red.shade100,
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      isBlocked
                          ? 'Bu kişi engellenmiş. Sohbeti devam ettirmek için engeli kaldır.'
                          : 'Bu sohbet silinmiş. Sohbeti devam ettirmek için geri al.',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (isBlocked && widget.onUnblock != null)
                    TextButton(
                      onPressed: widget.onUnblock,
                      child: Text('Engeli Kaldır'),
                    ),
                  if (isDeleted && widget.onRestore != null)
                    TextButton(
                      onPressed: widget.onRestore,
                      child: Text('Geri Al'),
                    ),
                ],
              ),
            ),
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      'Henüz mesaj yok',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return Row(
                        mainAxisAlignment: msg['isMe'] ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!msg['isMe'])
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: CircleAvatar(
                                radius: 16,
                                child: Text(widget.userAvatar),
                                backgroundColor: Colors.orange.shade200,
                              ),
                            ),
                          Flexible(
                            child: Align(
                              alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: msg['isMe'] ? Colors.orange.shade100 : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: msg['type'] == 'image'
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.image, color: Colors.orange),
                                          SizedBox(width: 8),
                                          Text(msg['text'], style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment: msg['isMe'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                        children: [
                                          Text(msg['text'], style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(msg['time'], style: TextStyle(fontSize: 10, color: Colors.black54)),
                                              if (msg['isMe'])
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4),
                                                  child: Icon(
                                                    msg['read'] ? Icons.done_all : Icons.done,
                                                    size: 16,
                                                    color: msg['read'] ? Colors.blue : Colors.grey,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          if (msg['isMe'])
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: CircleAvatar(
                                radius: 16,
                                child: Text('S'),
                                backgroundColor: Colors.orange.shade100,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
          ),
          Divider(height: 1),
          if (!(isBlocked || isDeleted))
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.orange),
                    onPressed: _showFilePicker,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Mesaj yaz...'
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.orange),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
} 