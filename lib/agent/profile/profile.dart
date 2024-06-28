import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentalwellness/agent/profile/rating_bar.dart';
import 'package:mentalwellness/utils/shared.dart';

import '../model/agent.model.dart';

class AgentProfile extends StatelessWidget {
  final AgentModel agent;
  final VoidCallback onStartConversation;

  const AgentProfile({
    required this.agent, 
    required this.onStartConversation,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Color.fromARGB(0, 255, 255, 255)),
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0,),
        child: SingleChildScrollView(
          child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(agent.imageUrl),
                radius: 50,
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(agent.name, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(agent.createdBy, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(agent.description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('${calculateAverageRating(agent.rating)}', style: const TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 0, 0, 0)),),
                      const SizedBox(height: 8.0),
                      Text('Rating', style: const TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 0, 0, 0)),),
                    ],
                  ),
                ),
                // const SizedBox(width: 8.0),
                Container(
                  height: 54.0,
                  width: 1.0,
                  color: Colors.black,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child:
                Column(
                  children: [
                    Text('${agent.category.join(', ')}', style: const TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 0, 0, 0)),),
                    const SizedBox(height: 8.0),
                    Text('Category', style: const TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 0, 0, 0)),),
                  ],
                ),
                ),
                const SizedBox(width: 16.0),
                Container(
                  height: 54.0,
                  width: 1.0,
                  color: Colors.black,
                ),
                // const SizedBox(width: 8.0),
                Expanded(
                  child:
                Column(
                  children: [
                    Text('${formatNumber(agent.conversationCount)}+', style: const TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 0, 0, 0)),),
                    const SizedBox(height: 8.0),
                    Text('Conversations', style: const TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 0, 0, 0)),),
                  ],
                ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Text('Conversation starters', textAlign: TextAlign.left, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                  Row(
                    children: agent.conversationStarters.map((starter) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        label: Text(starter, style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),),
                      ),
                    )).toList(),
                  ),
                ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text('Ratings', style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: RatingBar(ratings: agent.rating),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text('Capabilites', style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: agent.skills.map((starter) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("• ${starter}", style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),),
                    )).toList(),
                ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: 
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: onStartConversation,
                child: const Text('Start chat'),
              ),
            ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
      ),
    );
  }
}

