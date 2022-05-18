<p align="center"><a href="https://github.com/Marcodeg/StepNetworking"><img src="https://user-images.githubusercontent.com/44085992/169148239-4254ec35-473f-46e0-8ada-e9b7edd3b3d5.png" alt="Gray shape shifter" height="60"/></a></p>
<h1 align="center">StepNetworking</h1>
<p align="center">A lightweight and flexible solution to HTTP Requests in Swift.</p>

<p align="center">
    <img alt="Swift" src="https://img.shields.io/badge/Swift-5.3_5.4_5.5_5.6-orange?style=flat-square">
    <img alt="Cocoapods" src="https://img.shields.io/cocoapods/v/StepNetworking?style=flat-square">
    <img alt="SPM" src="https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square">
    <img alt="Cocoapods" src="https://img.shields.io/cocoapods/l/StepNetworking?style=flat-square">
</p><br/><br/>

StepNetworking makes HTTP calls in Swift easy to create and read. It is built on async/await concurrency in Swift. 

- [Installation](#installation)
- [Create a Request](#create-a-request)
- [Execute a Request](#execute-a-request)
- [Validate a Request](#validate-a-request)
- [License](#license)



## Installation

### Requirements

* Deployment target iOS 13+
* Swift 5+

**CocoaPods**

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate StepNetworking into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'StepNetworking'
```

**Swift Package Manager**

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.


```dependencies: 
[
    .package(url: https://github.com/Marcodeg/StepNetworking")
]
```

**Importing**

At the top of the file where you'd like to use StepNetworking.

```swift
import StepNetworking 
```

## Create a Request

To create an HTTP request you have to compose it step by step through its builder.

```swift
HTTPRequest.builder
           .withURL("url")
           .withHTTPMethod(.get)
           ... // customize using builder methods
           .build()
```
These are the only mandatory steps, there are further possibilities to customize your request.

## Execute a Request

Executing a request is just as simple, you just need to call the perform method.

```swift
let result = await HTTPRequest.builder
            .withURL("")
            .withHTTPMethod(.get)
            .build()
            .perform()
```
The default perform will return a `Result`, returning a `Data` in case of success, and a `RequestError` in case of failure.

You can also decide to return an object of type `Decodable` in case of success and one in case of failure if the response will give a JSON in case of failure. In both cases, the library will do the various encodings.

```swift
let result = await request.perform(successResponse: Response.self)
```

```swift
let result = await request.perform(successResponse: Response.self, failureResponse: FailureResponse.self)
```

## Validate a Request

The request will be validated only if the status is between 200 and 300, but you can specify how to validate the request.

```swift
HTTPRequest.builder
           .withURL("url")
           .withHTTPMethod(.get)
           .withValidator(.base(acceptedStatusCode: 200..<205))
           .build()
```
The `withValidator` method takes as input parameter a `RequestValidator`.

`RequestValidator` is an enum that contains two cases: `base` and `retry`. Both allow you to specify a range in which the status code must fall to be accepted, the retry also allows you to re-perform the request when it fails, specifying the maximum number of attempts 

```swift
HTTPRequest.builder
           .withURL("url")
           .withHTTPMethod(.get)
           .withValidator(.retry(acceptedStatusCode: 200..<206, maxRetryCount: 3, delay: 1))
           .build()
```


## License
This software is released under the MIT license. See LICENSE for details.
