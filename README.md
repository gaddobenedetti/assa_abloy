# Mobile App Coding Challenge: Lock Settings Configuration

A quick and dirty app in response to the Assa Abloy challange of the 15.03.2024.

## Notes on Architecture

The mobile app is written in Dart, using the Flutter framework and designed to be compiled for use with either Android or iOS, following the UI wireframe supplied.

No localization, state management or extensive themes/styles were developed. It is meant simply as a proof of concept.

## Notes on Requirements and Deliverables

* Lock configuration data is retrieved on app start from the provided API. If an error occurs, an error message is displayed.
* The configuration data is persisted locally once retrieved, between sessions, as is the configuration for each lock.
* A list of 2 app locks is provided, named *primary* and *secondary*, and assigned the default values from the configuration data.
* The configuration of both app locks may be modified and persist during the current user session.
* Clicking the *sync* icon button in the app bar will reset the configuration data and both app locks. This icon button was not in the original requirements, but added at the developer's discretion.
* The filter refreshes the list of available settings, refreshing every time the search string is updated and is longer than three characters. Both the paramater name and value are searched.