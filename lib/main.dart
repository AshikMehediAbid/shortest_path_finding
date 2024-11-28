import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nov19_demo1/widget/custom_box.dart';
import 'package:nov19_demo1/model/custom_box_model.dart';

void main() {
  runApp(const MyApp());

}

class Pair<T1, T2> {
  final T1 ff;
  final T2 ss;

  Pair(this.ff, this.ss);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Minimum Path Finding App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String number = "";

  int type = 1;
  int from_x=0 , from_y=0;
  int to_x=0 , to_y=0;
  int row = 23 , column = 12;
  late List<String> boxList;
  late List<List<CustomBoxModel> > myList;

  @override
  void initState() {
    boxList  = [];
    List<String> initialBoxList  = ["1","2","3","4"];
    bool tapped = false;
    myList = List.generate((row+2) , (i) => List.generate((column+2),(j)=> CustomBoxModel(visited: false, tapped: false, clr: Colors.blueGrey,row: i,column: j,depth: 0)));

    List<List<List<Set<int>>> >newList = List.generate(row+2, (i) => List.generate(column+2,(j)=> []));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(

          child: ListView(
            children: [

              Row(
                children: [

                  TextButton(
                    onPressed:(){

                               },
                      child: Text(""),
                  ),
                ],

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black
                        )
                    ),
                    child: TextButton(
                      onPressed:(){
                        setState(() {
                          type = 1;
                        });

                      },
                      child:Text("From",style: TextStyle(color:Colors.white ),),

                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black
                        )
                    ),
                    child: TextButton(
                      onPressed:(){
                        setState(() {
                          type = 2;
                        });
                      },
                      child:Text("Obstacle",style: TextStyle(color:Colors.white ),),

                    ),
                  ),


                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black
                        )
                    ),
                    child: TextButton(
                      onPressed:(){
                        setState(() {
                          type = 3;
                        });
                      },
                      child:Text("To"),

                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black
                        )
                    ),
                    child: TextButton(
                      onPressed:(){


                        Queue<Pair<int,int>> q = Queue<Pair<int, int>>();

                        //print(">>>>>>>>>>>>>>>>>${myList[13][0].depth}");

                        q.add(Pair(from_x,from_y));

                        while(q.length!= 0)
                        {

                          ///  print("Length: ${q.length}");
                          int px = q.first.ff;
                          int py = q.first.ss;
                          myList[px][py].visited = true;
                          q.removeFirst();

                          if(py+1<column)
                          {
                            if(px == to_x && py+1 == to_y ){myList[px][py+1].depth = myList[px][py].depth+1;break;}
                            else if(myList[px][py+1].tapped == false && myList[px][py+1].visited == false)
                            {
                              myList[px][py+1].depth = myList[px][py].depth+1;
                              myList[px][py+1].visited = true;
                              q.add(Pair(px, py+1));
                              print("W");
                            }

                          }


                          if(py-1>=0)
                          {
                            if(px == to_x && py-1 == to_y){myList[px][py-1].depth = myList[px][py].depth+1;break;}
                            else if(myList[px][py-1].tapped == false && myList[px][py-1].visited == false)
                            {
                              myList[px][py-1].depth = myList[px][py].depth+1;
                              myList[px][py-1].visited = true;
                              q.add(Pair(px, py-1));
                            }

                          }

                          print("B");


                          if(px+1< row)
                          {
                            if(px+1 == to_x && py == to_y){myList[px+1][py].depth = myList[px][py].depth+1;break;}
                            else if(myList[px+1][py].tapped == false && myList[px+1][py].visited == false)
                            {
                              myList[px+1][py].depth = myList[px][py].depth+1;
                              myList[px+1][py].visited = true;
                              q.add(Pair(px+1, py));
                            }

                          }

                          print("C");


                          if(px-1>=0)
                          {
                            if(px-1 == to_x && py == to_y){myList[px-1][py].depth = myList[px][py].depth+1;break;}
                            else if(myList[px-1][py].tapped == false && myList[px-1][py].visited == false)
                            {
                              myList[px-1][py].depth = myList[px][py].depth+1;
                              myList[px-1][py].visited = true;
                              q.add(Pair(px-1, py));
                            }

                          }
                          print("D");


                          if( px+1<row && py+1<column)
                          {
                            if(px+1==to_x && py+1==to_y){myList[px+1][py+1].depth = myList[px][py].depth+1;break;}
                            else if(myList[px+1][py+1].tapped == false && myList[px+1][py+1].visited == false)
                            {
                              myList[px+1][py+1].depth = myList[px][py].depth+1;
                              myList[px+1][py+1].visited = true;
                              q.add(Pair(px+1, py+1));
                            }

                          }

                          print("E");
                          if(px-1 >= 0 && py-1>=0 )
                          {
                            if(px-1 == to_x && py-1 == to_y){myList[px-1][py-1].depth = myList[px][py].depth+1;break;}
                            else if(myList[px-1][py-1].tapped == false && myList[px-1][py-1].visited == false)
                            {
                              myList[px-1][py-1].depth = myList[px][py].depth+1;
                              myList[px-1][py-1].visited = true;
                              q.add(Pair(px-1, py-1));
                            }

                          }
                          print("F");

                          if( px+1<row&& py-1>=0 )
                          {
                            if(px+1 == to_x && py-1 == to_y){myList[px+1][py-1].depth = myList[px][py].depth+1;break;}
                            else if(myList[px+1][py-1].tapped == false && myList[px+1][py-1].visited == false)
                            {
                              myList[px+1][py-1].depth = myList[px][py].depth+1;
                              myList[px+1][py-1].visited = true;
                              q.add(Pair(px+1, py-1));
                            }

                          }
                          print("G");


                          if(px-1 >= 0 && py+1<column )
                          {
                            if(px-1 == to_x && py+1 == to_y){myList[px-1][py+1].depth = myList[px][py].depth+1;break;}
                            else if(myList[px-1][py+1].tapped == false && myList[px-1][py+1].visited == false)
                            {
                              myList[px-1][py+1].depth = myList[px][py].depth+1;
                              myList[px-1][py+1].visited = true;
                              q.add(Pair(px-1, py+1));
                            }

                          }
                          print("H");

                        }
/*
                        for (int i = 0; i < row; i++) {
                          String row = "";
                          for (int j = 0; j < column; j++) {
                            row += "${myList[i][j].depth} ";
                          }
                          print(row.trim());
                        } */

                        int X = to_x , Y = to_y;

                        int k = 0;

                        while(5==5)
                        {
                          k++;
                          if(k==100)break;
                          if(X== from_x && Y==from_y)
                          {
                            setState(() {
                              myList[X][Y].clr = Colors.lightGreenAccent;
                            });
                            break;
                          }

                          setState(() {
                            myList[X][Y].clr = Colors.lightGreenAccent;
                          });


                          int f = 0;

                          if(Y+1<column)
                          {
                            if(myList[X][Y+1].depth+1 == myList[X][Y].depth && myList[X][Y+1].tapped == false ){Y++; f = 1; }
                          }

                          if(Y-1>=0 && f==0)
                          {
                            if(myList[X][Y-1].depth+1 == myList[X][Y].depth && myList[X][Y-1].tapped == false ){Y--; f= 1;}
                          }

                          if(X+1<row && f==0)
                          {
                            if(myList[X+1][Y].depth+1 == myList[X][Y].depth && myList[X+1][Y].tapped == false){X++; f= 1; }

                          }

                          if(X-1>=0 && f==0)
                          {
                            if(myList[X-1][Y].depth+1 == myList[X][Y].depth && myList[X-1][Y].tapped == false ){X--; f = 1; }

                          }

                          if( X+1<row && Y+1<column && f==0 )
                          {
                            if(myList[X+1][Y+1].depth+1 == myList[X][Y].depth && myList[X+1][Y+1].tapped == false ){X++;Y++; f = 1; }

                          }

                          if(X-1 >= 0 && Y-1>=0 && f==0 )
                          {
                            if(myList[X-1][Y-1].depth+1 == myList[X][Y].depth && myList[X-1][Y-1].tapped == false ){X--; Y--; f=1; }

                          }

                          if( X+1<row && Y-1>=0 && f==0 )
                          {
                            if(myList[X+1][Y-1].depth+1 == myList[X][Y].depth && myList[X+1][Y-1].tapped == false){X++; Y--; f=1; }

                          }

                          if(X-1 >= 0 && Y+1<column && f==0)
                          {
                            if(myList[X-1][Y+1].depth+1 == myList[X][Y].depth && myList[X-1][Y+1].tapped == false ){X--; Y++;f=1; }

                          }

                        }
                        setState(() {
                          myList[to_x][to_y].clr = Colors.yellowAccent;
                          myList[from_x][from_y].clr = Colors.blueAccent;

                        });


                      },
                      child:Text("Minimum Distance"),

                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        for(int i = 0;i<row;i++)
                          Row(
                            children: [

                              for(int j = 0 ; j<column;j++)
                                GestureDetector(

                                  //  tapped = false;

                                  onTap: (){
                                    setState(() {
                                      //print("Type: $type");

                                      if(type==1)
                                      {
                                        myList[i][j].clr = Colors.blueAccent;
                                        from_x = i;
                                        from_y = j;
                                        type = 5;
                                      }
                                      else if(type ==3)
                                      {
                                        myList[i][j].clr = Colors.yellowAccent;
                                        to_x = i;
                                        to_y = j;
                                        type = 5;
                                      }
                                      else
                                      {
                                        if(myList[i][j].tapped == false) {
                                          myList[i][j].tapped = true;
                                          myList[i][j].clr = Colors.redAccent;
                                        }
                                        else{
                                          myList[i][j].tapped = false;
                                          myList[i][j].clr = Colors.blueGrey;
                                        }
                                      }

                               /*
                                      for (int i = 0; i < row; i++) {
                                        String row = "";
                                        for (int j = 0; j < column; j++) {
                                          if(myList[i][j].depth<10)
                                            row += "x${myList[i][j].depth} ";
                                          else
                                            row += "${myList[i][j].depth} ";
                                        }
                                        print(row.trim());
                                      }

                               */

                                    });
                                    // tapped = false;
                                  },


                                  child: CustomBox(customBoxModel: CustomBoxModel(visited: myList[i][j].visited, tapped: myList[i][j].tapped, clr: myList[i][j].clr, row: i,column: j,depth: myList[i][j].depth),),



                                ),

                            ],


                          ),



                      ],

                    ),
                  ),
                ),
              ),




            ],


          ),




        ),
      ),

    );
  }
}













