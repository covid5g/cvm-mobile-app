# HackathonCOVID2020
# COVID5G

iOS Project for the COVID19 crisis. Helps you track the symptoms, and displaying a real-time map with the number of cases near you.

iOS project has the following configuration:

* Targets
  * Test: Unit tests working with Quick and Nimble.
  * UITest: Functional tests working with Nimble matcher.
  * App Production Target.
  * App Staging Target. Same app source code with a different bundle id, it points to a different Restful API (staging one).

* Project Configuration
  * R-Swift integration.
  * Warnings for TODO and FIXME comments.
  * Swift Lint integration.
  * Crashlytics integration.
  * `travis.yml` file.
  * `podfile` containing most used libraries by us.
    - RxSwift, Decodable, Alamofire, RxSwift, GCLLOCATION, Moya and many others.

* Networking
  * `Alamofire` networking library.
  * `Moya` network abstraction layer integrated along with some examples.
