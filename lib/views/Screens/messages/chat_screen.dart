// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:hotelonwer/controller/msgbloc/bloc/scoketmsg_bloc.dart';
import 'package:hotelonwer/model/mesage_model.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

class ChatScreen extends StatefulWidget {
  final String senderEmail;
  final String receiverId;
  final String hotelname;
  final String userid;

  ChatScreen({
    required this.senderEmail,
    required this.receiverId,
    required this.hotelname,
    required this.userid,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late Future<String> _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = _getUserId();
  }

  Future<String> _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-authenticated',
        message: 'User not authenticated',
      );
    }
    return user.uid;
  }

  void _sendMessage(BuildContext context) {
    if (_messageController.text.trim().isNotEmpty) {
      Replymesge message = Replymesge(
        message: _messageController.text.trim(),
        timestamp: Timestamp.now(),
        hotelname: widget.hotelname,
        receiverId: widget.receiverId,
        email: widget.senderEmail,
        userid: widget.userid,
      );
      context
          .read<ScoketmsgBloc>()
          .add(SendMessageEvent(message: message, userId: widget.userid));
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mycolor4),
        centerTitle: true,
        backgroundColor: greycolor,
        title: Text(
          widget.hotelname,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: mycolor4,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, Constraints) {
        double maxWidth1 =
            Constraints.maxWidth > 600 ? 600 : Constraints.maxWidth;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth1),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'lib/Asset/543de8a1f2887da54f7b7de6772f6aa2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BlocBuilder<ScoketmsgBloc, ScoketmsgState>(
                        builder: (context, state) {
                          if (state is SendMessageFailureState ||
                              state is ReceiveMessageFailureState) {
                            return Center(
                              child: Text(
                                'Failed to send/receive message: ${(state as dynamic).error}',
                                style: TextStyle(color: mycolor4),
                              ),
                            );
                          } else {
                            return FutureBuilder<String>(
                              future: _currentUserId,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text('User not authenticated',
                                        style: TextStyle(color: mycolor4)),
                                  );
                                }

                                return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('userSide')
                                      .doc(widget.userid)
                                      .collection('messeges')
                                      .orderBy('timestamp', descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'No messages yet',
                                          style: TextStyle(color: mycolor4),
                                        ),
                                      );
                                    }

                                    List<DocumentSnapshot> docs =
                                        snapshot.data!.docs;

                                    // Group messages by date and reverse the list for each date
                                    Map<DateTime, List<DocumentSnapshot>>
                                        groupedMessages =
                                        _groupMessagesByDate(docs);

                                    // Create a sorted list of dates
                                    List<DateTime> sortedDates =
                                        groupedMessages.keys.toList()
                                          ..sort((a, b) => b.compareTo(a));

                                    return ListView.builder(
                                      controller: _scrollController,
                                      reverse: true,
                                      itemCount: sortedDates.length,
                                      itemBuilder: (context, dateIndex) {
                                        DateTime date = sortedDates[dateIndex];
                                        List<DocumentSnapshot> messages =
                                            groupedMessages[date]!;

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            _buildDateHeader(date),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: messages.length,
                                              itemBuilder:
                                                  (context, messageIndex) {
                                                Map<String, dynamic> data =
                                                    messages[messageIndex]
                                                            .data()
                                                        as Map<String, dynamic>;
                                                if (data['Hotelname'] ==
                                                    widget.hotelname) {
                                                  if (data.containsKey(
                                                          'Replymessage') &&
                                                      data['Replymessage'] !=
                                                          null &&
                                                      (data['Replymessage']
                                                              as String)
                                                          .isNotEmpty) {
                                                    return _buildMessageWithReply(
                                                        data);
                                                  } else {
                                                    return _buildRegularMessage(
                                                        data);
                                                  }
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLines: null,
                              minLines: 1,
                              controller: _messageController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 20.0,
                                ),
                                hintText: 'Type a message...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: mycolor8,
                                  ),
                                ),
                                filled: true,
                                fillColor: mycolor4,
                              ),
                              onFieldSubmitted: (value) =>
                                  _sendMessage(context),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            decoration: BoxDecoration(
                              color: greycolor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.send, color: mycolor4),
                              onPressed: () => _sendMessage(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        _isToday(date) ? 'Today' : DateFormat('MMM d, yyyy').format(date),
        style: TextStyle(
          fontSize: 12.0,
          color: mycolor4,
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Widget _buildMessageWithReply(Map<String, dynamic> data) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 90),
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: redcolorforchat,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    '${data['Replymessage'] ?? ''}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: mycolor4,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatTimestamp(data['Replytime']),
                      style: TextStyle(
                        fontSize: 8.0,
                        color: mycolor4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegularMessage(Map<String, dynamic> data) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 90),
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: greycolor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    '${data['message'] ?? ''}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: mycolor4,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatTimestamp(data['timestamp']),
                      style: TextStyle(
                        fontSize: 8.0,
                        color: mycolor4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  Map<DateTime, List<DocumentSnapshot>> _groupMessagesByDate(
      List<DocumentSnapshot> messages) {
    Map<DateTime, List<DocumentSnapshot>> groupedMessages = {};

    messages.forEach((message) {
      DateTime date = (message['timestamp'] as Timestamp).toDate();
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);

      if (groupedMessages.containsKey(normalizedDate)) {
        groupedMessages[normalizedDate]!.add(message);
      } else {
        groupedMessages[normalizedDate] = [message];
      }
    });

    // Reverse the order of messages for each date
    groupedMessages.forEach((key, value) {
      value = value.reversed.toList();
      groupedMessages[key] = value;
    });

    return groupedMessages;
  }
}
