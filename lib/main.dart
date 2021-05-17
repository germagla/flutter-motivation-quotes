import 'package:flutter/material.dart';
import 'package:quotes/quote_model.dart';
import 'package:quotes/quotes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspirational Quotes',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Inspirational Quotes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _quoteList = <Quote>[];
  final _saved = <Quote>[];

  Widget _buildQuoteCard(Quote quote) {
    final alreadySaved = _saved.contains(quote);
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${quote.getContent()}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      quote.getAuthor(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    alreadySaved ? _saved.remove(quote) : _saved.add(quote);
                  });
                },
                icon:
                    Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
                color: alreadySaved ? Colors.red : null,
              ),
            ],
          ),
        ));
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return WillPopScope(child:StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          final quoteCards = _saved.map((quote) {
            final alreadySaved = _saved.contains(quote);
            return Card(
                margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${quote.getContent()}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              quote.getAuthor(),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _saved.remove(quote);

                          });
                        },
                        icon: Icon(alreadySaved
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: alreadySaved ? Colors.red : null,
                      ),
                    ],
                  ),
                ));
          }).toList();
          return Scaffold(
            appBar: AppBar(title: Text('Saved Quotes')),
            body: ListView(children: quoteCards),
          );
        }), onWillPop: onWillPop);
      },
      maintainState: true,
    ));
  }

  Future<bool> onWillPop() async{
    setState(() {

    });
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)],
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        if (i >= _quoteList.length) {
          for (int i = 0; i < 10; i++) {
            _quoteList.add(Quotes.getRandom());
          }
        }
        return _buildQuoteCard(
          _quoteList[i],
        );
      }),
    );
  }
}
