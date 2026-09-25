import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../models/application_model.dart';
import '../theme/app_theme.dart';

class ApplicationFormScreen extends StatefulWidget {
  final JobModel job;
  final Function(ApplicationModel) onSubmitApplication;

  const ApplicationFormScreen({
    super.key,
    required this.job,
    required this.onSubmitApplication,
  });

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _portfolioController = TextEditingController();
  final TextEditingController _coverLetterController = TextEditingController();

  // Dropdown values
  String _selectedExperience = '1-3 Years';
  final List<String> _experienceOptions = [
    'Fresher / Entry Level',
    '1-3 Years',
    '3-5 Years',
    '5+ Years',
  ];

  String _selectedQualification = "Bachelor's Degree";
  final List<String> _qualificationOptions = [
    "Bachelor's Degree",
    "Master's Degree",
    "Diploma / Certification",
    "Doctorate / PhD",
    "High School / Other",
  ];

  // Radio button value (Notice period / Availability)
  String _noticePeriod = 'Immediate Joiner';
  final List<String> _noticeOptions = [
    'Immediate Joiner',
    '15 Days Notice',
    '1 Month Notice',
    '2+ Months Notice',
  ];

  // Checkboxes
  bool _agreedToTerms = false;
  final Map<String, bool> _skillsChecklist = {
    'Core Problem Solving': true,
    'Team Collaboration': true,
    'Domain Knowledge': false,
    'Version Control (Git)': false,
  };

  // Switches
  bool _openToRemote = true;
  bool _receiveEmailAlerts = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _portfolioController.dispose();
    _coverLetterController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the highlighted errors before submitting.'),
          backgroundColor: AppColors.urgent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must agree to the terms and privacy policy.'),
          backgroundColor: AppColors.urgent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final selectedSkillsList = _skillsChecklist.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final application = ApplicationModel(
      id: 'app_${DateTime.now().millisecondsSinceEpoch}',
      jobId: widget.job.id,
      jobTitle: widget.job.title,
      companyName: widget.job.company,
      candidateName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      experienceLevel: _selectedExperience,
      qualification: _selectedQualification,
      noticePeriod: _noticePeriod,
      selectedSkills: selectedSkillsList,
      openToRemote: _openToRemote,
      willingToRelocate: false,
      coverNote: _coverLetterController.text.trim(),
      appliedAt: DateTime.now(),
    );

    widget.onSubmitApplication(application);

