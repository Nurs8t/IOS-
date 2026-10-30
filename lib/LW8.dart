

/// LAB 8 & ADAPTIVE LAYOUT APP
import 'package:flutter/material.dart';

void main() {
  runApp(const BookShopApp());
}

// 1. Кітап Моделі
class Book {
  final String id;
  final String title;
  final String author;
  final String price;
  final String rating;
  final String reviewsCount;
  final String imagePath;
  final String synopsis;
  final List<String> tags;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.imagePath,
    required this.synopsis,
    required this.tags,
  });
}

// Бастапқы кітаптар тізімі
final List<Book> initialBooks = [
  Book(
    id: '1',
    title: 'Махаббат, қызық мол жылдар',
    author: 'Әзілхан Нұршайықов',
    price: '3000 Тг',
    rating: '4.9',
    reviewsCount: '1 420 пікір',
    imagePath: 'assets/my_book.jpeg',
    synopsis:
    '«Махаббат, қызық мол жылдар» — қазақ жазушысы Әзілхан Нұршайықовтың 1970 жылы '
        'жарық көрген классикалық роман-дилогиясы. Туындыда Екінші дүниежүзілік соғыстан '
        'кейінгі университет өмірі, Ербол мен Меңтайдың шынайы махаббаты баяндалады.',
    tags: ['Қазақ әдебиеті', 'Классика', 'Роман-дилогия', 'Жастық шақ'],
  ),
  Book(
    id: '2',
    title: 'Абай жолы (1-том)',
    author: 'Мұхтар Әуезов',
    price: '3500 Тг',
    rating: '5.0',
    reviewsCount: '3 210 пікір',
    imagePath: 'assets/my_book1.jpeg',
    synopsis:
    '«Абай жолы» — Мұхтар Әуезовтің әлемге танымал роман-эпопеясы.',
    tags: ['Қазақ әдебиеті', 'Классика', 'Роман-эпопея', 'Абайтану'],
  ),
  Book(
    id: '3',
    title: 'Көшпенділер',
    author: 'Ілияс Есенберлин',
    price: '3200 Тг',
    rating: '4.8',
    reviewsCount: '980 пікір',
    imagePath: 'assets/my_book2.jpeg',
    synopsis:
    'Қазақ хандығының құрылуы мен қалыптасу тарихын баяндайтын тарихи трилогия.',
    tags: ['Тарихи роман', 'Қазақ хандығы', 'Алтын қор'],
  ),
  Book(
    id: '4',
    title: 'Гаухартас',
    author: 'Дулат Исабеков',
    price: '1500 Тг',
    rating: '4.9',
    reviewsCount: '1450 пікір',
    imagePath: 'assets/my_book3.jpeg',
    synopsis:
    'Дәстүрлі қазақ ауылындағы әйел тағдыры мен отбасылық қарым-қатынастарды суреттейтін атақты повесі.',
    tags: ['Классика', 'Повесть', 'Проза'],
  ),
];

class BookShopApp extends StatelessWidget {
  const BookShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Қазақ әдебиеті дүкені',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          primary: Colors.brown.shade800,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F5F0),
        useMaterial3: true,
      ),
      home: const RootNavigationScreen(),
    );
  }
}

// 2. ROOT NAVIGATION
class RootNavigationScreen extends StatefulWidget {
  const RootNavigationScreen({super.key});

  @override
  State<RootNavigationScreen> createState() => _RootNavigationScreenState();
}

class _RootNavigationScreenState extends State<RootNavigationScreen> {
  int _currentIndex = 0;

  List<Book> _catalogBooks = List.from(initialBooks);
  final List<Book> _favoriteBooks = [];

  void _toggleFavorite(Book book) {
    setState(() {
      if (_favoriteBooks.contains(book)) {
        _favoriteBooks.remove(book);
      } else {
        _favoriteBooks.add(book);
      }
    });
  }

  void _removeBook(int index) {
    final removedBook = _catalogBooks[index];
    setState(() {
      _catalogBooks.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedBook.title} өшірілді'),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.amberAccent,
          onPressed: () {
            setState(() {
              _catalogBooks.insert(index, removedBook);
            });
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      final newBook = Book(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Жаңа кітап #${_catalogBooks.length + 1}',
        author: 'Белгісіз автор',
        price: '2500 Тг',
        rating: '5.0',
        reviewsCount: '1 пікір',
        imagePath: 'assets/my_book.jpeg',
        synopsis: 'Бұл Pull-to-Refresh арқылы автоматты түрде қосылған жаңа кітап.',
        tags: ['Жаңалық', 'Эксклюзив'],
      );
      _catalogBooks.insert(0, newBook);
    });
  }

