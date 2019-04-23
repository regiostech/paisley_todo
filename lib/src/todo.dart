import 'package:angel_serialize/angel_serialize.dart';
part 'todo.g.dart';

@serializable
abstract class _Todo {
  @notNull
  String get text;

  @DefaultsTo(false)
  bool get isComplete;
}
