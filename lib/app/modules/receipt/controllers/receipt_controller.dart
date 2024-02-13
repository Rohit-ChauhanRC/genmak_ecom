import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptController extends GetxController {
  //
  final RxList<ProductModel> _orders = RxList<ProductModel>();
  List<ProductModel> get orders => _orders;
  set orders(List<ProductModel> lt) => _orders.assignAll(lt);

  final pdf = pw.Document();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    orders = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
                    pw.Text("Amount: ₹${500}/-"),
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

  void increment() => count.value++;
}
