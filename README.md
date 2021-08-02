 # Balam

A SwiftUI-powered, Flux-inspired iOS example app.

---

## Characteristics:

- **iOS**: 14.0
- **Device**: iPhone
- **Language**: Swift
- **UI framework**: SwiftUI
- **App architecture**: MVVM / Flux

---

## General description:

Balam makes full use of SwiftUI's power by relying on a state-centric architecture. The app holds a global state that serves as the only source of truth, allowing navigation, displaying content, and performing actions. SwiftUI then hooks into that state and reacts accordingly to always be in sync.

Balam also follows a MVVM-esque layered approach, defining `Views`, `ViewModels`, `Services`, and `Repositories`. In this architectural variant, `Views` and `ViewModels` serve as the presentation layer, displaying the content as per the global state, and handling user interactions and forwarding them to the corresponding entities. `Services` serve as the business layer, where contextual rules are defined. These entities are the brain of the operation. Lastly, `Repositories` serve as the data access layer. This layer connects with a deeper networking layer that handles requests to provide the necessary data. At the moment, the data at the networking layer is mocked.

---

## General features:

- Browsing a menu (categories and items)
- Adding items to the cart
- Removing items from the cart
- Opening the cart
- Viewing the cart's content
- Closing the cart to return to menu