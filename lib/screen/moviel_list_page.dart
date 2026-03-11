import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'moviel_detail_page.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          return MovieItemCard(movie: movie);
        },
      ),
    );
  }
}

class MovieItemCard extends StatefulWidget {
  final MovieModel movie; 

  const MovieItemCard({super.key, required this.movie});

  @override
  State<MovieItemCard> createState() => _MovieItemCardState();
}

class _MovieItemCardState extends State<MovieItemCard> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: widget.movie),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.movie.imgUrl, 
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text('${widget.movie.year} | ${widget.movie.genre}', style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(widget.movie.rating.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAdded ? Colors.blue : Colors.white,
                        side: BorderSide(color: isAdded ? Colors.blue : Colors.grey),
                        elevation: 0,
                      ),
                      onPressed: () {
                        setState(() {
                          isAdded = !isAdded;
                        });
                      },
                      child: Text(
                        isAdded ? 'Added' : 'Add to List',
                        style: TextStyle(color: isAdded ? Colors.white : Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}