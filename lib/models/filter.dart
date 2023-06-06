class FilterClass {
  final DateTime? duoDate;
  final bool? justCompleted;
  FilterClass({
    this.duoDate,
    this.justCompleted,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterClass &&
        other.duoDate == duoDate &&
        other.justCompleted == justCompleted;
  }

  @override
  int get hashCode => duoDate.hashCode ^ justCompleted.hashCode;

  FilterClass copyWith({
    DateTime? doDate,
    bool? justCompleted,
  }) {
    return FilterClass(
      duoDate: doDate ?? duoDate,
      justCompleted: justCompleted ?? this.justCompleted,
    );
  }

  @override
  String toString() =>
      'FilterClass(duoDate: $duoDate, justCompleted: $justCompleted)';
}
