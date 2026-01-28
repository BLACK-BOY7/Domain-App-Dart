import '../enums/goal_status.dart';

/// Classe responsável por calcular o status de uma meta com base no valor desejado e no valor atual.
class GoalCalculator {

  /// Retorna o status da meta com base no valor desejado e no valor atual.
  /// Parâmetros:
  /// - [desired]: O valor desejado da meta.
  /// - [current]: O valor atual alcançado.
  /// Retorna:
  /// - [GoalStatus]: O status da meta (sem meta, em progresso, concluída, excedida).
  static GoalStatus getStatus(int desired, int current) {
    if (desired <= 0) {
        return GoalStatus.noGoal;
    }

    if (current < desired) {
        return GoalStatus.inProgress;
    }

    if (current == desired) {
        return GoalStatus.completed;
    }

    return GoalStatus.exceeded;
  }  
}