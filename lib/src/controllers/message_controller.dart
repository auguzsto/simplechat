import 'package:simplechat/src/supabase/supabase_simplechat.dart';

abstract class IMessage {
  Stream<List<Map<String, dynamic>>> get(String from);
  Future<void> insert(String from, Map<String, dynamic> data);
  Future<void> update(String from);
  Future<void> delete(String from);
}

class MessageController implements IMessage {
  MessageController();

  @override
  Stream<List<Map<String, dynamic>>> get(String from) {
    return supabase.from(from).stream(primaryKey: ['uuid']);
  }

  @override
  Future<void> insert(String from, Map<String, dynamic> data) async {
    await supabase.from(from).insert(data);
  }

  @override
  Future<void> update(String from) async {}

  @override
  Future<void> delete(String from) async {}
}
