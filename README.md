# Guardian Angel Backend Journal Repository
![guardian_angel_logo](https://github.com/user-attachments/assets/836291c1-b7b2-4c23-8559-51d4c90521d4)
‘Guardian Angel’ is a full stack Rails application that will allow users to create an account and gain access to resources that can boost mental health and/or help in times of crisis. Users will be able to select from a list of emotions and feelings as many times per day as they wish. By accessing the ‘ThroughLine API’, a list of helpful resources will be returned to the user, including, but not limited to, phone numbers, sms hotlines, support groups, and relevant, helpful websites. 

The BE Sinatra API Repository is responsible for serving json responses from the Throughline API to the front end repository. It packages JSON responses for the front end application with infomration about emergency services from the Throughline API. 
## Getting Started
These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on deploying the project on a live system.
### Prerequisites
You will need to have the Ruby 3.2.2. This project works in conjuction with the two other repositoris within the Guardian Angel application, but they are not necessary to run this application. 
### Installing
To install and use this repository on your local machine first clone down this repository.
Navigate through the console so that your are in the directory for the repository.
Then run `bundle install` to install all the gem dependencies. 
Following this run `ruby app.rb` in the terminal. This will start the server locally. For example `localhost:3000` for the Journal BE repository.

Alternatively you can utilize the deployed version of the site here: [Heroku Site]( ).

## Making API Calls and Endpoints 

## Running the tests
To run the tests for this repository, simply run ` ` from the command line while in the Guardian Angel projects directory. This will run all test files for the application. 
## Deployment
Instead of locally running all of the repositories, you can utilize the deployed [Heroku Site](https://guardian-angel-5f5f5ba49dc1.herokuapp.com/login). Making API calls the site will user the following as the base url: ``. If running locally, use the `localhost:port_number` as the base url for making API calls. 
## Built With
  - [Contributor Covenant](https://www.contributor-covenant.org/) - Used
    for the Code of Conduct
  - [Creative Commons](https://creativecommons.org/) - Used to choose the license
  - [ThroughLine]([https://www.example.com](https://api.throughlinecare.com/users/sign_in))
  - [Guardian Angel Sinatra BE Repository](https://github.com/Guardian-Angel-2405/BE_API_guardian_angel_2405)
  - [Guardian Angel FE Repository](https://github.com/Guardian-Angel-2405/FE_guardian_angel_2405)
## Contributing
Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code
of conduct, and the process for submitting pull requests to us.
## Versioning
We use [Semantic Versioning](http://semver.org/) for versioning. For the versions
available, see the [tags on this
repository](https://github.com/PurpleBooth/a-good-readme-template/tags).
## Authors & Contributors 
- **Austin Kenny** - *BE and FE Engineer* -
    [GitHub](https://github.com/AustinKCodes)
- **Cory Bretsch** - *BE and FE Engineer* -
    [GitHub](https://github.com/CoryBretsch)
- **Dana Howell** - *BE and FE Engineer* -
    [GitHub](https://github.com/DHowell1150)
- **Evan Davis** - *BE and FE Engineer* -
    [GitHub](https://github.com/DAVISEVAN)
- **Lance Nelson** - *BE and FE Engineer* -
    [GitHub](https://github.com/LancePants97)
- **Jan Lehigh** - *BE and FE Engineer* -
    [GitHub](https://github.com/JCL461437)
- **Tyler Noble** - *BE and FE Engineer* -
    [GitHub](https://github.com/tnoble-cmd)
- **Kat Brandt** - *BE and FE Project Manager* -
## License
This project is licensed under the [CC0 1.0 Universal](LICENSE.md)
Creative Commons License - see the [LICENSE.md](LICENSE.md) file for details
##
## API Endpoints Documentation

### Base URL
- Local: `http://localhost:4567`
- Deployed: [Heroku Site](https://guardian-angel-5f5f5ba49dc1.herokuapp.com)

### Endpoints

#### 1. **GET /countries**
   - **Description:** Fetches a list of countries with their emergency numbers.
   - **Response:**
     ```json
     {
       "countries": [
         {
           "name": "New Zealand",
           "code": "NZ",
           "emergencyNumber": "111"
         },
         {
           "name": "United States",
           "code": "US",
           "emergencyNumber": "988"
         }
       ]
     }
     ```

#### 2. **GET /topics**
   - **Description:** Fetches a list of topics related to emergency services.
   - **Response:**
     ```json
     {
       "topics": [
         {
           "name": "Abuse & domestic violence",
           "code": "abuse-domestic-violence"
         },
         {
           "name": "Gender & sexual identity",
           "code": "gender-sexual-identity"
         }
       ]
     }
     ```

#### 3. **GET /helplines**
   - **Description:** Fetches a list of helplines based on the country code and limit.
   - **Parameters:**
     - `country_code` (optional, default: "us")
     - `limit` (optional, default: 20)
   - **Response:**
     ```json
     [
       {
         "id": "c8e47108-3f87-4311-ab8f-7a3adf01ba06",
         "name": "988 Suicide & Crisis Lifeline",
         "description": "A suicide prevention and crisis intervention service.",
         "website": "https://988lifeline.org"
       }
     ]
     ```

#### 4. **GET /helplines/:id**
   - **Description:** Fetches details of a specific helpline by its ID.
   - **Parameters:**
     - `id`: Helpline ID
   - **Response:**
     ```json
     {
       "id": "c8e47108-3f87-4311-ab8f-7a3adf01ba06",
       "name": "988 Suicide & Crisis Lifeline",
       "description": "A suicide prevention and crisis intervention service.",
       "website": "https://988lifeline.org",
       "phoneNumber": "988",
       "smsNumber": "988",
       "webChatUrl": "https://988lifeline.org/chat/",
       "topics": ["Suicidal thoughts", "Abuse & domestic violence"],
       "country": {
         "name": "United States",
         "code": "US",
         "emergencyNumber": "988"
       },
       "timezone": "America/Puerto_Rico"
     }
     ```

### Error Handling
- The API will return a JSON object with an error message and appropriate status code if something goes wrong.

```json
{
  "error": "Unable to fetch helplines"
}


