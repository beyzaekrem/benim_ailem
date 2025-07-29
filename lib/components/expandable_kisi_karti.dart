import 'package:flutter/material.dart';

class ExpandableKisiKarti extends StatefulWidget {
  final String title;
  final String name;
  final String? image;
  final List<String> altBirimler;

  const ExpandableKisiKarti({
    super.key,
    required this.title,
    required this.name,
    this.image,
    required this.altBirimler,
  });

  @override
  State<ExpandableKisiKarti> createState() => _ExpandableKisiKartiState();
}

class _ExpandableKisiKartiState extends State<ExpandableKisiKarti> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: widget.image != null
                  ? AssetImage(widget.image!)
                  : null,
              radius: 24,
              backgroundColor: Colors.grey.shade300,
              child: widget.image == null ? Icon(Icons.person) : null,
            ),
            title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(widget.name),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded && widget.altBirimler.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.altBirimler.map((birim) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("• $birim", style: TextStyle(color: Colors.grey[800])),
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
