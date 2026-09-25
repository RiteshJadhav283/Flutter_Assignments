class ApplicationModel {
  final String id;
  final String jobId;
  final String jobTitle;
  final String companyName;
  final String candidateName;
  final String email;
  final String phone;
  final String experienceLevel;
  final String qualification;
  final String noticePeriod;
  final List<String> selectedSkills;
  final bool openToRemote;
  final bool willingToRelocate;
  final String coverNote;
  final DateTime appliedAt;
  final String status;

  const ApplicationModel({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.candidateName,
    required this.email,
    required this.phone,
    required this.experienceLevel,
    required this.qualification,
    required this.noticePeriod,
    required this.selectedSkills,
    required this.openToRemote,
    required this.willingToRelocate,
    required this.coverNote,
    required this.appliedAt,
    this.status = 'Submitted',
  });
}
