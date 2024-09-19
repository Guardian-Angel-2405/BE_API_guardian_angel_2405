# GUARDIAN ANGEL HELPLINE API

This [API](https://github.com/Guardian-Angel-2405/BE_API_guardian_angel_2405) provides access to mental health organizations and crisis helplines in the US and New Zealand.  It was built to service the Guardian Angel application that can be found [here](https://github.com/Guardian-Angel-2405/FE_guardian_angel_2405.git) 

## Links
- [Helpline API](https://github.com/Guardian-Angel-2405/BE_API_guardian_angel_2405)
- [Front End Monlith repo](https://github.com/Guardian-Angel-2405/FE_guardian_angel_2405.git)
- [Heroku](https://throughline-sinatra-service-3b392556cf62.herokuapp.com)


## Endpoints

| Method | Endpoint         | Description                    | Parameters                                  | Response                |
|--------|-----------------|--------------------------------|----------------------------------------------|------------------------|
| GET    | /countries      | Returns a list of all countries         | none                        | `Response` (200)   |
| GET    | /helplines           | Returns all helplines                  | Path parameter (`<country_code>`) | `Response` (200)    |
| GET    | /helplines/#{id}           | Returns data for a helpline                  | Path Parameters (`helpline.id`) | `Response` (200)    |
| GET    | /topics          | Returns a list of topics                 | none | `Response` (200)    |


## Setup (call this something else since there is no setup)
* Ruby version: 3.1.4

* Rails version: 7.1.4

* Sinatra



Still need to add:
- json contract for each endpoint
- How to call the API (in postman?) but do I need to do this since it's all internal?
  - /helplines
  ```
  1. Create a new GET request in Postman.
  2. Add a parameter for the country_code
    `us` (United States) or `nz`(New Zealand) are your options. 
  3. Run the request to see the response.
  # add a screenshot
  ```

  - /helpline/#{:id}
  ```
  1. Create a new GET request in Postman.
  2. Add a parameter for the helpline.id

  3. Run the request to see the response.
  # add a screenshot
  ```

  - /countries
  ```
  1. Create a new GET request in Postman.
  2. Run the request to see the response.
  # add a screenshot
  ```
  - /countries
  ```
  1. Create a new GET request in Postman.
  2. Run the request to see the response.
  # add a screenshot
  ```
  - /topics
  ```
  1. Create a new GET request in Postman.
  2. Run the request to see the response.
  # add a screenshot
  ```
- 
