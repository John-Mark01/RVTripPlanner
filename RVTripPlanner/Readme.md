//
//  Readme.md
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

#README

*Project Overview*
- A small app for RV trip planing & managing.
                    
—— Architecture: MVVM
—— Technologies: SwiftUI, SwiftData, Alamofire, SPM

—— Design: Material Design
—— Color Scheme:
- Primary: light: #3380F2, dark: #66B3FF
- Secondary: light: #D95940 dark: #FF7359
- Background: light: #FAFAFF, dark: #14141F

- Primary Text: light: #1A1A1F, dark: #FFFFFF
- Secondary Text: light: #6B6B7A, dark: #B3B3C2
- Tertiary Text: light: #9999A8, #6B6B7A
                    
*Features*
                    
——— Tab View:
                        
—— Garage
* local persistance (SwiftData)
* Card list of vehicles with photo, nickname, make/model/year.
* Add/Edit vehicle sheet with validation.
                    
—— Places
* API Calls (Alamofire) + Saving (favourites) (SwiftData)
* Segmented control for List | [Optional] Map.
* Detail screen with “Save for Later”.
* Favorites subsection (or badge) within Places
                    


                    
*Planing*
——— API
[] - Base Networking Class (Networking)
[] - Parser Class (Parser)
[] - API Class (RVAPI)(combining both networking and parsing)
[] - Main View Model (PlacesScreenViewModel)
                    
                    



