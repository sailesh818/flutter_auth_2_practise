import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/home/pages/read_poem_detail.dart';

class ReadPoemPage extends StatefulWidget {
  const ReadPoemPage({super.key});

  @override
  State<ReadPoemPage> createState() => _ReadPoemPageState();
}

class _ReadPoemPageState extends State<ReadPoemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("poems").orderBy("createdAt", descending: true).snapshots(), 
        builder: (context, snapshot){

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No poems found"),
            );
          }

          final poems = snapshot.data!.docs;
          return ListView.builder(
            itemCount: poems.length,
            itemBuilder: (context, index){
              final poem = poems[index];

              return Card(
                margin: EdgeInsets.only(bottom: 15),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),

                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPoemDetail(poem: poem)));
                  },

                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15)
                        ),

                        child: Image.network(
                          poem["image"],
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace){
                            return Container(
                              height: 220,
                              color: Colors.grey,
                              child: Center(
                                child: Icon(Icons.image, size: 60,),
                              ),
                            );


                          },
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(poem["title"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text("By ${poem["author"]}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey),),
                          Text(poem["description"], maxLines: 3, overflow: TextOverflow.ellipsis,),
                          Chip(label: Text(poem["category"]))

                        ],
                      ),
                      )
                    ],
                  ),
                ),


              );
            }
          );
        }
      ),
    );
  }
}