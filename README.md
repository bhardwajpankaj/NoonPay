# NoonPay
A sample app for noon 

This demo project consisting of Login/Signup/OTP Screen, Login screen is landing page for Now and can be replaced if the user is Already logged In(this will require a home page design).
I have written API Request architecture in this project however we can use it if needed in projects as well.
Signup and OTP screen are not consuming any API, To consider this you can have a look with Login Screen. However Both screens are fully functional.
Signup Screen functionalities are :
Added both pop ups from bottom and normal
Constraint on entering 7 digit Phone Number
Password show button is also working
Tnc Checkbox is mandatory part to enable Continue button
OTP Screen
Reading OTP from messages
Login Page : is landing page for now.
LoginVCViewModel: Will act as a ViewModel for the Login page which is responsible to call the data. This will call the loginPost which then calls the data from the server using URLSession, Below is the flow of hitting APIfrom this model.
loginPost -> LoginApiRequest -> LoginApiProtocol -> RemoteDataSource

Architectural and additional features:
• Following MVVM design architecture
• Not using any third party library via pods or Carthage(that helps in stability and reducing app size).
• Parsing the JSON getting from API via swift Decodable protocol.
• Generics are used for registering cells in UITableView.
• Written Extensions for common concerns.
• Used higher order functions.
• Autolayout
• Protocol oriented programming
• Inheritance : Base ViewController for the controllers with common features
• Added TouchId authentication
Language Used
Swift 5.
What more we can do :
Write unit test cases
