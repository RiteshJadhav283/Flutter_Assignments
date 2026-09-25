import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../models/application_model.dart';
import '../theme/app_theme.dart';
import 'application_form_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobModel job;
  final bool isSaved;
  final bool hasApplied;
  final VoidCallback onToggleSave;
  final Function(ApplicationModel) onSubmitApplication;

  const JobDetailsScreen({
    super.key,
    required this.job,
    required this.isSaved,
    required this.hasApplied,
    required this.onToggleSave,
    required this.onSubmitApplication,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late bool _isSaved;
  late bool _hasApplied;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isSaved;
    _hasApplied = widget.hasApplied;
  }

  void _handleToggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    widget.onToggleSave();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSaved ? 'Job saved to your bookmarks!' : 'Removed from Saved Jobs',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Job Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: _isSaved ? AppColors.primary : AppColors.slate500,
            ),
            onPressed: _handleToggleSave,
            tooltip: _isSaved ? 'Remove from Saved' : 'Save Job',
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.slate500),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Job link for ${job.title} copied to clipboard!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company & Job Top Card
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        job.logoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              job.company.isNotEmpty ? job.company[0].toUpperCase() : 'J',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    job.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    job.company,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: AppColors.slate500),
                      const SizedBox(width: 4),
                      Text(job.location, style: const TextStyle(fontSize: 13, color: AppColors.slate500)),
                      const SizedBox(width: 14),
                      const Icon(Icons.star_rounded, size: 16, color: AppColors.rating),
                      const SizedBox(width: 4),
                      Text(
                        '${job.rating}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.slate700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Meta badges
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildChip(job.type, Icons.work_outline_rounded, AppColors.slate100, AppColors.slate800),
                      _buildChip(job.experience, Icons.timeline_rounded, AppColors.slate100, AppColors.slate800),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.border),
            const SizedBox(height: 14),

            // Key Highlights Row (Card grid)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      'Salary Package',
                      job.salary,
                      Icons.account_balance_wallet_outlined,
                      AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoCard(
                      'Posting Date',
                      job.postedDate,
                      Icons.calendar_today_outlined,
                      AppColors.slate600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Description Section
            _buildSection(
              title: 'Job Overview',
              icon: Icons.description_outlined,
              content: Text(
                job.description,
                style: const TextStyle(fontSize: 14, height: 1.6, color: AppColors.slate700),
              ),
            ),

            // Responsibilities Section
            _buildSection(
              title: 'Key Responsibilities',
              icon: Icons.checklist_rounded,
              content: Column(
                children: job.responsibilities.map((item) => _buildBulletItem(item)).toList(),
              ),
            ),

            // Requirements Section
            _buildSection(
              title: 'Candidate Requirements',
              icon: Icons.verified_user_outlined,
              content: Column(
                children: job.requirements.map((item) => _buildBulletItem(item)).toList(),
              ),
            ),

            // Benefits & Perks Section
            _buildSection(
              title: 'Benefits & Perks',
              icon: Icons.card_giftcard_rounded,
              content: Column(
                children: job.benefits.map((item) => _buildBulletItem(item, isPerk: true)).toList(),
              ),
            ),

            const SizedBox(height: 90), // Padding for sticky bottom button
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Bookmark Button
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(
                    _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    color: _isSaved ? AppColors.primary : AppColors.slate500,
                  ),
                  onPressed: _handleToggleSave,
                ),
              ),
              const SizedBox(width: 12),
              // Apply Button (ElevatedButton)
              Expanded(
                child: ElevatedButton(
                  onPressed: _hasApplied
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ApplicationFormScreen(
                                job: job,
                                onSubmitApplication: (app) {
                                  setState(() {
                                    _hasApplied = true;
                                  });
                                  widget.onSubmitApplication(app);
                                },
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.slate200,
                    foregroundColor: Colors.white,
                    disabledForegroundColor: AppColors.slate500,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _hasApplied ? Icons.check_circle_rounded : Icons.assignment_turned_in_rounded,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _hasApplied ? 'Already Applied' : 'Apply For This Position',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: fg),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: AppColors.slate500, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.slate900),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text, {bool isPerk = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isPerk ? Icons.star_rounded : Icons.check_circle_rounded,
            size: 18,
            color: isPerk ? AppColors.rating : AppColors.success,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.slate700),
            ),
          ),
        ],
      ),
    );
  }
}
