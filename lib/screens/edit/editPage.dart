import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/utils/time.dart';

class EditPageArguments extends Object {
  final DateTime date;

  EditPageArguments(this.date);
}

class EditPage extends StatefulWidget {
  static const routeName = '/edit';

  final EditPageArguments args;

  const EditPage({required this.args, Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  double price = 10000;
  String title = '';
  TimeOfDay time = TimeOfDay.fromDateTime(DateTime.now().toLocal());

  @override
  void initState() {
    super.initState();
    _controller.value = _controller.value.copyWith(
      text: price.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(8),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  style: Theme.of(context).textTheme.caption,
                  decoration: const InputDecoration(
                    hintText: '소비 정보를 입력하세요',
                    hintStyle: TextStyle(color: grey138),
                  ),
                  onChanged: (newValue) => setState(() {
                    title = newValue;
                  }),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '비워둘 수 없습니다!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.caption,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '비워둘 수 없습니다!';
                    } else if (int.tryParse(value) == null) {
                      return '숫자여야 합니다!';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      price = double.parse(newValue);
                    });
                  },
                ),
                Slider(
                  value: price,
                  min: 0,
                  max: 1000000,
                  divisions: 100000,
                  label: price.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      price = value;
                      _controller.value = _controller.value.copyWith(
                        text: value.toStringAsFixed(0),
                      );
                    });
                  },
                ),
                ElevatedButton(
                  child: Text(time.format(context)),
                  onPressed: () async {
                    TimeOfDay? selected = await showTimePicker(
                        context: context, initialTime: time);
                    setState(() {
                      time = selected != null ? selected : time;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Valitime will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        DateTime currentDate = changeTime(DateTime.now(), time);
                        // print('submit');
                        bloc.addPayment(PaymentInfo(
                            title: title,
                            time: currentDate,
                            price: price.toInt()));
                        bloc.editTotalUseOfCurrentSession(price.toInt());
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
