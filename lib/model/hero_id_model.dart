import 'package:meta/meta.dart';

class HeroId {
  final String progressId;
  final String titleId;
  final String codePointId;
  final String remainingTaskId;

  HeroId({
    @required this.progressId,
    @required this.titleId,
    @required this.codePointId,
    @required this.remainingTaskId,
  });
}
