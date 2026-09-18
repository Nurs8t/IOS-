//
// // LW2
// void processOrder({
//   required int orderId,
//   required double itemPrice,
//   String ?promoCode,
//   double ?deliveryFee,
// }) {
//   double discount = 0;
//   if(deliveryFee== null || deliveryFee< 500){
//     deliveryFee = 500;
//   }
//
//
//   if ( promoCode == 'SAVE10') {
//     itemPrice *= 0.9;
//   }
//   double Finaltotal  = itemPrice + deliveryFee;
//   print('Finaltotal: $Finaltotal');
// }
// void main(){
//   processOrder(orderId: 2, itemPrice: 3000, promoCode: 'SAVE10', deliveryFee: 400);
//   processOrder(orderId: 1, itemPrice: 1500);
// }
//
//
//
//
// //Home work
// // task1
//
// void checkBalance({
//   required String name,
//   required double balance}) => print("current available balance: $balance");
//
// void main(){
//   checkBalance(name: "NURS", balance: 670000);
//   checkBalance(name:"Zhan", balance: 1234456);
// }
//
// // task2
// void deposit({
//   required double currentBalance,
//   double ?amount,
// }) {
//
//   double depositAmount= amount ?? 0.0;
//
//   double updateBalance= depositAmount + currentBalance;
//   print('updateBalance:  $updateBalance');
//
//
// }
// void main(){
//   deposit(currentBalance: 140,amount: 60 );
//   deposit(currentBalance: 130 );
// }
//
// // // task3
// void withdraw({
//   required String name,
//   required double currentbalance,
//   double ?amount,
//   int ?PinCode,
// })
// {
//   if( PinCode !=1234 || PinCode==null){
//     print("Errror");
//     return;
//
//   }
//   if( amount == null || amount >currentbalance){
//     print("Errror");
//     return;
//
//   }
//   currentbalance -= amount;
//   print('$name balance $currentbalance');
//
//
// }
//
// void main(){
//   withdraw(name:"NER", currentbalance: 1200, amount: 200, PinCode:1234);
//   withdraw(name:"NR", currentbalance: 1200, amount: 2000, PinCode:1234);
//   withdraw(name:"NERR", currentbalance: 1200, amount: 200, PinCode:12345);
// }
//
//
