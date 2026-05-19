import 'package:flutter/material.dart';

void main() {
  runApp(const MathverseApp());
}

// ================= APP =================
class MathverseApp extends StatelessWidget {
  const MathverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mathverse PRO',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const LoginPage(),
    );
  }
}

// ================= FAKE DB =================
const users = {
  "admin": {"pass": "1234", "role": "admin"},
  "student": {"pass": "1234", "role": "student"},
};

// ================= LOGIN =================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final u = TextEditingController();
  final p = TextEditingController();

  String error = "";

  void login() {
    final user = u.text.trim();
    final pass = p.text.trim();

    if (users.containsKey(user) && users[user]!['pass'] == pass) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(
            username: user,
            role: users[user]!['role']!,
          ),
        ),
      );
    } else {
      setState(() => error = "❌ Wrong login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: u, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: p, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 10),
            Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}

// ================= HOME =================
class HomePage extends StatefulWidget {
  final String username;
  final String role;

  const HomePage({super.key, required this.username, required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int score = 0;

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void addScore() {
    setState(() => score += 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.username}"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.star),
              title: Text("Score: $score"),
              subtitle: const Text("Your points"),
            ),
          ),

          const SizedBox(height: 10),

          _tile("📚 Lessons", () {}),
          _tile("🧠 Quiz", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizPage(onCorrect: addScore),
              ),
            );
          }),
          _tile("👤 Profile", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilePage(user: widget.username),
              ),
            );
          }),

          if (widget.role == "admin")
            _tile("👑 Admin Panel", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminPage()),
              );
            }),
        ],
      ),
    );
  }

  Widget _tile(String title, VoidCallback onTap) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

// ================= QUIZ =================
class QuizPage extends StatelessWidget {
  final VoidCallback onCorrect;

  const QuizPage({super.key, required this.onCorrect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("2 + 2 = ?", style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("3"),
          ),

          ElevatedButton(
            onPressed: () {
              onCorrect();
              Navigator.pop(context);
            },
            child: const Text("4 (Correct)"),
          ),
        ],
      ),
    );
  }
}

// ================= PROFILE =================
class ProfilePage extends StatelessWidget {
  final String user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Text("User: $user", style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

// ================= ADMIN =================
class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: const Center(
        child: Text("Manage Users / Stats / Settings"),
      ),
    );
  }
}
