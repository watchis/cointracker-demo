# cointracker-demo

A simple demo designed to replicate some of the functionality of [CoinTracker](https://www.cointracker.io/).

## Links
 - Check out the downloadable APK [here](https://github.com/watchis/cointracker-demo/releases/tag/releases).
 - Take a look at the Notion page for this project [here](https://watchis.notion.site/CoinTracker-Demo-f2647deec0a6464292236d8c8ff4ebc9?pvs=4).

## Description

This is a demo project for CoinTracker that will request address and transaction information from [Blockchain.com's API](https://www.blockchain.com/explorer/api/blockchain_api) and display it in a Dart-based Flutter UI. This application has the ability to add, delete, and give custom names to addresses as well as fetch/synchronize for all added addresses or for one address at a time.

## Getting Started

### Running the Client

1. Follow the steps to install Dart [here](https://dart.dev/get-dart).
   - **Note:** You may need to install [HomeBrew](https://brew.sh/) if using Mac or [Chocolatey](https://chocolatey.org/install) if using Windows.
2. Follow the steps to install Flutter [here](https://docs.flutter.dev/get-started/install).
   - **Note:** For Windows, I found [this resource](https://www.liquidweb.com/kb/how-to-install-and-configure-flutter-sdk-windows-10/) to be better than the Flutter webpage for installation instructions.
3. Go to the client directory by running `cd ./client`.
4. Call `flutter run` to run the client as a standalone application or `flutter run -d chrome` to run in a web browser.

### Running the Server [Not Fully Implemented]

1. Follow the steps to install Go [here](https://go.dev/doc/install).
2. Go to the server directory by running `cd ./server`.
3. Before running the server, validate that port 8080 on your local machine is available.
4. Call `go run ./server.go` to run the server.

## More About Me

- [LinkedIn](https://www.linkedin.com/in/warren-atchison/)

- [Portfolio](https://watchis.github.io/portfolio/)

- [Email Me!](mailto:warren.atchison98@gmail.com)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