    // Show confirmation AlertDialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Application Sent!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.slate900),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your application for ${widget.job.title} at ${widget.job.company} has been recorded locally.',
                style: const TextStyle(fontSize: 13, color: AppColors.slate600),
              ),
              const Divider(height: 24, thickness: 1, color: AppColors.borderSubtle),
              _buildSummaryRow('Candidate', application.candidateName),
              _buildSummaryRow('Email', application.email),
              _buildSummaryRow('Phone', application.phone),
              _buildSummaryRow('Experience', application.experienceLevel),
              _buildSummaryRow('Education', application.qualification),
              _buildSummaryRow('Availability', application.noticePeriod),
              _buildSummaryRow('Remote Work', application.openToRemote ? 'Yes' : 'No'),
              if (selectedSkillsList.isNotEmpty)
                _buildSummaryRow('Skills', selectedSkillsList.join(', ')),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
              Navigator.of(context).pop(); // Return to previous screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Applied for ${widget.job.title} successfully!'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Done & View Jobs', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.slate500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.slate900),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Job Application Form'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job summary card
              Container(
                padding: const EdgeInsets.all(16),
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
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.business_rounded, color: AppColors.primary, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.job.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.slate900,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${widget.job.company} • ${widget.job.location}',
                            style: const TextStyle(fontSize: 13, color: AppColors.slate600, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section: Personal Details
              _buildSectionHeader('1. Personal Details', Icons.person_outline_rounded),
              const SizedBox(height: 12),

              // TextFormField: Full Name
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Full Name *', 'e.g. Ritesh Jadhav', Icons.person_rounded),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (val.trim().length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // TextFormField: Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Email Address *', 'e.g. applicant@domain.com', Icons.email_outlined),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your email address';
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(val.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // TextFormField: Phone Number
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Phone Number *', 'e.g. 9876543210', Icons.phone_outlined),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (val.trim().length < 10) {
                    return 'Phone number must be at least 10 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // TextFormField: Portfolio / LinkedIn
              TextFormField(
                controller: _portfolioController,
                decoration: _inputDecoration('Portfolio / LinkedIn URL', 'https://linkedin.com/in/... or github.com/...', Icons.link_rounded),
              ),
              const SizedBox(height: 24),

              // Section: Professional Qualifications (DropdownButton)
              _buildSectionHeader('2. Experience & Education', Icons.school_outlined),
              const SizedBox(height: 12),

              // DropdownButton: Experience Level
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.business_center_outlined, color: AppColors.slate500, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Experience Level',
                            style: TextStyle(fontSize: 11, color: AppColors.slate500, fontWeight: FontWeight.w600),
                          ),
                          DropdownButton<String>(
                            value: _selectedExperience,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.slate600),
                            items: _experienceOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.slate900)),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              if (newVal != null) {
                                setState(() {
                                  _selectedExperience = newVal;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // DropdownButton: Highest Qualification
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.school_rounded, color: AppColors.slate500, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Highest Qualification',
                            style: TextStyle(fontSize: 11, color: AppColors.slate500, fontWeight: FontWeight.w600),
                          ),
                          DropdownButton<String>(
                            value: _selectedQualification,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.slate600),
                            items: _qualificationOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.slate900)),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              if (newVal != null) {
                                setState(() {
                                  _selectedQualification = newVal;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section: Radio Buttons (Notice Period / Availability)
              _buildSectionHeader('3. Availability / Notice Period', Icons.timer_outlined),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: Column(
                  children: _noticeOptions.map((option) {
                    return RadioListTile<String>(
                      title: Text(option, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.slate800)),
                      value: option,
                      groupValue: _noticePeriod,
                      activeColor: AppColors.primary,
                      dense: true,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _noticePeriod = val;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Section: Checkboxes (Skills Matching)
              _buildSectionHeader('4. Core Strengths & Skills', Icons.check_box_outlined),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: Column(
                  children: _skillsChecklist.keys.map((skill) {
                    return CheckboxListTile(
                      title: Text(skill, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.slate800)),
                      value: _skillsChecklist[skill],
                      activeColor: AppColors.primary,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? val) {
                        setState(() {
                          _skillsChecklist[skill] = val ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Section: Switches (Preferences)
              _buildSectionHeader('5. Work Preferences & Alerts', Icons.tune_rounded),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.home_work_outlined, color: AppColors.primary),
                      title: const Text('Open to Remote or Hybrid Work', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Willing to work remotely or flexible schedule', style: TextStyle(fontSize: 12, color: AppColors.slate500)),
                      value: _openToRemote,
                      activeColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          _openToRemote = val;
                        });
                      },
                    ),
                    const Divider(height: 1, thickness: 1, color: AppColors.borderSubtle),
                    SwitchListTile(
                      secondary: const Icon(Icons.mark_email_read_outlined, color: AppColors.primary),
                      title: const Text('Email Application Status', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Receive email updates for shortlist and interviews', style: TextStyle(fontSize: 12, color: AppColors.slate500)),
                      value: _receiveEmailAlerts,
                      activeColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          _receiveEmailAlerts = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section: Cover Note (TextFormField multiline)
              _buildSectionHeader('6. Pitch / Note to Recruiter', Icons.notes_rounded),
              const SizedBox(height: 12),
              TextFormField(
                controller: _coverLetterController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Briefly highlight why you are a great fit for this position...',
                  hintStyle: const TextStyle(color: AppColors.slate400, fontSize: 13),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().length < 15) {
                    return 'Please write at least 15 characters to explain your suitability';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Checkbox: Terms and conditions
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() {
                        _agreedToTerms = val ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I certify that all information provided is accurate and agree to the application terms.',
                      style: TextStyle(fontSize: 12, color: AppColors.slate600, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Submit & Cancel Buttons
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: AppColors.slate600,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send_rounded, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Submit Application',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.slate500, fontSize: 13, fontWeight: FontWeight.w500),
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.slate400, fontSize: 13),
      prefixIcon: Icon(icon, size: 19, color: AppColors.slate400),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppColors.slate900,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
