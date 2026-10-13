import 'package:flutter/material.dart';

void main() {
  runApp(const TripSathiApp());
}

const Color forestGreen = Color(0xFF08665D);
const Color ink = Color(0xFF101D2E);
const Color pageBackground = Color(0xFFF7F9FC);

class TripSathiApp extends StatelessWidget {
  const TripSathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripSathi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: forestGreen),
        fontFamily: 'Roboto',
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const NetworkPhoto(
            url: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=85',
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xAA062B52), Color(0x3311263A), Color(0xEE071522)],
                stops: [0, 0.48, 1],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 38, 28, 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Icon(Icons.landscape_rounded, color: Colors.white, size: 82),
                  const SizedBox(height: 8),
                  const Text(
                    'TripSathi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Explore  •  Trek  •  Create Memories',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const Spacer(flex: 5),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ink,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      ),
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainNavigation()),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Get Started', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                      GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login can be connected here later.')),
                        ),
                        child: const Text('Log In',
                            style: TextStyle(color: Color(0xFF59E1C0), fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    ExploreScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDDF3EC),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good Morning,', style: TextStyle(color: ink, fontSize: 16)),
                    SizedBox(height: 3),
                    Text('Pramod 🏔️', style: TextStyle(color: ink, fontSize: 27, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You are all caught up!')),
                ),
                icon: const Icon(Icons.notifications_none_rounded, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SearchField(),
          const SizedBox(height: 22),
          const FeaturedDestinationCard(),
          const SizedBox(height: 22),
          const CategoryShortcuts(),
          const SizedBox(height: 26),
          SectionHeading(
            title: 'Popular Destinations',
            action: 'See All',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ExploreScreen()),
            ),
          ),
          const SizedBox(height: 13),
          const Row(
            children: [
              Expanded(
                child: DestinationCard(
                  title: 'Annapurna Circuit',
                  location: 'Nepal',
                  rating: '4.8',
                  imageUrl: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: DestinationCard(
                  title: 'Langtang Valley',
                  location: 'Nepal',
                  rating: '4.6',
                  imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=800&q=80',
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const Text('Recommended For You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ink)),
          const SizedBox(height: 12),
          const RecommendedTile(),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value.trim().isEmpty ? 'Type a destination to search.' : 'Searching for $value')),
      ),
      decoration: InputDecoration(
        hintText: 'Search destinations, treks...',
        prefixIcon: const Icon(Icons.search_rounded),
        filled: true,
        fillColor: const Color(0xFFF2F6FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
    );
  }
}

class FeaturedDestinationCard extends StatelessWidget {
  const FeaturedDestinationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 190,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const NetworkPhoto(
              url: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=85',
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xE6000000)],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              right: 64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: forestGreen, borderRadius: BorderRadius.circular(20)),
                    child: const Text('♧ FEATURED',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 10),
                  const Text('Everest Base Camp',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  const Text('The journey of a lifetime', style: TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ),
            Positioned(
              right: 15,
              bottom: 17,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_rounded, color: forestGreen),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DestinationDetailsScreen()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryShortcuts extends StatelessWidget {
  const CategoryShortcuts({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.terrain_rounded, 'Trekking', const Color(0xFFE1F3EA), forestGreen),
      (Icons.flight_rounded, 'Tours', const Color(0xFFE0F0FF), Color(0xFF1686D9)),
      (Icons.hotel_rounded, 'Hotels', const Color(0xFFFFEEDC), Color(0xFFEA8A2F)),
      (Icons.explore_rounded, 'Explore', const Color(0xFFEDE5FF), Color(0xFF8A50D8)),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((item) {
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExploreScreen())),
          child: SizedBox(
            width: 72,
            child: Column(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(color: item.$3, borderRadius: BorderRadius.circular(21)),
                  child: Icon(item.$1, color: item.$4, size: 30),
                ),
                const SizedBox(height: 8),
                Text(item.$2, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const SectionHeading({super.key, required this.title, this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ink))),
        if (action != null)
          TextButton(onPressed: onTap, child: Text(action!, style: const TextStyle(color: Color(0xFF087CA5)))),
      ],
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String title;
  final String location;
  final String rating;
  final String imageUrl;

  const DestinationCard({
    super.key,
    required this.title,
    required this.location,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 3))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: SizedBox(height: 105, width: double.infinity, child: NetworkPhoto(url: imageUrl)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(9, 9, 9, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF2B9DB0), size: 15),
                    Expanded(child: Text(location, style: const TextStyle(fontSize: 11, color: Colors.blueGrey))),
                    const Icon(Icons.star_rounded, color: Color(0xFFFFB400), size: 17),
                    Text(rating, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendedTile extends StatelessWidget {
  const RecommendedTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const SizedBox(
              width: 88, height: 82,
              child: NetworkPhoto(url: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=600&q=80'),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mardi Himal Trek', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                SizedBox(height: 5),
                Row(children: [Icon(Icons.location_on, size: 15, color: Color(0xFF2B9DB0)), Text(' Nepal', style: TextStyle(fontSize: 12))]),
                SizedBox(height: 4),
                Row(children: [Icon(Icons.star_rounded, size: 17, color: Color(0xFFFFB400)), Text(' 4.5', style: TextStyle(fontSize: 12))]),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DestinationDetailsScreen())),
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Explore Nepal', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: ink)),
          const SizedBox(height: 8),
          const Text('Find your next trail, view, and adventure.', style: TextStyle(color: Colors.blueGrey)),
          const SizedBox(height: 18),
          const SearchField(),
          const SizedBox(height: 20),
          const DestinationCard(
            title: 'Everest Base Camp',
            location: 'Solukhumbu, Nepal',
            rating: '4.9',
            imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=85',
          ),
          const SizedBox(height: 14),
          const DestinationCard(
            title: 'Annapurna Circuit',
            location: 'Annapurna, Nepal',
            rating: '4.8',
            imageUrl: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
          ),
          const SizedBox(height: 14),
          const DestinationCard(
            title: 'Langtang Valley',
            location: 'Rasuwa, Nepal',
            rating: '4.6',
            imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=800&q=80',
          ),
        ],
      ),
    );
  }
}

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text('Saved Destinations', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: ink)),
          SizedBox(height: 8),
          Text('Keep the places you want to visit in one place.', style: TextStyle(color: Colors.blueGrey)),
          SizedBox(height: 22),
          DestinationCard(
            title: 'Annapurna Circuit',
            location: 'Nepal',
            rating: '4.8',
            imageUrl: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
          ),
          SizedBox(height: 14),
          DestinationCard(
            title: 'Mardi Himal Trek',
            location: 'Nepal',
            rating: '4.5',
            imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=600&q=80',
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
        children: [
          SizedBox(
            height: 210,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
                  child: const SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: NetworkPhoto(url: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=85'),
                  ),
                ),
                Positioned(
                  top: 15, right: 12,
                  child: IconButton(
                    onPressed: () => _showMessage(context, 'Settings will be available here.'),
                    icon: const Icon(Icons.settings, color: Colors.white),
                  ),
                ),
                const Positioned(
                  left: 18, bottom: 0,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 43,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text('Pramod Adhikari', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: ink)),
          const SizedBox(height: 4),
          const Text('pramod@gmail.com', style: TextStyle(color: ink)),
          const SizedBox(height: 24),
          const Row(
            children: [
              Expanded(child: ProfileStat(number: '5', label: 'Trips')),
              Expanded(child: ProfileStat(number: '12', label: 'Saved')),
              Expanded(child: ProfileStat(number: '3', label: 'Reviews')),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5F1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFD2EAE2)),
            ),
            child: const Row(
              children: [
                CircleAvatar(backgroundColor: Color(0xFFD8EFE6), child: Icon(Icons.terrain, color: forestGreen)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Travel More', style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 4),
                    Text('Collect more memories and earn new badges!', style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
                  ]),
                ),
                Icon(Icons.arrow_forward_rounded),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ProfileMenuItem(icon: Icons.event_available_outlined, title: 'My Bookings', onTap: () => _showMessage(context, 'Your bookings will appear here.')),
          ProfileMenuItem(icon: Icons.favorite_border, title: 'Wishlist', onTap: () => _showMessage(context, 'Open Saved from the bottom menu.')),
          ProfileMenuItem(icon: Icons.star_border_rounded, title: 'Reviews', onTap: () => _showMessage(context, 'Your reviews will appear here.')),
          ProfileMenuItem(icon: Icons.settings_outlined, title: 'Settings', onTap: () => _showMessage(context, 'Settings will be available here.')),
          ProfileMenuItem(icon: Icons.help_outline_rounded, title: 'Help & Support', onTap: () => _showMessage(context, 'Contact support: support@tripsathi.example')),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => const WelcomeScreen()), (route) => false),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Log Out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: ink,
              padding: const EdgeInsets.symmetric(vertical: 15),
              side: const BorderSide(color: Color(0xFFDCE7ED)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String number;
  final String label;
  const ProfileStat({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(number, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ink)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
      ],
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      leading: Icon(icon, color: ink, size: 25),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.blueGrey),
      onTap: onTap,
    );
  }
}

