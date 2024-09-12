
# Figaro
- [Figaro article](https://medium.com/@MinimalGhost/the-figaro-gem-an-easier-way-to-securely-configure-rails-applications-c6f963b7e993)
- [figaro docs](https://rubydoc.info/gems/figaro/0.7.0/frames)
 ## Setup
 1. gemfile: `gem "Figaro"`
 2. terminal: `bundle exec figaro install` OR `rails generate figaro:install
    - This generates `application.yml` and adds to `.gitignore`
3. Add configuration to this file
    ``` 
    client_id: <value>
    client_secret: <value>
    ```
