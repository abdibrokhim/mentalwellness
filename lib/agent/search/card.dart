import 'package:flutter/material.dart';
import 'package:mentalwellness/utils/shared.dart';

import '../model/agent.model.dart';

class AgentBubbleCard extends StatelessWidget {
  final AgentModel agent;
  final VoidCallback onOpenProfile;

  const AgentBubbleCard({
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
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
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
                    child: Text(agent.name, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),),
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        child: Text('By ${agent.createdBy} • ', maxLines: 1, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
                      ),
                      const SizedBox(width: 4.0),
                      Icon(Icons.chat_rounded, size: 16.0, color: const Color.fromARGB(255, 0, 0, 0)),
                      const SizedBox(width: 4.0),
                      SizedBox(
                        child: Text('${formatNumber(agent.conversationCount)}+', maxLines: 1, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
                      ),
                    ],
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

class AgentBubbleCardSec extends StatelessWidget {
  final AgentModel agent;
  final VoidCallback onOpenProfile;

  const AgentBubbleCardSec({
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
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 40,
                height: 40,
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
                    child: Text(agent.name, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),),
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