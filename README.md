# States and Territories

Solution to the coding challenge from The Judge Group. The coding challenge is part of the application to the iOS Developer position.

The solution is built using the MVVM framework to clearly separate UI code (View in MVVM), business logic code (Vew Model in MVVM), and data code (Model in MVVM).

To simplify mapping JSON to Core Data, [Sync](https://github.com/3lvis/Sync) pod is used.

## The Challenge
Create an iOS iPhone application project  that can fetch JSON data from the provided URL and displays the list of states information in a tabular format.

1. Create an iOS Universal framework project that exports a custom UITableViewCell class. (Eg: Mycell.framework)
2. Create an iOS app and import the above created framework to be used in this app
    This app will be Navigation Controller based application with single view controller
3. The view controller will display a list of all the states fetched from the below URL in a UITableView.
4. Create a Network Controller class which is used to fetch the JSON data from the URL (http://services.groupkt.com/state/get/USA/all)
5. The JSON data from the URL response must be modeled in data model classes
6. Each row must show all the details of the "State" data that is sent in the above URL, using the custom UITableViewCell from the framework (Eg: Mycell.framework created in step 1)
7. Create a NSString Category class with a function that can convert the ""area": "135767SKM"" from KMS to Miles and returns String value. The area in "Miles" must be displayed in each row.

## Additional Features Beyond the Challenge

1. Added ``UISearcontroller`` (search bar) to filter the data.
2. Added table sections and indexes.

## Building and running

No need to download the pods as they are already included.

```
$open StatesAndTerritories.xcworkspace
```

## Author
Vito Royeca
jovit.royeca@gmail.com