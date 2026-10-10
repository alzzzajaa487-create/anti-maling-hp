
import 'package:flutter/material.dart';

void main() => runApp(const AntiMalingApp());

class AntiMalingApp extends StatelessWidget {
  const AntiMalingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090909),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      home: const SecurityPage(),
    );
  }
}

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool armed = false;

  void toggleAlarm() {
    setState(() => armed = !armed);
  }

  void stopWithPin() {
    final pin = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF202020),
        title: const Text('PIN Keamanan'),
        content: TextField(
          controller: pin,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Masukkan PIN',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (pin.text == '1234') {
                setState(() => armed = false);
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('Pengaman dimatikan')),
                );
              } else {
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('PIN salah')),
                );
              }
            },
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ANTI MALING',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shield_rounded,
              size: 100,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            Text(
              armed ? 'PENGAMAN AKTIF' : 'PENGAMAN NONAKTIF',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: armed ? Colors.greenAccent : Colors.redAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              armed
                  ? 'Mode pengaman dipilih'
                  : 'Lindungi HP kamu dari orang yang mengambilnya',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed: toggleAlarm,
                icon: Icon(
                  armed ? Icons.lock_open : Icons.shield,
                ),
                label: Text(
                  armed ? 'NONAKTIFKAN MODE' : 'AKTIFKAN PENGAMAN',
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: stopWithPin,
                icon: const Icon(Icons.password),
                label: const Text('MATIKAN DENGAN PIN'),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'PIN demo: 1234\n'
              'Versi ini masih berupa antarmuka. '
              'Sensor gerak, alarm, dan flash belum dihubungkan.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

