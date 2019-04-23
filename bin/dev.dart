import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:logging/logging.dart';
import 'package:paisley_todo/paisley_todo.dart' as paisley_todo;

main() async {
  var hot = HotReloader(() async {
    hierarchicalLoggingEnabled = true;
    var logger = Logger.detached('paisley_todo')..onRecord.listen(print);
    var app = Angel(logger: logger, reflector: MirrorsReflector());
    await app.configure(paisley_todo.configureServer);
    return app;
  }, ['lib']);
  await hot.startServer('127.0.0.1', 3000);
  print('Listening at http://localhost:3000');
}