class DestinationDetailsScreen extends StatelessWidget {
  const DestinationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            foregroundColor: Colors.white,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Everest Base Camp'),
              background: NetworkPhoto(url: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=85'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(Icons.location_on, color: forestGreen),
                    SizedBox(width: 4),
                    Text('Solukhumbu, Nepal'),
                    Spacer(),
                    Icon(Icons.star_rounded, color: Color(0xFFFFB400)),
                    Text('4.9'),
                  ]),
                  const SizedBox(height: 18),
                  const Text('About this destination', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('Experience dramatic Himalayan landscapes, mountain villages, and memorable trekking routes. Plan carefully and check local weather and trail conditions before travelling.',
                    style: TextStyle(height: 1.5, color: Colors.blueGrey)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _showMessage(context, 'Trip planning has been selected.'),
                      icon: const Icon(Icons.calendar_month_rounded),
                      label: const Text('Plan a Trip'),
                      style: FilledButton.styleFrom(backgroundColor: forestGreen, padding: const EdgeInsets.all(15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NetworkPhoto extends StatelessWidget {
  final String url;
  const NetworkPhoto({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: const Color(0xFFDCE8EF),
        alignment: Alignment.center,
        child: const Icon(Icons.landscape_rounded, color: forestGreen, size: 48),
      ),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: const Color(0xFFE8EEF3),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(strokeWidth: 2, color: forestGreen),
        );
      },
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
