# Mobile App Coding Challenge: Lock Settings Configuration

A quick and dirty app in response to the Assa Abloy challange of the 15.03.2024.

## Notes on Architecture

The mobile app is written in Dart, using the Flutter framework and designed to be compiled for use with either Android or iOS, following the UI wireframe supplied.

## Notes on Requirements Deliverables

* Lock configuration data is retrieved on app start from the provided API. If an error occurs, an error message is displayed.
* The configuration data is persisted locally once retrieved, between sessions.
* A list of 2 app locks is provided, named *primary* and *secondary*, and assigned the default values from the configuration data.
* The settings of the 2 app locks is not persisted as this was not required.
* The configuration of both app locks may be modified and persist during the current user session.
* Clicking the *sync* icon button in the app bar will reset the configuration data and both app locks. This icon button was not in the original requirements.