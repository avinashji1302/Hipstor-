# Hipstor Assignment

A simple and responsive Flutter application that displays a paginated list of employees fetched from a gievn API. Users can view employee details and the last opened employee is saved and displayed at the top of the list using shared Preference.


## Getting Started

## 🔧 How to Run the App

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your_username/Hipstor-.git
   cd employee_directory_app

2. **Insatll The Dependencies:**
   ```bash
   flutter pub get
## Approach:
   
### Pagination
=> The app fetches employee data from:
https://fake-json-api.mock.beeceptor.com/users?_page=1&_limit=10

=> It implements infinite scrolling pagination using a ScrollController.

=> When the user scrolls near the bottom, the next page is automatically fetched.

### State Management
=> The app uses GetX (get package) for:

=> Controller-based logic

=> Reactive state updates using Rx variables


### Local Storage
The last opened employee's data is stored using shared_preferences as a JSON string.

When the app launches, the last opened employee is displayed at the top of the list.

## Challanges

1. Pagination Not Triggering
Issue: Scroll listener didn’t call API as expected.

Fix: Adjusted threshold in scroll listener : scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200


