import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopify/domain/initialize_params.dart';
import 'package:shopify/shopify.dart';
import 'package:shopify/model/address.dart';
import 'package:shopify/model/article.dart';
import 'package:shopify/model/card.dart';
import 'package:shopify/model/card_type.dart';
import 'package:shopify/model/cart_product.dart';
import 'package:shopify/model/category.dart';
import 'package:shopify/model/checkout.dart';
import 'package:shopify/model/country.dart';
import 'package:shopify/model/customer.dart';
import 'package:shopify/model/order.dart';
import 'package:shopify/model/product.dart';
import 'package:shopify/model/product_variant.dart';
import 'package:shopify/model/shipping_rate.dart';
import 'package:shopify/model/shop.dart';
import 'package:shopify/model/sort_type.dart' as sort;

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initShopify();
  }

  Future<void>  initShopify() async {

    await Shopify.platformVersion.then((val) {
      print(val);
    });

    ShopifyInitializeParams params = new ShopifyInitializeParams();
    params.domainName = "porganicworld.myshopify.com";
    params.accessToken = "62761bc137e3dac4c66d1d1a93d8dab3";
    params.apiKey = "1e5f1c6facb67ef0bf9e0c4af642d192";
    params.apiPassword = "5c3061bb2e053642fc1422409ccbb89e";
    await Shopify.initialize(params);

    signIn();
    //   createCheckout();
 //       signUp(); // phone no with country code is mandatory

  //  isLoggedIn();
//    signOut();
//    isLoggedIn();




   // getProductsList(); //variantList is coming  null in this call
    //getProduct(); //variantList is present in individual product call
   // getProductVariants();
   // searchProductList();

//   getCategories();
//   getCategoryDetails();

//    getArticleList(); //ArticleList is itself empty
//    getArticle();

  //  getShopInfo();

//    signUp(); // phone no with country code is mandatory

   // getAccessToken();
//    signOut();
//    isLoggedIn(); // is always false
//    forgotPassword();
//    changePassword();

//    getCountries();
//    getCustomer();

//    createCustomerAddress();
//    setDefaultShippingAddress();
//    editCustomerAddress();
//    deleteCustomerAddress();

    // editCustomerInfo();

//    updateCustomerSettings();

//    getOrder(); //PlatformException and null pointer exception
//    getOrders(); //onFailure -- com.shopapp.gateway.entity.Error$NonCritical: Unauthorized

//    createCheckout();
//    getCheckout();

  //  setShippingAddress(); //What checkOutId we should supply? - class cast exception
//    getShippingRates();

//    selectShippingRate(); // What checkOutId we should supply? - Unhandled exception

//    getAcceptedCardTypes();
//    getCardToken(); //exception
//    completeCheckoutByCard(); //exception

//  startShopping();
  }

  Future<void> startShopping() async {
    List<Category> categories = await Shopify.getCategoryList(5, null);
    List<Product> selectedProducts = await getSelectedProducts(categories);
    List<CartProduct> cartItems = await prepareCartItems(selectedProducts);
    Checkout checkout = await Shopify.createCheckout(cartItems);
//    checkout = await Shopify.getCheckout(checkout.checkoutId);
    print('Checkout - $checkout');
  }

  Future<List<Product>> getSelectedProducts(List<Category> categories) async {
    List<Product> selectedProducts = new List();

    for (Category category in categories) {
      await prepareProducts(category, selectedProducts);
    }
    return selectedProducts;
  }

  Future<void> prepareProducts(Category category, List<Product> selectedProducts) async {
    category = await Shopify.getCategoryDetails(category.id, 10, null, null);

    await prepare(category.productList, selectedProducts);
  }

  Future<void> prepare(List<Product> products, List<Product> selectedProducts) async {
    if (products != null && products.length > 0) {
      Product product1 = await Shopify.getProduct(products[0].id);
      bool isProduct1Available = true;
      if (product1.variants != null && product1.variants.length > 0) {
        for (ProductVariant variant in product1.variants) {
          if (!variant.isAvailable) {
            isProduct1Available = false;
            break;
          }
        }
      }
      if (isProduct1Available) {
        selectedProducts.add(product1);
      }
      if (products.length > 1) {
        Product product2 = await Shopify.getProduct(products[1].id);
        bool isProduct2Available = true;
        if (product2.variants != null && product2.variants.length > 0) {
          for (ProductVariant variant in product2.variants) {
            if (!variant.isAvailable) {
              isProduct2Available = false;
              break;
            }
          }
        }
        if (isProduct2Available) {
          selectedProducts.add(product2);
        }
      }
    }
  }

  Future<List<CartProduct>> prepareCartItems(List<Product> selectedProducts) async {
    List<CartProduct> cartItems = new List();
    selectedProducts.forEach((product) {
      CartProduct cartProduct = new CartProduct();
      cartProduct.title = product.title;
      cartProduct.currency = product.currency;
      cartProduct.quantity = 1;
      if (product.variants != null && product.variants.length > 0) {
        cartProduct.productVariant = product.variants[0];
      }
      cartItems.add(cartProduct);
    });
    return cartItems;
  }

  Future<void> getProductsList() async {
    List<Product> products =  await Shopify.getProductList(10, null, null, null, sort.SortType.NAME);
    print('Products - $products');
  }

  Future<void> getProduct() async {
    Product product = await Shopify.getProduct("Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE5NzU0NjExMTgwMTE=");
    print('Product - $product');
  }

  Future<void> getCategories() async {
    List<Category> categories = await Shopify.getCategoryList(15, null);
    print('Categories - $categories');
  }

  Future<void> getCategoryDetails() async {
    Category category = await Shopify.getCategoryDetails(
        "Z2lkOi8vc2hvcGlmeS9Db2xsZWN0aW9uLzY0NTA5MjE0Nzc5", 15, null, sort.SortType.NAME);
    //Jewellery
    print('Category - $category');
  }

  Future<void> getProductVariants() async {
    List<Product> products =  await Shopify.getProductList(5, null, null, null, sort.SortType.NAME);
    List<String> productVariantIds = new List();
    products.forEach((product) {
      for (int i = 0 ; i < product.variants.length; i++) {
        productVariantIds.add(product.variants[i].id);
      }
    });

//    Product product = await Shopify.getProduct("Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE5NzU0NjExMTgwMTE=");
//    for (int i = 0 ; i < product.variants.length; i++) {
//      productVariantIds.add(product.variants[i].id);
//    }
    print('main : ProductVariantListManual - $productVariantIds');

    List<ProductVariant> productVariants =  await Shopify.getProductVariantList(productVariantIds);
    print('main : ProductVariantList - $productVariants');
  }

  Future<void> searchProductList() async {
    List<Product> searchProducts =  await Shopify.searchProductList("Ursa", 3,
        null);
    print('main : searchProducts - $searchProducts');
  }

  Future<void> getArticleList() async {
    List<Article> articlesList =  await Shopify.getArticleList(3, null, null, true);
    print('main : ArticlesList - $articlesList');
  }

  Future<void> getArticle() async {
    Article article =  await Shopify.getArticle(""); //TODO pass article id
    print('main : article - $article');
  }

  Future<void> getShopInfo() async {
    Shop shop = await Shopify.getShopInfo();
    print('Shop - $shop');
  }

  Future<void> signIn() async {
    //bool val = await Shopify.signIn("imei3559230619@gmail.com", "bFppaybqvWaD6CZXF2");
    //bool val = await Shopify.signIn("test@gmail.com", "test123456");
    bool val = await Shopify.signIn("test1@gmail.com", "abcd987654");
   // getCustomer();
    print('Result - $val');
    //    getOrder(); //PlatformException and null pointer exception
    //    getProductsList();
  createCheckout();
    //getOrders(); //onFailure -- com.shopapp.gateway.entity.Error$NonCritical: Unauthorized
 //   getShippingRates();

  }

  Future<void> getAccessToken() async {
    String val = await Shopify.getAccessToken();
    print('Result - $val');
  }

  Future<void> signOut() async {
    bool val = await Shopify.signOut();
    print('Result - $val');
  }

  Future<void> signUp() async {
    String val = await Shopify.signUp("first_name", "last_name", "test1@gmail.com", "test987654", "+919985024234");
    print('Result - $val');
    signIn();
  }

  Future<void> isLoggedIn() async {
    bool val = await Shopify.isLoggedIn();
    print('Result - $val');
  }

  Future<void> forgotPassword() async {
    bool val = await Shopify.forgotPassword("test1@gmail.com");
    print('Result - $val');
  }

  Future<void> changePassword() async {
    bool val = await Shopify.changePassword("abcd987654");
    print('changePassword Result - $val');
    Customer customer = await Shopify.getCustomer();
    print('getCustomer Result - $customer');
  }

  Future<void> getCountries() async {
    List<Country> countries = await Shopify.getCountries();
    int number = countries.length;
    print('Result - $number');
  }

  Future<void> getCustomer() async {

    //createCustomerAddress();
//    getCountries();
    //    setDefaultShippingAddress();
 //   editCustomerAddress();
 //   deleteCustomerAddress();

  //  editCustomerInfo();

   // updateCustomerSettings();
    //Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy8yNTg3MDM1MDc0NjE5P21vZGVsX25hbWU9Q3VzdG9tZXJBZGRyZXNzJmN1c3RvbWVyX2FjY2Vzc190b2tlbj1rVExEeTNydE95WXM1SjdVY2NUM2VMbTliZEVxcHpIUUpiOW01cEE3alRJQzhhWTZXNGZHX2pSRjlQRzVEWW5qWVowSzFkaE1mdEJJVFRaYWpjeHBXSGdLTVRfSzdVMkNFb19oN20zT2c3VmcyTkhvLW80XzhTOG9tRkV1aFVPRF9yaHU2SnJKWGIza18wRUJHMkc4MW5CYjhjSk9ROFR5d082aVdtZmlkZEprNmlBSmw4eTVRUXp1bVA4ejFKUE85SFhRR2J0MWUwcnp0a21ZdHZzb3pQZm0waGg2eGFKTFllRE1lcWdBWGF6d19QX0dSN3lYRVJEQm94VUZIRWV4
    Customer customer = await Shopify.getCustomer();
    print('Result - $customer');


   // forgotPassword();
    //changePassword();




  }

  Future<void> setDefaultShippingAddress() async {
    bool val = await Shopify.setDefaultShippingAddress("Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy83OTcwMTE2MDc2MTE/bW9kZWxfbmFtZT1DdXN0b21lckFkZHJlc3MmY3VzdG9tZXJfYWNjZXNzX3Rva2VuPTZDUEtFaUJxRk9LdEVpQTRIYks1MHdCVTJubkI3Yzc3NW84ZXNnZUxfMUVFbEFtOWhRcExzRFgyOEozejhkTnE2SFRwX2J4SThqc0NlcTlIUE9mWW9vM3F4bXdraUs3aktJQ1E0SVVzMktqS19RLVFCeDhWdW9sWjRDNjdkbjVRWTJROUJkSHYxaGpSQUlELXlsb19YaDBiZGRZWjB2alltdE5Ueklsbm5ZZnlwSzlaM09adVdmUXVFRVlLeE9NYkFTbG5lTGhDNDgyQ1J0QUhTYS1ZTl9yS3dQNW9RbVVmb0QxRDRlaHZlbGdNS0hVY0xtcEgzOHJMWUJKbDJBazI=");
    print('Result - $val');
  }

  Future<void> createCustomerAddress() async {
    Address address = new Address();
    address.address = "primary address";
    address.secondAddress = "second Address";
    address.city = "my city";
    address.state = "my state";
    address.country = "my country";
    address.firstName = "my first name";
    address.lastName = "my last name";
    address.zip = "123456";
    address.phone = "+911234567890";
    String addressId = await Shopify.createCustomerAddress(address);
    print('Result - $addressId');
  }

  Future<void> editCustomerAddress() async {
    Address address = new Address();
    address.id = "Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy8yNTg3MDM1MDc0NjE5P21vZGVsX25hbWU9Q3VzdG9tZXJBZGRyZXNzJmN1c3RvbWVyX2FjY2Vzc190b2tlbj0zVnZsTmk2QkN0RHRRYjRRVzUyNldUaDFZZzNRMkF4YnBrN2hnd2VncTVaWkhRZHA2U3Q2V3RWR0ZrN01vTWVZWVQxdU9YaUdjdzN1aklOR1lGb1RkWEJLX3IwM19ET2I2Y205aGM3bG03U1VVZkpzN2loN3pKN3JNa0J1My0yV0RpbFhIZDNqajRDbnotVzJKV0FYX25VNDl1c3Zad19lMzBnOU92elVZLWlvZERQZGdXUDA2bk5tczFaZUVwMlN6N3dzQ3NCTkdqcXRMTEw5dlBDa1hjOERrbGxoajFaV1hSaXVUUXBwekJOQW5aSEtCUjNMOTRrZnJubXV1YmVO";
    address.address = "primary address changed";
    address.secondAddress = "second Address changed";
    address.city = "my city";
    address.state = "Alberta";
    address.country = "Canada";
    address.firstName = "my first name1";
    address.lastName = "my last name1";
    address.zip = "654321";
    address.company = "Office";
    address.phone = "+910123456789";
    bool val = await Shopify.editCustomerAddress(address.id, address);
    print('Result - $val');
    Customer customer = await Shopify.getCustomer();
    print('Result - $customer');
  }

  Future<void> deleteCustomerAddress() async {
    Address address = new Address();
    bool val = await Shopify.deleteCustomerAddress("Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy8yNTg3MDM1MDc0NjE5P21vZGVsX25hbWU9Q3VzdG9tZXJBZGRyZXNzJmN1c3RvbWVyX2FjY2Vzc190b2tlbj1SaTNNMDFkWkhwWmkxa25xR1dENUZyS2FYT014aTFfR0FtNWozVHgxYS1JQzhNSE45bnV4ay1YWWVLdnpveXZJZGRWRUthTThvNm9ZQ09pZWxXMjg3eDRJWHkxSVFHUExsTk93X0J3b1NMMkhzV1FFREdNQm9VcFdzUkJuZDJpd1NJTERYSHYtVDRVLUlkNlhUSmVqeVp1RHY0a3J6ZGlOTndCZFpLa0h0Zkd2Ri1KZjMxLXBIWk13RER2MVhub18tN0ZKWVR5RzJvQlpWY1QxX3hzWTZtWGxxOU54MmZwRVA3Yms1U1A1NDlySWtUTXhfX21QRVB0allTWS1oN2w3");
    print('Result - $val');
    Customer customer = await Shopify.getCustomer();
    print('Result - $customer');
  }

  Future<void> editCustomerInfo() async {
   // "first_name", "last_name", "test1@gmail.com", "test987654", "+919985024234")
    Customer customer = await Shopify.editCustomerInfo("Seshu", "Udatha", "+919985023259","test1@gmail.com")
    .then((value){
      print("Got error: ${value}");
    }) // Future completes with two()'s error.
    .catchError((e) {
      print("Got error: ${e}");     // Finally, callback fires.
    });
    print('Result - $customer');
  }

  Future<void> updateCustomerSettings() async {
    bool val = await Shopify.updateCustomerSettings(true);
    print('Result - $val');
    Customer customer = await Shopify.getCustomer();
    print('Result - $customer');


  }

  Future<void> getOrders() async {
    List<Order> orders = await Shopify.getOrders(5, null);
    print('Result - $orders');
  }

  Future<void> getOrder() async {
    Order order = await Shopify.getOrder("orderId");
    print('Result - $order');
  }

  Future<void> createCheckout() async {
    List<Product> products =  await Shopify.getProductList(5, null, null, null, sort.SortType.NAME);
    List<CartProduct> cartProducts = new List();
    products.forEach((product) {
      if(product.variants.length > 0)
      cartProducts.add(new CartProduct(productVariant: product.variants[0],
          title: product.title, currency: product.currency, quantity: 1));
    });
    Checkout checkout = await Shopify.createCheckout(cartProducts);
    print('Result - $checkout');
    setShippingAddress(checkout.checkoutId); //What checkOutId we should supply? - class cast exception

    //getShippingRates();
  }

  List<CartProduct> prepareCartProducts() {
    List<CartProduct> products = new List();
    products.add(new CartProduct(/*productVariant: new ProductVariant(id: "1",
        title: "dummy variant 1", price: 99.0, productId: "11"),*/
        title: "Cart Product 1", currency: "Indian Rupee", quantity: 3));

    products.add(new CartProduct(/*productVariant: new ProductVariant(id: "2",
        title: "dummy variant 2", price: 9.0, productId: "22"),*/
        title: "Cart Product 2", currency: "US dollar", quantity: 1));

    return products;
  }

  Future<void> getCheckout() async {
    Checkout checkout = await Shopify.getCheckout("Z2lkOi8vc2hvcGlmeS9DaGVja291dC9hNjc0NjY4MDcwZThhMjcyNzAyZmM0ZWMwYTAwOTNhMj9rZXk9Nzc2YzJkNWJmZWY2OTNlZjMxY2U0NmViMDBjMjMyMGY=");
    print('Result - $checkout');
  }

  Future<void> setShippingAddress(String checkoutId) async {
    Address address = new Address();
    address.id = "Z2lkOi8vc2hvcGlmeS9DaGVja291dC83YWFjNmM5NDFkYzM3MDE2MDc5ZTkxNTUzMTA2YjMwYT9rZXk9YThjODdiOWMxMGIxOTUyNjQzMDZkOTYzMzQzMTZjYjE=";
    address.address = "primary address changed";
    address.secondAddress = "second Address changed";
    address.city = "my city";
    address.state = "Karnataka";
    address.country = "India";
    address.firstName = "my first name1";
    address.lastName = "my last name1";
    address.zip = "560017";
    address.company = "Office";
    address.phone = "+910123456789";
    Checkout checkout = await Shopify.setShippingAddress(checkoutId, address);
    print('Result - $checkout');
  }

  Future<void> getShippingRates() async {
    List<ShippingRate> rates = await Shopify.getShippingRates("Z2lkOi8vc2hvcGlmeS9DaGVja291dC83YWFjNmM5NDFkYzM3MDE2MDc5ZTkxNTUzMTA2YjMwYT9rZXk9YThjODdiOWMxMGIxOTUyNjQzMDZkOTYzMzQzMTZjYjE=");
    print('Result - $rates');
  }

  Future<void> selectShippingRate() async {
    ShippingRate rate = new ShippingRate(title: "1", price: 0.0, handle: "2");
    Checkout checkout = await Shopify.selectShippingRate("Z2lkOi8vc2hvcGlmeS9DaGVja291dC9hNjc0NjY4MDcwZThhMjcyNzAyZmM0ZWMwYTAwOTNhMj9rZXk9Nzc2YzJkNWJmZWY2OTNlZjMxY2U0NmViMDBjMjMyMGY=", rate);
    print('Result - $checkout');
  }

  Future<void> getAcceptedCardTypes() async {
    List<CardType> cardTypes = await Shopify.getAcceptedCardTypes();
    print('Result - $cardTypes');
  }

  Future<void> getCardToken() async {
    CardDetails card = new CardDetails(firstName: "Ted", lastName: "X",
        cardNumber: "1234-5678-9101-1121", expireMonth: "June",
        expireYear: "2019", verificationCode: "111");
    String val = await Shopify.getCardToken(card);
    print('Result - $val');
  }

  Future<void> completeCheckoutByCard() async {
    Checkout checkout = await Shopify.getCheckout("Z2lkOi8vc2hvcGlmeS9DaGVja291dC8zYzA3NGI5ZjYyNDA5MmVhYWFkMzM4MTkxNDVlMDBhZT9rZXk9N2I3MDkwNGEyMDQ1NzkzYmZmMzFiOGI1NmQ1ZTgzMTE=");

    Address address = new Address();
    address.id = "Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy83OTcwMTE2MDc2MTE/bW9kZWxfbmFtZT1DdXN0b21lckFkZHJlc3MmY3VzdG9tZXJfYWNjZXNzX3Rva2VuPTZDUEtFaUJxRk9LdEVpQTRIYks1MHdCVTJubkI3Yzc3NW84ZXNnZUxfMUVFbEFtOWhRcExzRFgyOEozejhkTnE2SFRwX2J4SThqc0NlcTlIUE9mWW9vM3F4bXdraUs3aktJQ1E0SVVzMktqS19RLVFCeDhWdW9sWjRDNjdkbjVRWTJROUJkSHYxaGpSQUlELXlsb19YaDBiZGRZWjB2alltdE5Ueklsbm5ZZnlwSzlaM09adVdmUXVFRVlLeE9NYkFTbG5lTGhDNDgyQ1J0QUhTYS1ZTl9yS3dQNW9RbVVmb0QxRDRlaHZlbGdNS0hVY0xtcEgzOHJMWUJKbDJBazI=";
    address.address = "primary address changed";
    address.secondAddress = "second Address changed";
    address.city = "my city";
    address.state = "my state";
    address.country = "my country";
    address.firstName = "my first name";
    address.lastName = "my last name";
    address.zip = "123456";
    address.phone = "+911234567980";

    Order order = await Shopify.completeCheckoutByCard(checkout, "hello@hi.com", address, "ccValueToken");
    print('Result - $order');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text("TODO : UI : Pending"),
        ),
      ),
    );
  }

}
