# EB-APP
Challenge EB
## Demo-online
**[DEMO](https://myappeb.herokuapp.com/)**

## Description
Website connected to EB account to list all published properties and where users can contact with each property.
## Getting started
1. First clone this repo with
docker container run --rm -v $(pwd):/app -v ssh:/root/.ssh codeableorg/git clone {the ssh goes here}

2. Go to the directory and create a file with the .env extension and add this format
```
GIT_USER_NAME=NameHERE
GIT_USER_EMAIL=your_github_mail@goes.here
DB_HOST=app-eb-xxxx_db_1 
```
The DB_HOST will be setted later when you run the #3

3. Run docker first
```
docker-compose up
```
4. On a different window run:
 ```
 docker compose exec client bash
 ```
5. Inside the bash terminal run the command:
 ```
bootstrap 
 ```
6. Go to your .env file and fill the DB_HOST variable with your db_host from step 3
7. Install all the gems with bundle install
8. Initialize your DB: rails db:create db:migrate 
9. Finally you can run this command to open rails server
```
rails s -b 0.0.0.0
```
10. Go to your browser and to this site. And enjoy it
```
http://localhost:3000
```

11. If you got any problems booting the server or creating the db you can repeat from number 3 or verify the environment variables. That's it. Thanks for enjoying this app.

 
## Notes
- The hardest thing to make this app was learning how use an api in Rails,before that I only used api in frontend to make websites.
- If I had more time, I would refactor my code, for example the action create_contact of properties controller,I would improve my tests for each action,CSS styles and I would implement pagination to home page.
- I'm happy with the result, because I learned a lot making this app.


## Maintainers
 **[Giancarlo](https://github.com/jewelazo)**
