// ignore_for_file: unused_element, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_bloc.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_event.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_state.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:hotelonwer/views/Screens/messages/chat_screen.dart';
import 'package:intl/intl.dart';

class Messegepage extends StatefulWidget {
  const Messegepage({Key? key}) : super(key: key);

  @override
  _MessegepageState createState() => _MessegepageState();
}

class _MessegepageState extends State<Messegepage> {
  @override
  void initState() {
    super.initState();

    context.read<FetchMsgsBloc>().add(fetchmessages());
  }

  Future<void> _refreshMessages() async {
    context.read<FetchMsgsBloc>().add(fetchmessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Mycolor1,
        title: Text(
          'Customer Messaging',
          style: TextStyle(
            color: mycolor5,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: mycolor4,
      body: RefreshIndicator(
        onRefresh: _refreshMessages,
        child: BlocConsumer<FetchMsgsBloc, FetchMsgsState>(
          listener: (context, state) {
            if (state is MessagesLoading) {}
          },
          builder: (context, state) {
            if (state is MessagesLoaded) {
              return ListView.builder(
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  var message = state.messages[index];
                  String hotelid = message['userId']!;
                  String senderEmail = message['senderEmail'];
                  String hotelnmae = message['Hotelname'];
                  String senderName = _extractUsername(senderEmail);
                  dynamic datetime = message['timestamp'];

                  Color color = Colors.primaries[
                      senderEmail.hashCode % Colors.primaries.length];

                  return InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                senderEmail: senderEmail,
                                receiverId: message['reciverId'],
                                hotelname: hotelnmae,
                                userid: hotelid,
                              )));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              backgroundColor: color,
                              child: Text(
                                senderName[0].toUpperCase(),
                                style: TextStyle(
                                  color: mycolor4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            senderName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hotelnmae),
                              Text(
                                hotelid,
                                style: TextStyle(fontSize: 0),
                              )
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_formatTimestamp(datetime)),
                              Text(_formatDate(datetime))
                            ],
                          ),
                        ),
                        Divider(), // Optional: Add a divider between messages
                      ],
                    ),
                  );
                },
              );
            } else if (state is MessagesError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'lib/Asset/Screenshot 2024-06-29 142420.png',
                      width: 200,
                    ),
                  ),
                  Text('No messages or enquiries received yet')
                ],
              );
            } else if (state is MessagesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  String _extractUsername(String email) {
    String username = email.split('@').first;
    username = username.replaceAll(RegExp(r'[0-9]'), '');
    username = username[0].toUpperCase() + username.substring(1);
    return username;
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  String _formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('d-MMM-y').format(dateTime);
  }
}
