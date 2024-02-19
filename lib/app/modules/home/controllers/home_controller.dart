import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/data/database/product_db.dart';
import 'package:genmak_ecom/app/data/database/profile_db.dart';
import 'package:genmak_ecom/app/data/database/sell_db.dart';
import 'package:genmak_ecom/app/data/database/vendor_db.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/data/models/profile_model.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:lan_scanner/lan_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:image/image.dart';
import 'package:ping_discover_network_plus/ping_discover_network_plus.dart';
//
import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  //
  final box = GetStorage();

  final pdf = pw.Document();

  final ProductDB productDB = ProductDB();
  final SellDB sellDB = SellDB();
  final VendorDB vendorDB = VendorDB();
  final ProfileDB profileDB = ProfileDB();

  final provisioner = Provisioner.espTouch();
  final v = Provisioner.espTouchV2();

  final info = NetworkInfo();

// final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66

  String localIp = '';
  List<String> devices = [];
  bool isDiscovering = false;
  int found = -1;
  TextEditingController portController = TextEditingController(text: '8883');

  // final PaperSize paper = PaperSize.mm80;
// final profile = await CapabilityProfile.load();
// final printer = NetworkPrinter(paper, profile);

  final RxList<ProductModel> _products = RxList<ProductModel>();
  List<ProductModel> get products => _products;
  set products(List<ProductModel> lt) => _products.assignAll(lt);

  final RxList<ProductModel> _productSearch = RxList<ProductModel>();
  List<ProductModel> get productSearch => _productSearch;
  set productSearch(List<ProductModel> lt) => _productSearch.assignAll(lt);

  final RxBool _searchP = RxBool(false);
  bool get searchP => _searchP.value;
  set searchP(bool b) => _searchP.value = b;

  final RxList<ProductModel> _orders = RxList<ProductModel>();
  List<ProductModel> get orders => _orders;
  set orders(List<ProductModel> lt) => _orders.assignAll(lt);

  final Rx<XFile> _personPic = Rx<XFile>(XFile(''));
  XFile get personPic => _personPic.value;
  set personPic(XFile v) => _personPic.value = v;

  final Rx<Uint8List> _personPicM = Rx<Uint8List>(Uint8List(0));
  Uint8List get personPicM => _personPicM.value;
  set personPicM(Uint8List pic) => _personPicM.value = pic;

  final RxBool _memoryImg = RxBool(true);
  bool get memoryImg => _memoryImg.value;
  set memoryImg(bool b) => _memoryImg.value = b;

  final RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;
  set totalAmount(double str) => _totalAmount.value = str;

  final RxInt _invoiceNo = RxInt(0);
  int get invoiceNo => _invoiceNo.value;
  set invoiceNo(int i) => _invoiceNo.value = i;

  final Rx<ProfileModel> _profile = Rx(ProfileModel());
  ProfileModel get profile => _profile.value;
  set profile(ProfileModel v) => _profile.value = v;

  final RxString _search = "".obs;
  String get search => _search.value;
  set search(String str) => _search.value = str;
  final TextEditingController? textController = TextEditingController();

  final RxString _ssid = "".obs;
  String get ssid => _ssid.value;
  set ssid(String str) => _ssid.value = str;

  final RxString _bssid = "".obs;
  String get bssid => _bssid.value;
  set bssid(String str) => _bssid.value = str;

  final RxString _ip = "".obs;
  String get ip => _ip.value;
  set ip(String str) => _ip.value = str;

  // final RxString _apiUrl = "".obs;
  // String get apiUrl => _apiUrl.value;
  // set apiUrl(String str) => _apiUrl.value = str;

  final PaperSize paper = PaperSize.mm80;

  final LanScanner scanner = LanScanner();

  final RxList<Host> _hosts = <Host>[].obs;
  List<Host> get hosts => _hosts;
  set hosts(List<Host> h) => _hosts.assignAll(h);

  // late final Socket sock;

  @override
  void onInit() async {
    super.onInit();
    getDatabasesPath().then((value) => print("db pthj : $value"));
    await fetchProduct();
    await sellDB.fetchAll();
    fetchInvoiceNo();
    // await checkIp();
    // await fetchProfile();

    // await checkConnectivity();
    // connectLn();
    // ip = (await info.getWifiIP()).toString();
    // IOWebSocketChannel.connect('ws://100.120.187.127:8883');

    // sock = await Socket.connect(ip, 8883);
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchProduct();
  }

  @override
  void onClose() {
    super.onClose();
    _orders.close();
    _invoiceNo.close();
    _personPic.close();
    _totalAmount.close();
    _products.close();
    textController!.clear();
    productSearch.clear();
    searchP = false;
  }

  void connectionEst() async {
    try {
      final Dio dio = Dio();
      final response =
          await http.get(Uri.http('$ip:8883', "", {'cmd': "print"}));
      // handle the response here
      print(response.statusCode);
    } catch (e) {
      print('Error sending command to NodeMCU: $e');
    }
  }

  void tcpConn() async {
    // TcpSocketConnection socketConnection = TcpSocketConnection(ip, 8883);
    // socketConnection.enableConsolePrint(true);
    // if (await socketConnection.canConnect(30000, attempts: 30)) {
    //   await socketConnection.connect(30000, (String msg) {
    //     socketConnection.sendMessage("MessageIsReceived :D ");
    //   }, attempts: 30);
    // }

    await Socket.connect(ip, 8883).then((value) {
      value.writeln('Hello, server!');
    });

    runZoned(() async {
      // final server = await ServerSocket.bind(ip, 8883, shared: true);

      // if (kDebugMode) {
      //   print("server.address: ${server.address}");
      // }
      final server = await HttpServer.bind(ip, 8883);
      print(
          "server running on ip : ${server.address} on port : ${server.port}");

      // await for (final request in server) {
      //   print(request.requestedUri);

      //   request.response.writeln("hello world");
      //   await request.response.flush();
      //   await request.response.close();

      //   print("response served\n");
      // }

      // server.pipe();
      // await Socket.connect(server.address.address, server.port).then((value) {
      //   value.writeln("HI");

      // TcpSocketConnection socketConnection =
      //     TcpSocketConnection(server.address.address, 8883);

      // socketConnection.enableConsolePrint(true);
      // if (await socketConnection.canConnect(5000, attempts: 30)) {
      //   await socketConnection.connect(5000, (String msg) async {
      //     socketConnection.sendMessage("MessageIsReceived :D ");

      //   }, attempts: 30);
      // }
      // final dio = Dio();

      // final rs = await dio.get(
      //   "http://$ip:8883",
      // );

      // if (kDebugMode) {
      //   print(rs.statusCode);
      // }
      print(server.port.toString());
      final stream = NetworkAnalyzer.i.discover2(
          server.address.address
              .substring(0, server.address.address.lastIndexOf('.')),
          server.port,
          timeout: const Duration(milliseconds: 2000));

      stream.listen((NetworkAddress addr) async {
        if (addr.exists) {
          // log('Found device: ${addr.ip}');
          if (kDebugMode) {
            print('Found device: ${addr.ip}');
          }
          final profile = await CapabilityProfile.load();
          final printer = NetworkPrinter(paper, profile);

          final PosPrintResult res =
              // print(profile.name);
              await printer.connect(server.address.address,
                  port: 8883, timeout: const Duration(seconds: 120));
          Future.delayed(const Duration(seconds: 120));
          if (res == PosPrintResult.success) {
            print(server.connectionsInfo().total);
            testReceipt(printer);
            // printer.disconnect();
          }
          if (kDebugMode) {
            print('Print result: ${res.msg}');
          }

          // setState(() {
          devices.add(addr.ip);
          found = devices.length;
          // });
        }
      });
      // server.listen((client) {
      //   client.writeln("JI");

      //   handleConnection(client);
      // });
    });
    // if (kDebugMode) {
    //   print(sock.remoteAddress.address);
    // }
    // Socket.connect("ws://$ip", 8883).then((ss) {
    //   print(ss.address);
    //   print(ss.port);
    //   ss.writeln('Hello, World!');
    // });
    // Socket.connect(ip, 8883).then((socket) {
    //   print('Connected to: '
    //       '${socket.remoteAddress.address}:${socket.remotePort}');
    //   socket.destroy();
    // });
    // var socket = await WebSocket.connect('ws://$ip:8883/ws');
    // socket.add('Hello, World!');
    // var server = await HttpServer.bind('127.0.0.1', 4040);
    // server.listen((HttpRequest req) async {
    //   if (req.uri.path == '/ws') {
    //     var socket = await WebSocketTransformer.upgrade(req);
    //     socket.listen(handleMsg);
    //   }
    // });
  }

  void handleConnection(Socket client) {
    print('Connection from'
        ' ${client.remoteAddress.address}:${client.remotePort}');
    client.writeln('Who is there?');
    print(client.port.toString());
    // listen for events from the client
    client.listen(
      // handle data from the client
      (Uint8List data) async {
        await Future.delayed(Duration(seconds: 20));

        final message = String.fromCharCodes(data);
        // if (message == 'Knock, knock.') {
        //   client.write('Who is there?');
        // } else if (message.length < 10) {
        //   client.write('$message who?');
        // } else {
        //   client.write('Very funny.');
        //   client.close();
        // }
      },

      // handle errors
      onError: (error) {
        print(error);
        client.close();
      },

      // handle the client closing the connection
      onDone: () {
        print('Client left');
        // client.close();
      },
    );
  }

  Future<void> checkConnectivity() async {
    await Permission.nearbyWifiDevices.request();
    bssid = (await info.getWifiBSSID()).toString();
    ip = (await info.getWifiIP()).toString();
    if (bssid.isNotEmpty) {
      if (kDebugMode) {
        print(bssid);
        print("ip: $ip");
      }
      try {
        await provisioner.start(ProvisioningRequest.fromStrings(
          ssid: "Admin",
          bssid: bssid,
          password: "Admin1234",
          reservedData: "Hello from Dart",
        ));

        // provisioner.printInfo(
        //     info: "print", printFunction: GetUtils.printFunction);
        await Future.delayed(const Duration(seconds: 60));
        provisioner.stop();

        // discover();
      } catch (e, s) {
        if (kDebugMode) {
          print("$e, $s");
        }
      }
    }
  }

  void connectLn() {
    var stream = scanner.icmpScan(
      ip,
      timeout: Duration(seconds: 60),
      progressCallback: (progress) {
        print(' $ip');
      },
    );

    //  print('Host Length : ${hosts.length}');

    stream.listen((Host device) {
      hosts.add(device);
      print('device  : $device');
    });
  }

  fetchInvoiceNo() {
    if (box.read("invoiceNo") != null && box.read("invoiceNo") != "") {
      invoiceNo = box.read("invoiceNo");
    } else {
      box.write("invoiceNo", 10001);
    }
  }

  Future<void> fetchProduct() async {
    products.assignAll(await productDB.fetchAll());
  }

  Future<void> searchProduct(String name) async {
    productSearch.assignAll([]);

    for (var i = 0; i < products.length; i++) {
      searchP = true;

      if (products[i].name.toString().toLowerCase().contains(name)) {
        productSearch.add(products[i]);

        update();
        print(products[i].name);
      }
    }
    FocusScope.of(Get.context!).unfocus();
  }

  Future<void> all() async {
    textController!.clear();
    searchP = false;
    // productSearch = products;
    update();
  }

  removeItem(i) {
    orders[i].count = orders[i].count! - 1;
  }

  addItem(i) {
    orders[i].count = orders[i].count! + 1;
  }

  double totalAmountCal() {
    totalAmount = 0.0;
    if (orders.toSet().toList().isNotEmpty) {
      for (var i = 0; i < orders.toSet().toList().length; i++) {
        totalAmount += (int.tryParse(orders.toSet().toList()[i].price!)! *
                orders.toSet().toList()[i].count!)
            .toDouble();
      }
    }
    return totalAmount;
  }

  Future<void> onSave() async {
    for (var i = 0; i < orders.toSet().toList().length; i++) {
      await sellDB.create(
        invoiceId: "I${box.read("invoiceNo")}",
        productName: orders[i].name!,
        productWeight: orders[i].weight!,
        price: (int.tryParse(orders[i].price!)! * orders[i].count!).toString(),
        productId: orders[i].id.toString(),
        productQuantity: orders[i].count.toString(),
        receivingDate: DateTime.now().toIso8601String(),
      );
      final index = products
          .indexWhere((element) => element.id == orders.toSet().toList()[i].id);

      await productDB.update(
          id: products[index].id!,
          quantity: "${int.tryParse(products[index].quantity!)!}");
    }
    box.write("invoiceNo", box.read("invoiceNo") + 1);
    await fetchProduct();

    // setStatus();
    await checkIp();
  }

  handleProductQuantity(int i) {
    if (int.tryParse(products[i].quantity!)! >= 1) {
      products[i].count = products[i].count! + 1;
      products[i].quantity =
          (int.tryParse(products[i].quantity.toString())! - 1).toString();

      orders.add(products[i]);
      totalAmountCal();
      update();
    }
  }

  handleAddProductQuantity(int i) {
    if (int.tryParse(products[i].quantity!)! >= 1) {
      products[i].count = products[i].count! + 1;
      products[i].quantity =
          (int.tryParse(products[i].quantity.toString())! + 1).toString();

      orders.add(products[i]);
      totalAmountCal();
      update();
    }
  }

  itemAdd(int i) {
    if (orders.toSet().toList()[i].count! >= 1 &&
        orders.toSet().toList()[i].count! <=
            int.tryParse(orders.toSet().toList()[i].quantity.toString())!) {
      orders.toSet().toList()[i].count = orders.toSet().toList()[i].count! + 1;
      orders.add(orders.toSet().toList()[i]);
      final index = products
          .indexWhere((element) => element.id == orders.toSet().toList()[i].id);
      if (int.tryParse(products[index].quantity!)! >= 1) {
        products[index].quantity =
            (int.tryParse(products[index].quantity.toString())! - 1).toString();

        totalAmountCal();
        update();
      }
    }
  }

  itemSub(int i) {
    if (orders.toSet().toList()[i].count! >= 1) {
      orders.toSet().toList()[i].count = orders.toSet().toList()[i].count! - 1;
      orders.add(orders.toSet().toList()[i]);
      totalAmountCal();
      final index = products
          .indexWhere((element) => element.id == orders.toSet().toList()[i].id);

      if (int.tryParse(products[index].quantity!)! >= 1) {
        products[index].quantity =
            (int.tryParse(products[index].quantity.toString())! + 1).toString();

        totalAmountCal();
        update();
      }
    }
  }

  void getImage1() {
    Utils.showImagePicker(onGetImage: (image) {
      if (image != null) {
        personPic = image;
        memoryImg = false;
      }
    });
  }

  Future<void> fetchProfile() async {
    await profileDB.fetchAll().then((v) {
      if (v.isNotEmpty) {
        profile = v[1];
        personPicM = v[1].picture!;
        memoryImg = true;
      }
    });
  }

  void discover() async {
    // setState(() {

    // final channel =
    //     WebSocketChannel.connect(Uri.parse('http://100.120.187.127:8883'));

    // await channel.ready;

    // channel.stream.listen((message) {
    //   channel.sink.add('received!');
    //   channel.sink.close(1, "close");
    // });
    isDiscovering = true;
    devices.clear();
    found = -1;
    // });

    // String ip;
    try {
      ip = ip.toString();
      // log('local ip:\t$ip');
    } catch (e) {
      const snackBar = SnackBar(
          content: Text('WiFi is not connected', textAlign: TextAlign.center));
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      return;
    }
    // setState(() {
    localIp = ip;
    // });

    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = 8883;
    try {
      port = int.parse(portController.text);
    } catch (e) {
      portController.text = port.toString();
    }
    // log('subnet:\t$subnet, port:\t$port');

    final stream = NetworkAnalyzer.i
        .discover2(subnet, port, timeout: const Duration(milliseconds: 2000));

    stream.listen((NetworkAddress addr) async {
      if (addr.exists) {
        // log('Found device: ${addr.ip}');
        if (kDebugMode) {
          print('Found device: ${addr.ip}');
        }
        // setState(() {
        devices.add(addr.ip);
        found = devices.length;
        // });
      }
      await checkP();
    })
      ..onDone(() {
        // setState(() {
        isDiscovering = false;
        found = devices.length;
        // });
      })
      ..onError((dynamic e) {
        const snackBar = SnackBar(
            content: Text('Unexpected exception', textAlign: TextAlign.center));
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      });
  }

  Future<void> testReceipt(NetworkPrinter printer) async {
    printer.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: const PosStyles(codeTable: 'CP1252'));
    printer.text('Special 2: blåbærgrød',
        styles: const PosStyles(codeTable: 'CP1252'));

    printer.text('Bold text', styles: const PosStyles(bold: true));
    printer.text('Reverse text', styles: const PosStyles(reverse: true));
    printer.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    printer.text('Align left', styles: const PosStyles(align: PosAlign.left));
    printer.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    printer.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    printer.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    printer.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print image
    // final ByteData data = await rootBundle.load('assets/images/Paneer.png');
    // final Uint8List bytes = data.buffer.asUint8List();
    // final Image? image = decodeImage(bytes);
    // if (image != null) {
    //   printer.image(image);
    // }
    // Print image using alternative commands
    // printer.imageRaster(image);
    // printer.imageRaster(image, imageFn: PosImageFn.graphics);

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    printer.barcode(Barcode.upcA(barData));

    // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
    // printer.text(
    //   'hello ! 中文字 # world @ éphémère &',
    //   styles: PosStyles(codeTable: PosCodeTable.westEur),
    //   containsChinese: true,
    // );

    printer.feed(2);
    printer.cut();
  }

  Future<void> checkP() async {
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res =
        // print(profile.name);
        await printer.connect(ip,
            port: 8883, timeout: const Duration(seconds: 120));
    Future.delayed(const Duration(seconds: 120));
    if (res == PosPrintResult.success) {
      testReceipt(printer);
      printer.disconnect();
    }
    if (kDebugMode) {
      print('Print result: ${res.msg}');
    }
  }

  Future<void> checkIp() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 &&
            addr.address.startsWith('192')) {
          ip = addr.address.split(".").getRange(0, 3).join(".");
          for (var i = 0; i < 255; i++) {
            apiLopp(i);
          }
        }
      }
    }
  }

  apiLopp(int i) async {
    try {
      var res = await http.post(Uri.parse("http://$ip.$i/status"), body: {
        "print": "",
      });
      if (res.statusCode == 200) {
        // apiUrl = "http://$ip.$i/status";
        print(res.statusCode);
        print("http://$ip.$i/status");
        setStatus("http://$ip.$i/status");
      }
    } catch (e) {
      // apiLopp(i);
    }
  }

  void setStatus(String apiUrl) async {
    try {
      Runes input = Runes(' \u{20B9}');
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      final dir = await getApplicationDocumentsDirectory();
      // final file = File('${dir.path}/pdfFile');
      request.fields["print"] = """
  GENAMK INFO INDIA PVT LTD
  SOHNA ROAD, GURUGRAM
  GSTIN:29AAMFN3642F123 
  PH:080-23232323
  DATE: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  TIME: ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}
  BILL NO.: 10                
  - - - - - - - - - - - - - - - 
  SR.  ITEM NAME RATE QTY VALUE       
  ${orders.toSet().toList().map((e) {
        return """${e.id}.  ${e.name} Rs.${e.price}/-  ${e.count}  Rs.${int.parse(e.price!) * e.count!}/-""";
      })}

 """;

      var res = await request.send();

      if (res.statusCode == 200) {
        print(res.statusCode);
        orders.assignAll([]);
        totalAmount = 0.0;
      }
    } catch (e) {}
  }

  void createPrintPage() {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.standard
            .copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.ListView(
            children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text("Mak Life Dairy Store"),
              ),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text("Barnala"),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text("GSTIN: aqs221"),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Bill No.: 10"),
                    pw.Column(
                      children: [
                        pw.Text("Date: 10/02/24"),
                        pw.Text("Time: 10:56:57"),
                      ],
                    )
                  ],
                ),
              ),
              pw.Table(
                children: [
                  pw.TableRow(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                      ),
                      children: [
                        pw.Text("Sr."),
                        pw.Text("Item Name"),
                        pw.Text("Rate"),
                        pw.Text("Qty"),
                        pw.Text("Value"),
                      ]),
                  for (int i = 0; i < orders.toSet().length; i++)
                    pw.TableRow(children: [
                      pw.Text("${i + 1}"),
                      pw.Text("${orders[i].name}"),
                      pw.Text("${orders[i].price}"),
                      pw.Text("${orders[i].count}"),
                      pw.Text("${orders[i].price}"),
                    ]),
                ],
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Item: ${orders.toSet().length}"),
                    pw.Text("Amount: ${500}/-"),
                  ]),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text("INCLUSIVE OF ALL TAXES"),
              ),
              pw.Table(
                children: [
                  pw.TableRow(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                      ),
                      children: [
                        pw.Text("Tax%"),
                        pw.Text("B.Amt"),
                        pw.Text("SGST"),
                        pw.Text("CGST"),
                        pw.Text("Total"),
                      ]),
                  for (int i = 0; i < orders.toSet().length; i++)
                    pw.TableRow(children: [
                      pw.Text("${10}"),
                      pw.Text("${orders[i].price}"),
                      pw.Text("${10}"),
                      pw.Text("${10}"),
                      pw.Text("${500}"),
                    ]),
                ],
              ),
            ],
          ); // Center
        })); // Page
  }
}
