Tech Shelf is a mobile application designed for users to explore books related to the IT field. The app offers a search functionality where users can input relevant keywords to view a list of books. Users can select a book to view detailed information and have the option to mark it as a favorite. All favorite books can be accessed on a dedicated screen by clicking the favorite icon on the home screen. Additionally, users can toggle between light and dark modes for a personalized viewing experience.

The application is built following clean architecture principles, ensuring clear separation between the UI, business logic, and data layers. State management is handled using the flutter_bloc package.

Key features and tools used in the application include:

1. API Handling: dio, retrofit, json_annotation, and json_serializable for API calls and data serialization.
2. Image Rendering: cached_network_image to efficiently load and display images.
3. Responsiveness Testing: device_preview to ensure the app's responsiveness across devices.
4. Icon Management: font_awesome_flutter for icons.
5. Animations: animations and lottie for adding animations to the app.
6. Rating Display: flutter_rating_bar for showing book ratings.
7. Local Storage: shared_preferences for saving and loading user preferences, including favorite books.
8. App Icon Customization: flutter_launcher_icons to customize the app icon.

User Flow:

1. The app starts with a Welcome Screen, where users can click the "Explore Library" button to navigate to the Home Screen.
2. On the Home Screen, users can toggle between light and dark modes using a switch in the app bar.
3. Users can search for books by entering keywords and pressing the search button, which displays a list of books along with their titles, cover images, and author names.
4. Each book in the list has a favorite icon, allowing users to add the book to their favorites.
5. By selecting a book, users are taken to the Book Details Screen to view additional information.
6. The Favorite Screen is accessible by clicking the favorite icon on the Home Screen, displaying all books marked as favorites.
7. The app incorporates smooth animations, responsive design, and efficient local storage for a seamless user experience.
