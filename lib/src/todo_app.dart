import 'dart:convert';
import 'package:paisley/paisley.dart';
import 'todo.dart';

class TodoApp extends Component {
  var todos = <Todo>[];
  PaisleyServer _server;

  @override
  void afterCreate([PaisleyServer server, Map<String, String> localStorage]) {
    _server = server;
    listen('delete', (s) => _deleteTodo(s.toString()));
    listen('new', (s) => _addTodo(s.toString()));
    listen('toggle', (s) => _toggleTodo(s.toString()));

    if (server != null) {
      if (localStorage.containsKey('todos')) {
        var todoObj =
            (json.decode(localStorage['todos']) as Iterable)?.cast<Map>() ?? [];
        todos.addAll(todoObj.map(todoSerializer.decode));
        _sortTodos();
      }
    }
  }

  void _sortTodos() {
    if (todos.length > 1) {
      todos.sort((a, b) {
        var aa = a.isComplete ? 1 : 0;
        var bb = b.isComplete ? 1 : 0;
        return aa.compareTo(bb);
      });
    }
  }

  void _rerender() {
    _sortTodos();
    _server
      ..localStorage?.setItem('todos', todos)
      ..pushHtml('#todoCount', todos.length.toString())
      ..pushHtml('#todoList', todos.map(_renderTodo).join());
  }

  void _addTodo(String text) {
    if (text.isNotEmpty) {
      todos.add(Todo(text: text));
      _rerender();
    }
  }

  void _deleteTodo(String text) {
    todos.removeWhere((t) => t.text == text);
    _rerender();
  }

  void _toggleTodo(String text) {
    for (int i = 0; i < todos.length; i++) {
      var todo = todos[i];
      if (todos[i].text == text) {
        todos[i] = todos[i].copyWith(isComplete: !todo.isComplete);
      }
    }

    _rerender();
  }

  String _renderTodo(Todo todo) {
    return '''
    <li class="${todo.isComplete ? 'is-complete' : ''}">
      <span onclick="fire('toggle', '${todo.text}')">
        ${todo.text}
      </span>
      &nbsp;
      <button onclick="window.confirm('Really delete ${todo.text}? This cannot be undone.') && fire('delete', '${todo.text}')">
        Delete
      </button>
    </li>
    ''';
  }

  @override
  String render() {
    return '''
    <h1>Todos (<span id="todoCount">${todos.length}</span>)</h1>
    <form onsubmit="return submitTodo(event)">
      <input placeholder="Add a todo..." name="text" type="text">
      <button>Add Todo</button>
    </form>
    <i>Click a todo item to mark it complete.</i>
    <ul id='todoList'>
      ${todos.map(_renderTodo).join()}
    </ul>
    <script>
      function submitTodo(e) {
        e.preventDefault();
        var formData = new FormData(e.target);
        fire('new', formData.get('text'));
        e.target.querySelector('input').value = '';
        return false;
      }
    </script>
    ''';
  }
}
