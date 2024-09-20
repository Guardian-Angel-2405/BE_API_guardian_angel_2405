# Guardian Angel Backend Journal Repository
![guardian_angel_logo](https://github.com/user-attachments/assets/836291c1-b7b2-4c23-8559-51d4c90521d4)
‘Guardian Angel’ is a full stack Rails application that will allow users to create an account and gain access to resources that can boost mental health and/or help in times of crisis. Users will be able to select from a list of emotions and feelings as many times per day as they wish. By accessing the ‘ThroughLine API’, a list of helpful resources will be returned to the user, including, but not limited to, phone numbers, sms hotlines, support groups, and relevant, helpful websites. 

The BE Journal Repository is responsible for serving as the data base of a `users` `journal` information. It packages JSON responses for the front end application with a users particular journal entries along with an affirmation which is unique. This affirmation comes from another API being consumed within the Guardian Angel Backend Journal Repository. 
## Getting Started
These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on deploying the project on a live system.
### Prerequisites
You will need to have the Ruby 3.2.2 and Rails 7.1.4. This project works in conjuction with the two other repositoris within the Guardian Angel application, but they are not necessary to run this application. 
### Installing
To install and use this repository on your local machine first clone down this repository, then clone down the [Guardian Angel Journal BE Repository](https://github.com/Guardian-Angel-2405/BE_JOURNAL_guardian_angel_2405) repository.
Navigate through the console so that your are in the directories of each application (you will need a terminals open for each of the three repositories).
Run `rails db:{create,migrate}` to establish the database. Then run `bundle install` to install all the gem dependencies. 
Following this run `rails s` in the terminal. For example `localhost:3000` for the Journal BE repository. These values are already set by default in each repository but you can change it by going to the `puma.rb` files in the `config` directory for the Rails applications. Your application should now be running. 

Alternatively you can utilize the deployed version of the site here: [Heroku Site]( ).

## Making API Calls and Endpoints 

## Running the tests
To run the tests for this repository, simply run `bundle exec rspec spec` from the command line while in the Guardian Angel projects directory. This will run all test files for the application. 
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

## Acknowledgments
