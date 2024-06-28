import 'package:flutter/material.dart';

import '../model/agent.model.dart';

class AgentCard extends StatelessWidget {
  final AgentModel agent;
  final VoidCallback onOpenProfile;

  const AgentCard({
    required this.agent, 
    required this.onOpenProfile,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenProfile,
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              spreadRadius: 2.0,
              offset: Offset(0, 2),
            ),
          ],
        
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(agent.imageUrl),
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 32 - 150 - 16 - 16,
                    child: Text(agent.name, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 32 - 150 - 16 - 16,
                    child: Text(agent.description, overflow: TextOverflow.ellipsis, maxLines: 2, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 32 - 150 - 16 - 16,
                    child: Text(agent.skills.join(', '), overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}