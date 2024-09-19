import 'package:jobchat/models/message.dart';

class chatPeople {
  Set<String> uniqueID = {};
  List<message> messages = [];

  chatPeople(Set<String> ids, List<message> msgs) {
    uniqueID = ids;
    messages = msgs;
  }
}
