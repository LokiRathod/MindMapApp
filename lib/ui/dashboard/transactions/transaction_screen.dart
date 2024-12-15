import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/ui/dashboard/transactions/transaction_controller.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/custom_widgets/custom_app_bar_action.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionController _transactionController = Get.put(TransactionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MindMapColors.colorPrimary,
      appBar: CustomAppBar(
        title: StringConstants.TRANSACTIONS_,
        color: MindMapColors.colorApp,
        onBackPressed: () {Get.back();},
        onPressed: () {_transactionController.commonFunctions.logoutCall();},
      ),
      body: SingleChildScrollView(
        child: Container(
          color: MindMapColors.colorWhite,
          child: Column(
            children: [
              _transactionListView(context),
            ],
          ),
        ),
      ),
    );
  }



  // transaction list
  Widget _transactionListView(BuildContext context) {
    return Obx(() => (_transactionController.posts.isNotEmpty) ?
    Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _transactionController.posts.length,
          itemBuilder: (context, index) {
            var dataInfo = _transactionController.posts[index];
            return (_transactionController.posts.isEmpty) ? Container() :
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // Show success/failure UI
                Get.bottomSheet(
                  bottomSheetContainer(dataInfo.id),
                );

              },
              child: Column(
                children: [
                  _transactionItemView(dataInfo),
                  Padding(padding: const EdgeInsets.only(left: 1.0, top: 6.0, right: 1.0, bottom: 5.0),
                    child: Container(
                      height: 0.5,
                      color: MindMapColors.colorBlack20,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
    ): Container(),
    );
  }

  Widget _transactionItemView(var dataInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.check_circle, size: 24.0, color: MindMapColors.colorGreen60,),
                    ),
                    Text(
                      StringConstants.TRANSACTIONS_,
                      style: TextStylesConstants.textStyleBlack_14,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text(
                    _transactionController.dataMapService.getFormattedDateString(""),
                    style: TextStylesConstants.textStyleBoldBlack_10,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 10.0, bottom: 5.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(_transactionController.commonFunctions.currencyNumberFormat(dataInfo.id),
                style: TextStylesConstants.textStyleBlack_12,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheetContainer(var amount) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0,),
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.check_circle, size: 66.0, color: MindMapColors.colorGreen60,),
            ),
            const SizedBox(height: 20.0,),
            Text("${StringConstants.TRANSACTION_SUCCESSFULLY}\n with amount  \$ ${amount.toString()}",
                style: TextStylesConstants.textStyleBoldBlack_18, textAlign: TextAlign.center,),
            const SizedBox(height: 20.0,),
            Text(StringConstants.TRANSACTION_SUCCESSFULLY_MSG,
                style: TextStylesConstants.textStyleBoldBlack_14),
            const SizedBox(height: 30.0,),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text(StringConstants.CLOSE, style: TextStylesConstants.textStyleBoldBlack_14),
            ),
          ],
        ),
      ),
    );
  }

}
