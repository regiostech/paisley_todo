// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Todo implements _Todo {
  const Todo({@required this.text, this.isComplete = false});

  @override
  final String text;

  @override
  final bool isComplete;

  Todo copyWith({String text, bool isComplete}) {
    return new Todo(
        text: text ?? this.text, isComplete: isComplete ?? this.isComplete);
  }

  bool operator ==(other) {
    return other is _Todo &&
        other.text == text &&
        other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return hashObjects([text, isComplete]);
  }

  @override
  String toString() {
    return "Todo(text=$text, isComplete=$isComplete)";
  }

  Map<String, dynamic> toJson() {
    return TodoSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

const TodoSerializer todoSerializer = const TodoSerializer();

class TodoEncoder extends Converter<Todo, Map> {
  const TodoEncoder();

  @override
  Map convert(Todo model) => TodoSerializer.toMap(model);
}

class TodoDecoder extends Converter<Map, Todo> {
  const TodoDecoder();

  @override
  Todo convert(Map map) => TodoSerializer.fromMap(map);
}

class TodoSerializer extends Codec<Todo, Map> {
  const TodoSerializer();

  @override
  get encoder => const TodoEncoder();
  @override
  get decoder => const TodoDecoder();
  static Todo fromMap(Map map) {
    if (map['text'] == null) {
      throw new FormatException("Missing required field 'text' on Todo.");
    }

    return new Todo(
        text: map['text'] as String,
        isComplete: map['is_complete'] as bool ?? false);
  }

  static Map<String, dynamic> toMap(_Todo model) {
    if (model == null) {
      return null;
    }
    if (model.text == null) {
      throw new FormatException("Missing required field 'text' on Todo.");
    }

    return {'text': model.text, 'is_complete': model.isComplete};
  }
}

abstract class TodoFields {
  static const List<String> allFields = <String>[text, isComplete];

  static const String text = 'text';

  static const String isComplete = 'is_complete';
}
