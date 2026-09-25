import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../models/application_model.dart';
import '../theme/app_theme.dart';
import '../widgets/job_card.dart';
import 'job_details_screen.dart';

class SavedJobsScreen extends StatefulWidget {
  final List<JobModel> allJobs;
  final Set<String> savedJobIds;
  final List<ApplicationModel> applications;
  final Function(String) onToggleSave;
  final Function(ApplicationModel) onSubmitApplication;
  final VoidCallback onExploreJobs;

  const SavedJobsScreen({
    super.key,
    required this.allJobs,
    required this.savedJobIds,
    required this.applications,
    required this.onToggleSave,
    required this.onSubmitApplication,
    required this.onExploreJobs,
  });

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final savedJobs = widget.allJobs.where((job) => widget.savedJobIds.contains(job.id)).toList();
    final appliedJobIds = widget.applications.map((app) => app.jobId).toSet();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Activity'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.slate500,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: -0.2),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bookmark_rounded, size: 17),
                      const SizedBox(width: 8),
                      Text('Saved (${savedJobs.length})'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.send_rounded, size: 17),
                      const SizedBox(width: 8),
                      Text('Applied (${widget.applications.length})'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Saved Jobs
          savedJobs.isEmpty
              ? _buildEmptyState(
                  icon: Icons.bookmark_border_rounded,
                  title: 'No saved jobs yet',
                  subtitle: 'Save jobs by tapping the bookmark icon on any job card to review them here later.',
                  buttonLabel: 'Explore Open Roles',
                  onAction: widget.onExploreJobs,
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: savedJobs.length,
                  itemBuilder: (context, index) {
                    final job = savedJobs[index];
                    return JobCard(
                      job: job,
                      isSaved: true,
                      onToggleSave: () => widget.onToggleSave(job.id),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JobDetailsScreen(
                              job: job,
                              isSaved: true,
                              hasApplied: appliedJobIds.contains(job.id),
                              onToggleSave: () => widget.onToggleSave(job.id),
                              onSubmitApplication: widget.onSubmitApplication,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

          // Tab 2: Applied Jobs
          widget.applications.isEmpty
              ? _buildEmptyState(
                  icon: Icons.assignment_outlined,
                  title: 'No applications submitted',
                  subtitle: 'When you submit a job application form, your recorded submission status will appear here.',
                  buttonLabel: 'Find Jobs to Apply',
                  onAction: widget.onExploreJobs,
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  itemCount: widget.applications.length,
                  itemBuilder: (context, index) {
                    final app = widget.applications[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.slate950.withOpacity(0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    app.jobTitle,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.slate900,
                                      letterSpacing: -0.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.successLight,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    app.status,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              app.companyName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.person_outline_rounded, size: 15, color: AppColors.slate500),
                                const SizedBox(width: 4),
                                Text(
                                  app.candidateName,
                                  style: const TextStyle(fontSize: 12, color: AppColors.slate600, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 14),
                                const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.slate500),
                                const SizedBox(width: 4),
                                Text(
                                  '${app.appliedAt.day}/${app.appliedAt.month}/${app.appliedAt.year}',
                                  style: const TextStyle(fontSize: 12, color: AppColors.slate600, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const Divider(height: 24, thickness: 1, color: AppColors.borderSubtle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Notice: ${app.noticePeriod}',
                                  style: const TextStyle(fontSize: 12, color: AppColors.slate500, fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        title: Text(
                                          'Application Details: ${app.jobTitle}',
                                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _buildDialogDetail('Applicant', app.candidateName),
                                              _buildDialogDetail('Company', app.companyName),
                                              _buildDialogDetail('Email', app.email),
                                              _buildDialogDetail('Phone', app.phone),
                                              _buildDialogDetail('Experience', app.experienceLevel),
                                              _buildDialogDetail('Qualification', app.qualification),
                                              _buildDialogDetail('Notice Period', app.noticePeriod),
                                              _buildDialogDetail('Remote Open', app.openToRemote ? 'Yes' : 'No'),
                                              if (app.selectedSkills.isNotEmpty)
                                                _buildDialogDetail('Skills', app.selectedSkills.join(', ')),
                                              if (app.coverNote.isNotEmpty) ...[
                                                const SizedBox(height: 8),
                                                const Text(
                                                  'Pitch / Cover Note:',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(app.coverNote, style: const TextStyle(fontSize: 12)),
                                              ],
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(ctx).pop(),
                                            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                                            child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                                  child: const Text(
                                    'View Submission',
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: AppColors.primary),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.slate900,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: AppColors.slate500, height: 1.5),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.slate500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: AppColors.slate900, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
