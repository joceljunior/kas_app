class StudentRegister {
  final String studentId;
  final String? justification;
  final bool participation;

  StudentRegister({
    required this.studentId,
    this.justification,
    required this.participation,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'justification': justification,
      'participation': participation,
    };
  }

  factory StudentRegister.fromMap(Map<String, dynamic> map) {
    return StudentRegister(
      studentId: map['studentId'],
      justification: map['justification'],
      participation: map['participation'],
    );
  }
}
