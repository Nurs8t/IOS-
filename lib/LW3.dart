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







