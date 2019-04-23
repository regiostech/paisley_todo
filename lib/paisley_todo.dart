import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:paisley/paisley.dart';
import 'package:paisley/server.dart';
import 'src/todo_app.dart';

Future<void> configureServer(Angel app) async {
  app.get('/paisley', paisley((req, res) => TodoApp()));
  app.get('/', paisleySsr((req, res) {
    return PaisleyApp(
      'ws://localhost:3000/paisley',
      TodoApp(),
      head: '''
      <title>Paisley Todo</title>
      <style>
        li.is-complete span {
          text-decoration: line-through;
        }
      </style>
      ''',
    );
  }));
  app.fallback((req, res) => throw AngelHttpException.notFound());
}
