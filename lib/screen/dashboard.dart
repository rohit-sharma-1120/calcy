import 'package:calcy/components/buttons.dart';
import 'package:calcy/model/calcy_button_data_model.dart';
import 'package:calcy/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String expression = "0";

  void _append(String input) {
    setState(() {
      if (expression == "0" || expression == "Error") {
        expression = input;
      } else {
        expression += input;
      }
    });
  }

  void _clear() {
    setState(() {
      if (expression == "0") {
        expression = "0";
      } else if (expression.length == 1) {
        expression = "0";
      } else {
        expression = expression.substring(0, expression.length - 1);
      }
    });
  }

  void _toggleLastNumberSign() {
    String tempExpression = expression;
    if (tempExpression.isEmpty) return;

    final operators = ['+', '-', '*', '/'];
    int lastOpIndex = -1;

    for (int i = tempExpression.length - 1; i >= 0; i--) {
      if (operators.contains(tempExpression[i])) {
        lastOpIndex = i;
        break;
      }
    }

    String prefix =
        lastOpIndex == -1 ? '' : tempExpression.substring(0, lastOpIndex + 1);
    String lastTerm = tempExpression.substring(lastOpIndex + 1);

    if (lastTerm.startsWith('(-') && lastTerm.endsWith(')')) {
      lastTerm = lastTerm.substring(2, lastTerm.length - 1);
    } else if (lastTerm.startsWith('(') &&
        lastTerm.endsWith(')') &&
        lastTerm.contains('-')) {
      lastTerm = lastTerm.substring(1, lastTerm.length - 1);
    }

    if (lastTerm.startsWith('-')) {
      lastTerm = lastTerm.substring(1);
    } else {
      lastTerm = '-$lastTerm';
    }

    lastTerm = '($lastTerm)';
    setState(() {
      expression = prefix + lastTerm;
    });
  }

  void _evaluate() {
    try {
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(
        expression.replaceAll("×", "*").replaceAll("÷", "/"),
      );
      double result = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        expression = result.toString();
        if (expression.endsWith(".0")) {
          expression = expression.replaceAll(".0", "");
        }
      });
    } catch (e) {
      setState(() {
        expression = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                expression,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildButtonColumns(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtonColumns(BuildContext context) {
    final buttonData = [
      [
        expression == "0"
            ? CalcyButtonData.text("AC", CalcyColors.grey, _clear)
            : CalcyButtonData.icon(
              CupertinoIcons.minus_circle,
              Colors.grey,
              _clear,
            ),
        CalcyButtonData.text("7", CalcyColors.darkCharcoal, () => _append("7")),
        CalcyButtonData.text("4", CalcyColors.darkCharcoal, () => _append("4")),
        CalcyButtonData.text("1", CalcyColors.darkCharcoal, () => _append("1")),
        CalcyButtonData.icon(Icons.abc_outlined, CalcyColors.darkCharcoal, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Feature not available yet."),
              duration: Duration(seconds: 1),
            ),
          );
        }),
      ],
      [
        CalcyButtonData.text("+/-", CalcyColors.grey, _toggleLastNumberSign),
        CalcyButtonData.text("8", CalcyColors.darkCharcoal, () => _append("8")),
        CalcyButtonData.text("5", CalcyColors.darkCharcoal, () => _append("5")),
        CalcyButtonData.text("2", CalcyColors.darkCharcoal, () => _append("2")),
        CalcyButtonData.text("0", CalcyColors.darkCharcoal, () => _append("0")),
      ],
      [
        CalcyButtonData.icon(
          Icons.percent,
          CalcyColors.grey,
          () => _append("%"),
        ),
        CalcyButtonData.text("9", CalcyColors.darkCharcoal, () => _append("9")),
        CalcyButtonData.text("6", CalcyColors.darkCharcoal, () => _append("6")),
        CalcyButtonData.text("3", CalcyColors.darkCharcoal, () => _append("3")),
        CalcyButtonData.text(".", CalcyColors.darkCharcoal, () => _append(".")),
      ],
      [
        CalcyButtonData.text("/", CalcyColors.orange, () => _append("÷")),

        CalcyButtonData.icon(
          Icons.close,
          CalcyColors.orange,
          () => _append("×"),
        ),
        CalcyButtonData.icon(
          Icons.remove,
          CalcyColors.orange,
          () => _append("-"),
        ),
        CalcyButtonData.icon(Icons.add, CalcyColors.orange, () => _append("+")),
        CalcyButtonData.text("=", CalcyColors.orange, _evaluate),
      ],
    ];

    return buttonData
        .map(
          (column) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: column.map((data) => _buildButton(data)).toList(),
          ),
        )
        .toList();
  }

  Widget _buildButton(CalcyButtonData data) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CalcyButton(
        color: data.color,
        onTap: data.onTap,
        child:
            data.icon != null
                ? Icon(data.icon, color: Colors.white)
                : Text(
                  data.label!,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
      ),
    );
  }
}
