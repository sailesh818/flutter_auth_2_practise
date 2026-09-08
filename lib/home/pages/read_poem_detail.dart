import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadPoemDetail extends StatefulWidget {
  final DocumentSnapshot poem;
  const ReadPoemDetail({super.key, required this.poem});

  @override
  State<ReadPoemDetail> createState() => _ReadPoemDetailState();
}

class _ReadPoemDetailState extends State<ReadPoemDetail> {
  @override
  Widget build(BuildContext context) {
    final data = widget.poem.data() as Map<String, dynamic>;
    Timestamp? timestamp = data["createdAt"];
    String uploadDate = "";

    if(timestamp != null){
      final date = timestamp.toDate();
      uploadDate = "${date.day}/${date.month}/${date.year}";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data["title"] ?? "Poem Detail"),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              data["image"] ?? "",
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
              errorBuilder: (_,_,_){
                return Container(
                  height: 280,
                  color: Colors.grey,
                  child: Center(
                    child: Icon(Icons.image, size: 70,),
                  ),
                );

              },
            ),

            Padding(padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data["title"] ?? "", style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),),
                Text("By ${data["author"] ?? ""}", style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
                ),),

                Chip(label: Text(data["category"] ?? "")),
                Text("Description", style: TextStyle(fontSize: 17),),

                Text(data["description"] ?? "", style: TextStyle(
                  fontSize: 16,
                  
                ),),

                Text("Poem", style: TextStyle(fontSize: 17),),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text(
                    data["poem"] ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.7,
                    ),
                  ),
                ),

                

                if ((data["video"] ?? "").toString().isNotEmpty)
                Text("Video", style: TextStyle(fontSize: 17),),
                SelectableText(
                  data["video"],
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),

                Text("Tags", style: TextStyle(fontSize: 17),),

                Wrap(
                  spacing: 8,
                  children: (data["tags"] ?? "").toString().split(",").where(
                    (tag) => tag.trim().isNotEmpty
                  ).map(
                    (tag) => Chip(label: Text(tag.trim())),
                  ).toList(),
                ),

                Text("Uploaded: $uploadDate",
                style: TextStyle(color: Colors.grey),)

                
              ],

              
            ),
            
            )
          ],
        ),
      ),
    );
  }
}