import 'package:flutter/material.dart';
import 'package:simplechat/src/constants/supabase_tables/tables.dart';
import 'package:simplechat/src/controllers/message_controller.dart';
import 'package:simplechat/src/models/message_model.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final _controllerMessageText = TextEditingController();
  final _messageController = MessageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Chat'),
      ),

      //Body
      body: StreamBuilder(
        stream: _messageController.get(Tables.messages),
        builder: (context, snapshot) {
          return ListView.separated(
            reverse: false,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final messagemModel =
                  MessageModel.fromMap(snapshot.data?[index] ?? {});

              return Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                child: Align(
                  alignment: messagemModel.type != "sent"
                      ? FractionalOffset.centerLeft
                      : FractionalOffset.centerRight,
                  child: Card(
                    color: Theme.of(context).primaryColorLight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(messagemModel.message ?? "Não há dados"),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controllerMessageText,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: IconButton(
                  onPressed: () async {
                    await _messageController.insert(
                      Tables.messages,
                      {
                        "message": _controllerMessageText.text,
                      },
                    ).then((value) => _controllerMessageText.text = "");
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