  void _resetCatalog() {
    setState(() {
      _catalogBooks = List.from(initialBooks);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      BookFeedTab(
        books: _catalogBooks,
        favoriteBooks: _favoriteBooks,
        onToggleFavorite: _toggleFavorite,
        onRemoveBook: _removeBook,
        onRefresh: _handleRefresh,
        onResetCatalog: _resetCatalog,
      ),
      FavoritesTab(
        favoriteBooks: _favoriteBooks,
        onToggleFavorite: _toggleFavorite,
      ),
      const ProfileTab(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.brown.shade800,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Кітаптар',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Таңдаулылар',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

// --- TAB 1: Кітаптар тізімі (Adaptive Layout: Phone, Tablet, PC) ---
class BookFeedTab extends StatefulWidget {
  final List<Book> books;
  final List<Book> favoriteBooks;
  final Function(Book) onToggleFavorite;
  final Function(int) onRemoveBook;
  final Future<void> Function() onRefresh;
  final VoidCallback onResetCatalog;

  const BookFeedTab({
    super.key,
    required this.books,
    required this.favoriteBooks,
    required this.onToggleFavorite,
    required this.onRemoveBook,
    required this.onRefresh,
    required this.onResetCatalog,
  });

  @override
  State<BookFeedTab> createState() => _BookFeedTabState();
}

class _BookFeedTabState extends State<BookFeedTab> {
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    // Screen width арқылы құрылғы түрін анықтау (Phone < 600, Tablet < 1000, PC >= 1000)
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= 1000;
    bool isTablet = screenWidth >= 600 && screenWidth < 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Қазақ әдебиеті дүкені'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF9F5F0),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: 'Көріністі ауыстыру',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 900 : (isTablet ? 700 : double.infinity),
          ),
          child: RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: widget.books.isEmpty
                ? _buildEmptyState()
                : (_isGridView || isTablet || isDesktop
                ? _buildAdaptiveGrid(screenWidth)
                : _buildListView()),
          ),
        ),
      ),
    );
  }

  // Phone үшін ListView
  Widget _buildListView() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: widget.books.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final book = widget.books[index];
        final isFav = widget.favoriteBooks.contains(book);

        return Dismissible(
          key: ValueKey(book.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete, color: Colors.white, size: 28),
          ),
          onDismissed: (direction) => widget.onRemoveBook(index),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  book.imagePath,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 50,
                    height: 70,
                    color: Colors.teal.shade200,
                    child: const Icon(Icons.book, color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${book.author}\n${book.price}',
                style: TextStyle(color: Colors.brown.shade700),
              ),
              trailing: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                ),
                onPressed: () => widget.onToggleFavorite(book),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(
                      book: book,
                      isFavorite: isFav,
                      onToggleFavorite: () => widget.onToggleFavorite(book),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Screen Width-ке қарай Grid бағандарын автоматты өзгерту (Phone: 2, Tablet: 3, PC: 4)
  Widget _buildAdaptiveGrid(double width) {
    int crossAxisCount = 2;
    if (width >= 1000) {
      crossAxisCount = 4; // PC
    } else if (width >= 600) {
      crossAxisCount = 3; // Tablet
    }

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        final book = widget.books[index];
        final isFav = widget.favoriteBooks.contains(book);

        return Dismissible(
          key: ValueKey(book.id),
          direction: DismissDirection.up,
          background: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete, color: Colors.white, size: 28),
          ),
          onDismissed: (direction) => widget.onRemoveBook(index),
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(
                      book: book,
                      isFavorite: isFav,
                      onToggleFavorite: () => widget.onToggleFavorite(book),
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      book.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.brown.shade200,
                        child: const Center(child: Icon(Icons.book, color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          book.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.brown.shade600, fontSize: 11),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              book.price,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.brown.shade800,
                              ),
                            ),
                            IconButton(
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                                size: 18,
                              ),
                              onPressed: () => widget.onToggleFavorite(book),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border, size: 80, color: Colors.brown.shade300),
                    const SizedBox(height: 16),
                    const Text(
                      'Каталог бос',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Барлық кітаптар өшірілді. Бастапқы кітаптарды қайта жүктеу үшін түймені басыңыз.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: widget.onResetCatalog,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Каталогты жаңарту'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// --- TAB 2: Таңдаулылар ---
class FavoritesTab extends StatelessWidget {
  final List<Book> favoriteBooks;
  final Function(Book) onToggleFavorite;

  const FavoritesTab({
    super.key,
    required this.favoriteBooks,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Таңдаулы кітаптар'),
        centerTitle: true,
      ),
      body: favoriteBooks.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 64, color: Colors.brown),
            SizedBox(height: 12),
            Text(
              'Таңдаулы кітаптар тізімі бос',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  book.imagePath,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 50,
                    height: 70,
                    color: Colors.teal.shade200,
                    child: const Icon(Icons.book, color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${book.author}\n${book.price}',
                style: TextStyle(color: Colors.brown.shade700),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () => onToggleFavorite(book),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(
                      book: book,
                      isFavorite: true,
                      onToggleFavorite: () => onToggleFavorite(book),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- TAB 3: Профиль ---
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пайдаланушы профилі'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.brown,
              backgroundImage: AssetImage('assets/123.jpeg'),

            ),
            const SizedBox(height: 12),
            const Text(
              'Студент / Оқырман',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'student@university.kz',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const Divider(height: 32),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Баптаулар'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Тапсырыстар тарихы'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// --- DETAIL SCREEN ---
class BookDetailScreen extends StatefulWidget {
  final Book book;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кітап мәліметтері'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  color: Colors.brown.shade100,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        book.imagePath,
                        height: 220,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 150,
                          height: 200,
                          color: Colors.teal.shade200,
                          child: const Icon(Icons.book, size: 80, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        _isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: _isSaved ? Colors.teal : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSaved = !_isSaved;
                        });
                        widget.onToggleFavorite();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        book.price,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Авторы: ${book.author}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        book.rating,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${book.reviewsCount})',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                      const Spacer(),
                      Chip(
                        label: const Text('Қоймада бар'),
                        backgroundColor: Colors.green.shade50,
                        side: BorderSide.none,
                        labelStyle: TextStyle(color: Colors.green.shade700, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Негізгі тақырыптар',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: book.tags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        backgroundColor: Colors.teal.shade50,
                        side: BorderSide.none,
                        labelStyle: TextStyle(color: Colors.teal.shade800, fontSize: 12),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Кітап туралы',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.synopsis,
                    style: TextStyle(color: Colors.grey.shade700, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Тізімге кері қайту'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                offset: const Offset(0, -4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${book.title} себетке қосылды!')),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text(
                    'Кітапты сатып алу',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}