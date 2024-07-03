# MarvelDemo

MarvelDemo is a project showcasing Marvel characters with their images and their 
names using the Marvel API. When you click on any character, you can view their
list of comics in a carousel form, feel free to swipe to see the previous or the 
next character of your preference. Last but not least, by clicking on a comic
which interests you, directs you to its detailed web page. 

## Screenshots
<p float="left">
  <img src="screenshots/screenshot1.png" alt="Screenshot 1" width="200"/>
  <img src="screenshots/screenshot2.png" alt="Screenshot 2" width="200"/>
  <img src="screenshots/screenshot3.png" alt="Screenshot 3" width="200"/>
  <img src="screenshots/screenshot4.png" alt="Screenshot 4" width="200"/>
</p>

## Setup Instructions

1. **Get Marvel API Keys:**
   - Go to [Marvel Developer Portal](https://developer.marvel.com/) and create an account.
   - Obtain your public and private keys.

2. **Environment Variables:**
   - Create a .env file in the root directory of the project.
   - Add your Marvel API keys to the .env file:
     ```plaintext
     PUBLIC_KEY=your_public_key
     PRIVATE_KEY=your_private_key
     ```
   - Note: Currently, the project uses keys directly in Env.swift ,due to issues with .env file setup, so you can just use your keys there. This can be revisited as a future improvement (TODO).

3. **Open in Xcode:**
   - Open the project in Xcode.

4. **Run the Project:**
   - Build and run the project.

## Project Structure

- **MarvelDemoApp:** Entry point of the application.
- **ContentView:** Displays the list of Marvel characters. Scroll down to load more characters.
- **DetailView:** Displays the details of a selected character and their comics. Swipe to see the next or previous character.
- **ComicDetailView:** Displays the detailed view of a comic using a WebView.
- **MarvelAPI:** Handles API requests to fetch characters and comics.
- **WebView:** Wraps WKWebView for displaying web content.
- **MarvelModel:** Data models for characters and comics.
- **Env:** Holds static API keys (TODO: Integrate with `.env` file).

## Folder Structure

- 📂 MarvelDemo/
    - 📁 MarvelDemo/
      - 📁 Assets.xcassets/
      - 📁 Preview Content/
        - 📁 Preview Assets/
      - 📄 ContentView.swift
      - 📄 DetailView.swift
      - 📄 ComicDetailView.swift
      - 📄 MarvelAPI.swift
      - 📄 WebView.swift
      - 📄 MarvelModel.swift
      - 📄 Env.swift
    - 📁 screenshots/
      - 📄 screenshot1.png
      - 📄 screenshot2.png
      - 📄 screenshot3.png
      - 📄 screenshot4.png
- 📄 MarvelDemo.xcodeproj
- 📄 README.md

## Development Environment

- **Xcode:** Version 12.0+
- **Swift:** Version 5.0+
- **iOS:** Version 14.0+

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
