class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String category;
  final String salary;
  final String type; // Full-time, Remote, Part-time, Contract, Internship
  final String experience;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> benefits;
  final String logoUrl;
  final String postedDate;
  final bool isFeatured;
  final bool isUrgent;
  final double rating;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.category,
    required this.salary,
    required this.type,
    required this.experience,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.benefits,
    required this.logoUrl,
    required this.postedDate,
    this.isFeatured = false,
    this.isUrgent = false,
    this.rating = 4.5,
  });
}
