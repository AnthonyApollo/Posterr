# Posterr

Posterr is a Twitter-like application developed for the Strider Technical Assessment. The app was developed in Swift using ViewCode, along with the [Snapkit](https://github.com/SnapKit/SnapKit), [R.swift](https://github.com/mac-cain13/R.swift) and [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) libraries. Posterr also uses CoreData to save Posts and Users directly to device memory and was implemented following the V.I.P.E.R. architectural pattern.

## How to run

To run Posterr you need to go to the project root folder in the terminal and run the `pod install` command, this will configure R.swift and SnapshotTesting. After that, just open the `Posterr.xcworkspace` file with Xcode and run it in the simulator of your choice. As I used SnapshotTesting to record the expected state of the UI in the unit tests, these tests are not guaranteed to pass if run on a simulator other than the Iphone 13 pro.

## Technical considerations

As this assessment required the app to be fully testable with only local data, I chose to use CoreData to save Posts and Users directly in the device's memory, that way we don't lose any data when the user closes the app. If this app were to be published, it would be better to provide a Restful API for consumption. Despite using CoreData to simulate the role of a Restful API, I believe I have reached a level of abstraction in the application's data layer where it would be very simple to implement some kind of APIClient. The `AppDataSourceProtocol` has all the functions needed to implement a new data source and it would be quite easy to replace the existing one with one that conforms with this protocol.

Some of the app validation requirements like max characters for username and only alphanumeric characters for username were implemented in the app data layer because in a real app this should be on an registration screen, which the current scope does not include. Since this kind of rule could also be in the backend, I figured the data layer would be the best place to validate this.

The `ApplicationInteractor` class has a function called `injectMockedData()` used to populate the App with posts from other users and to create the default user. This code would not be present on a real application.

## Critique

### Improvements

<aside>
📎 Reflect on this project, and write what you would improve if you had more time.

</aside>

With more time, I would like to improve the code coverage of the unit tests as this is something I think is very important for a real application. This adds a layer of security to the app development, preventing potential bugs that would be generated in the development of new features.

I also think the user experience of the `PostCreationView` component could be improved by adding an actual placeholder and some animations to make the size of the `TextView` dynamic according to the size of the text.

The layout of the App is very basic and could be improved as well. There could a better indication in the post cells to show if it is a repost or a quote post.

There could be a button that scrolls back to the top of the posts list.

### Error Handling

<aside>
📎 Assuming you've got multiple crash reports and reviews saying the app is not working properly and is slow for specific models, what would be your strategy to tackle the problem? (assuming the app is supposed to work well for these models)

</aside>

For unexpected crashes, I think the best approach would be to implement some crash reporting tool that can give us more details about what's happening (eg Firebase Crashlytics). With such a tool it would be easier to reproduce the problems and find better solutions.

For slowness, I would scan the application for any possible retain cycles using the Xcode debug navigator and the Xcode Instruments tool. It would also be worth checking if there are any expensive operations in the code that could be simplified.

### Scalability

<aside>
📎 Assuming your app has now thousands of users thus a lot of posts to show in the feed. What do you believe should be improved in this initial version and what strategies/proposals you could formulate for such a challenge?

</aside>

I think performance is key for large scale applications, so I would invest in implementing asynchronous programming using Combine in addition to SwiftUI. Combine is really useful for increasing an application's performance and SwiftUI's reactiveness makes the most of it by reducing screen refresh overhead, making code simpler.
