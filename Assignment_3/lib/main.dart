import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Identity Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
      ),
      home: const IdentityCardPage(),
    );
  }
}

class IdentityCardPage extends StatelessWidget {
  const IdentityCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Digital Identity Card',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: 360,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x140F172A),
                blurRadius: 24,
                spreadRadius: 0,
                offset: Offset(0, 12),
              ),
              BoxShadow(
                color: Color(0x0A0F172A),
                blurRadius: 6,
                spreadRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Profile Picture using CircleAvatar
              const CircleAvatar(
                radius: 52,
                backgroundColor: Color(0xFF2563EB),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFFEFF6FF),
                  backgroundImage: NetworkImage('https://instagram.fbom3-4.fna.fbcdn.net/v/t51.75761-19/499646057_17967135779870318_1279812080708891574_n.jpg?_nc_cat=111&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDgwLkMzIn0%3D&_nc_ohc=60EhVif0HPYQ7kNvwHmdvxh&_nc_oc=AdrQHRMuwXDqzwTl8K9DD_otMr5NU4OC1s6Rc4EB-olnxXw_uP4m33Gcikr5n2HRRvjYGDbaaM7-kUYgsQ_ip9ll&_nc_zt=24&_nc_ht=instagram.fbom3-4.fna&_nc_gid=aLHzftCzkb0V-sXpT0P95Q&_nc_ss=7b6a8&oh=00_AQKb6s0VI7AklgHXw0qj40djSksISMIg3kySDbh4FtIy-Q&oe=6AAF46C7')
                ),
              ),
              const SizedBox(height: 18),

              // 2. Person's Name
              const Text(
                'Ritesh Jadhav',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),

              // 3. Profession
              const Text(
                'Software Developer',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2563EB),
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),

              // Location
              const Text(
                'Mumbai, India',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),

              // Decorative Divider
              Container(
                height: 1,
                width: double.infinity,
                color: const Color(0xFFF1F5F9),
              ),
              const SizedBox(height: 20),

              // 4. Row displaying Personal Statistics
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Age Statistic
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cake_rounded,
                        color: Color(0xFF2563EB),
                        size: 26,
                      ),
                      SizedBox(height: 6),
                      Text(
                        '20 Years',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),

                  // ID No. Statistic
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.badge_rounded,
                        color: Color(0xFF2563EB),
                        size: 26,
                      ),
                      SizedBox(height: 6),
                      Text(
                        '150096724138',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),

                  // Blood Group Statistic
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bloodtype_rounded,
                        color: Color(0xFFEF4444),
                        size: 26,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'O+',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 5. Container with Email Address at the bottom
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Color(0xFF2563EB),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'ritesh6798@hotmail.com',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF334155),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
