import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HackathonListPage extends StatefulWidget {
  const HackathonListPage({super.key});

  @override
  State<HackathonListPage> createState() => _HackathonListPageState();
}

class _HackathonListPageState extends State<HackathonListPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<dynamic> hackathons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHackathons();
  }

  Future<void> fetchHackathons() async {
    try {
      final response = await supabase.from('hackathons').select().order('start_date');
      setState(() {
        hackathons = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching hackathons: $e');
    }
  }

  Future<void> _launchURL(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  Widget buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hackathons"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hackathons.isEmpty
              ? const Center(child: Text("No hackathons found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: hackathons.length,
                  itemBuilder: (context, index) {
                    final hackathon = hackathons[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hackathon['name'] ?? 'No name',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (hackathon['prize'] != null)
                                  buildBadge(hackathon['prize'], Colors.green),
                                if (hackathon['participants'] != null)
                                  buildBadge(
                                      '${hackathon['participants']} participants',
                                      Colors.blue),
                                buildBadge(
                                    hackathon['location'] ?? 'Online',
                                    Colors.orange),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Start: ${hackathon['start_date'] ?? 'TBD'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'End: ${hackathon['end_date'] ?? 'TBD'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    _launchURL(hackathon['link']),
                                icon: const Icon(Icons.link),
                                label: const Text("Open Devpost Page"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
