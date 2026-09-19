///LW3
///
///
///
/// 
class Book{
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book(this.title, this.author, this.price, [this.isBorrowed = false]);
}


class Library{
  List<Book> _books=[];
  void addBook(Book book){
    _books.add(book);
  }
  List<Book> getAvailableBooks() {
    return _books.where((b) => b.isBorrowed == false).toList();
  }
  double getTotalValue() {
    return _books.fold(0, (total,book) => total+ book.price);
  }
}

void main(){
  var bb= Library();
  bb.addBook(Book('QWER', 'ASDF',2345));


  print(' Books: ');
  for (var b in bb.getAvailableBooks()){
    print(' "${b.title}", ${b.author}');
  }
  print(' Total: ${bb.getTotalValue()}');
}











abstract class MediaItem{
  String id;
  String title;
  double price;


  MediaItem(this.id, this.title, this.price);
  String getDetails();
}

mixin Downloadable {void download(String title)=> print('"$title"');}

class Audiobook extends MediaItem with Downloadable{
  double durationHours;
  String narrator;
  Audiobook(
      String id,
      String title,
      double price,
      this.durationHours,
      this.narrator,
      ) : super(id, title, price);
  @override
  String getDetails() {
    return 'Audiobook $title | Price: \$$price | Duration: ${durationHours}h | Narrator: $narrator';
  }
}

class Ebook extends MediaItem with Downloadable{
  double fileSizeMB;
  String author;
  Ebook(
      String id,
      String title,
      double price,
      this.fileSizeMB,
      this.author,
      ) : super(id, title, price);
  @override
  String getDetails() {
    return '[EBook] $title | Price: \$$price | Size: ${fileSizeMB}MB | Author: $author';
  }
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double subtotal = _items.fold(0.0, (sum, item) => sum + item.price);
    return subtotal * (1 + taxRate);
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }
  void printReceipt() {
    for (var item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print('Total (incl. 12% tax): \$${calculateTotalWithTax().toStringAsFixed(2)}');
  }
}
void main(){
  var cart = ShoppingCart();
  var ebook1 = Ebook('1', 'Dart', 2500, 12.5, 'ASDF');
  var audio1 = Audiobook('1', 'QWER', 1500, 5.5, 'Jam');
  var ebook2 = Ebook('2', 'JAVA', 4000, 18.2, 'Robert');
  cart.addItem(ebook1);
  cart.addItem(audio1);
  cart.addItem(ebook2);

  cart.printReceipt();


  var cheapItems = cart.filterByMaxPrice(4000);
  for (var item in cheapItems) {
    print(item.getDetails());
  }
}














