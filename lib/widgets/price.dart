import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceView extends StatelessWidget {
  List<dynamic> rates;
  var _cur;

  PriceView({Key? key, required this.rates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: 'GBP');
    var cur = format.currencySymbol;
    this._cur = cur;
    return Container(
      decoration: BoxDecoration(
          color: Flavor.secondaryToDark,
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: (rates.length == 1)
          ? Column(
              children: [
                Text(cur + rates.elementAt(0)['staff_wage']),
                Divider(),
                Text('${rates.elementAt(0)['staff_hr']} Hrs')
              ],
            )
          : SizedBox(
              child: InkWell(
                onTap: () {
                  _showAllRates(context);
                },
                child: Text(
                  cur,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
    );
  }

  void _showAllRates(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Shift Rate Breakdown'),
            content: _priceContainer(),
          );
        });
  }

  Widget _priceContainer() {
    return Container(
      height: 200.0, // Change as per your requirement
      width: 200.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: rates.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                _cur,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              backgroundColor: Flavor.primaryToDark,
            ),
            title: Text(_cur + ' ${rates.elementAt(index)['staff_wage']}'),
            subtitle: Text(rates.elementAt(index)['staff_hr'] + 'Hrs'),
          );
        },
      ),
    );
  }
}
