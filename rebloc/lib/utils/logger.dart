import 'package:logging/logging.dart';

final Logger log = new Logger('BetterYunar')
  ..onRecord.listen((LogRecord rec) {
    print('BetterYunarLog ${rec.level.name}: ${rec.message}');
  });

void logObject(String msg, Object o) {
  log.info(msg);
  for (String line in o.toString().split('\n')) {
    log.info('-- $line');
  }
}