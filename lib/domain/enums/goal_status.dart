/// Representa o estado de uma meta em relação ao seu progresso.
enum GoalStatus {

  /// Representa o estado em que não há uma meta definida.
  noGoal,

  /// Representa o estado em que a meta está em progresso.
  inProgress,

  /// Representa o estado em que a meta foi concluída.
  completed,

  /// Representa o estado em que a meta foi excedida.
  exceeded,
}