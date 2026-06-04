import '../models/movie.dart';

// Khởi tạo danh sách phim mẫu tĩnh (Static Sample Data) để test giao diện
final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Dune: Part Two',
    posterUrl: 'https://picsum.photos/id/10/600/400', // Sử dụng ảnh từ picsum làm banner
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: ['Official Trailer #1', 'IMAX Behind the Scenes', 'Final Epic Trailer'],
  ),
  Movie(
    id: '2',
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://picsum.photos/id/15/600/400',
    overview: 'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: ['Action', 'Comedy', 'Sci-Fi'],
    rating: 8.3,
    trailers: ['Red Band Teaser', 'Official Trailer #2'],
  ),
  Movie(
    id: '3',
    title: 'Inception',
    posterUrl: 'https://picsum.photos/id/20/600/400',
    overview: 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea.',
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    rating: 8.8,
    trailers: ['Main Theatrical Trailer', '10th Anniversary Promo'],
  ),
];