import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w10_practice_firebase_part_2/ui/screens/library/view_model/library_view_model.dart';
import '../view_model/library_item_data.dart';

class LibraryItemTile extends StatelessWidget {
  const LibraryItemTile({
    super.key,
    required this.data,
    required this.isPlaying,
    required this.onTap,
  });

  final LibraryItemData data;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
     final vm = context.read<LibraryViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(data.song.title),
          subtitle: Row(
            children: [
              Text("${data.song.duration.inMinutes} mins"),
              SizedBox(width: 20),
              Text(data.artist.name),
              SizedBox(width: 20),
              Text(data.artist.genre),
               Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      vm.likeSong(data.song);
                    },
                  ),
                  Text("${data.song.like}"),
                ],
              ),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data.song.imageUrl.toString()),
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