/*

/// Searches for a word in the Trie.
bool search(String word) {
  TrieNode? currentNode = _getNode(word);
  return currentNode != null && currentNode.isEndOfWord;
}
/// Checks if there are any words in the Trie that start with the given prefix.
bool startsWith(String prefix) {
  return _getNode(prefix) != null;
}
/// Helper function to retrieve the node corresponding to the last character of the prefix.
TrieNode? _getNode(String prefix) {
  TrieNode currentNode = root;
  for (int i = 0; i < prefix.length; i++) {
    String char = prefix[i];
    if (!currentNode.children.containsKey(char)) {
      return null; // Prefix not found.
    }
    currentNode = currentNode.children[char]!;
  }
  return currentNode;
}
/// Returns all words in the Trie that start with the given prefix.
List<String> getWordsWithPrefix(String prefix) {
  List<String> results = [];
  TrieNode? currentNode = _getNode(prefix);
  if (currentNode == null) {
    return results; // If no prefix matches, return an empty list.
  }
  _dfs(currentNode, prefix, results);
  return results;
}
/// Depth-first search to collect words from a given node.
void _dfs(TrieNode node, String prefix, List<String> results) {
  if (node.isEndOfWord) {
    results.add(prefix); // Add word to the results.
  }
  node.children.forEach((char, childNode) {
    _dfs(childNode, prefix + char, results);
  });
}
}
*/
