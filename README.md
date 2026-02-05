
#README

# RVTripPlanner App
## Project Overview
- A small app for RV trip planing & managing.
                    
#### Architecture: MVVM
#### Technologies: SwiftUI, SwiftData, Alamofire, SPM

#### Design: Simple Native SwiftUI components
#### Color Scheme:
- Primary: light: #3380F2, dark: #66B3FF
- Secondary: light: #D95940 dark: #FF7359
- Background: light: #FAFAFF, dark: #14141F

- Primary Text: light: #1A1A1F, dark: #FFFFFF
- Secondary Text: light: #6B6B7A, dark: #B3B3C2
- Tertiary Text: light: #9999A8, #6B6B7A

### Persistance
- Persistance is done with SwiftData for `Vehicle` and `FavouritePoI` objects. SwiftData model container is injected in the composition root of the app `@main RVTripPlannerApp`. The container is not shared with an AppGroup (Widget, AppIntent), or with iCloud Kit. I've made this desicion based on the simplicity of the app. 
(If, in the future, the app grows and start to include AppGroup features, MigrationPlan, custom ModelContainer will be added.)

— SwiftData Models
#### Vehicle:
  ```
  @Model
  final class Vehicle: Identifiable {
    @Attribute(.unique) var id: UUID
    var type: String      //VehicleType enum
    var make: String
    var model: String
    var year: Date
    var fuelType: String  //FuelType enum
    var imageData: Data?
    var nickname: String?
  }

  ```
    
#### FavouritePoI:
```
@Model
final class FavouritePoI: Identifiable {
    @Attribute(.unique) var id: Int
    var name: String
    var url: String
    var primaryCategoryDisplayName: String
    var rating: Double?
    var imageURL: String?
    var isOpen: Bool?
}
```
    
— other models are saved In-memory, and are not persisted!

### Networking
- Networking is done through `Alamofire` framework.
- It's composed in the composition root, and relies of DI, abstractions and SOLID. (no shared state)
- HttpClient -> PoIService -> ViewModel -> PlacesScreen
- Collaborators rely on abstractions, not on concrete types, e.g. `PoIService`, `HttpClient`
- Main Recieving object is `PoIDTO` capturing the JSON. In the `PoIService` is mapped to `PoIModel`

### Features
#### Tab View:
#### Garage
* local persistance (SwiftData - VehicleModel)
* Box-Type VGrid of vehicles with photo, nickname, make/model/year.
* Add/Edit vehicle sheet with validation.
* Edit/Delete actions hidden with `ContextMenu` (hold to popup)
                    
#### Places
* Segmented control for List | Map [not completed].
* Large list of recieved PoI (Points of Interest) models
* Favorites subsection within list
  - deleting a favourite PoI simply slide-to-delete.
* API Calls (Alamofire) + Saving (favourites - `FavouritePoI`) (SwiftData)
* Detail screen:
    - mini map
    - open/closed indication
    - open-in-browser button
    - rating (1-5 stars)



### UI
- UI is also composed and it's made with scalability in mind. 
- Both `Garage` and `Places` screens have their own child views (most of them are shared, reusable components)
- Most of the views composed with custom `ViewModifiers` that I've made myself, like: `.applyViewPaddings(.all)`, `.applyBackground()`, `.applyFont()`. All of theese are there to encapsulate UI logic and remove boilerplate in Screens.
- I've strived to display all of the API's I know and use daily at my current job & in my own projects.
some of them are: 
    - ViewModifiers - `ViewModifiers` + `Extension+View`
    - GenericViews - `GarageEmptyStateView`
    - List
    - LazyGrid
    - Form
    - Section
    - Assets
    - ContextMenu
    - Haptics
And overal architural thinking not only in services and networking, but also in UI.

### What's next
- I have a couple of ideas for growth: 
#### GarageScreen
    - here I would expand the `VehicleViewRow` and add nickname, and car type to the Grid.
    - I would also create a DetailScreen showcasing all the information for a certain Vehicle.
    - I would move from a native Form componnent to a custom one, with coloured validation fields. 

#### PlacesScreen
    - use some of the ignored fields from request - tags, category_group, and booking_url
    - I would add other sections in the List with different catgories (History, Europe, Tropic)
    - I would also finish the assignment adding the bridged from UIKit `Clustered Map`
    - Finally I would create a caching system to store recieved data from server and add pagination for smoother expirience
