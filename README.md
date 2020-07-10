# Geek's Den: Ruby on Rails Capstone

> Geek's Den is an entertainment news website created using Ruby on Rails, based on the design idea by Nelson Sakwa on Behance (https://www.behance.net/gallery/14554909/liFEsTlye-Mobile-version) .


## Main Features

* It allows the users to register and login using only a username.

* Then they can start populating the website with articles of their creation. 

* The articles need a Title, a content or body, a picture and a corresponding category, selected through a select-box.

* The home webpage shows the latest articles by categories and full-width promo of the featured article. This featured achievement is accomplished if the article is the most voted. 

* When a user clicks on a category, all the articles associated are shown.

* If a user wants to see the articles of his creation, he can go to his user page by clicking his name on the nav bar.   

## Screenshots
![image_2](https://user-images.githubusercontent.com/52765379/87200050-c191e300-c2c9-11ea-8922-291eff308399.png)

![image_3](https://user-images.githubusercontent.com/52765379/87200053-c3f43d00-c2c9-11ea-8456-25eea067ac4e.png)

![image_4](https://user-images.githubusercontent.com/52765379/87200057-c5be0080-c2c9-11ea-8ca1-99d4a3abfcd4.png)

## Built With

- Ruby v2.7.1
- Ruby on Rails v5.2.3
- HTML, CSS
- Postgres
- Heroku for deployment
- Google for cloud storage
- Tests with RSpec and Capybara

## Live Demo

[Geek's Den: Live version](https://geeksden.herokuapp.com/)
Hosted on a Heroku free account, it may take a while to load. 

## Getting Started

To get a local copy up and running follow these simple steps.

### Minimum Prerequisites

- Ruby: 2.6.3

- Rails: 5.2.3

### Setup

Install gems with:

```
bundle install
```

Setup database with:

```
   rails db:create
   rails db:migrate
```

### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

To run all tests use this command:

```
    bundle exec rspec
    
```
To run only model tests run this instead:

```
    bundle exec rspec spec/models

```

For views tests only, execute this:

```
    bundle exec rspec spec/features

```
And controller tests:

```
    bundle exec rspec spec/controllers

```
## Potential Features

* The user login can be expanded with e-mail and password

* The text area can be updated to act as a text editor to allow markdown

* The website can be made mobile-friendly


## Authors

👤 **Fernando Bahamondes**

- Github: [@ferbaco86](https://github.com/ferbaco86)
- Twitter: [@ferbac0](https://twitter.com/ferbac0)
- Linkedin: [linkedin](https://www.linkedin.com/in/fernando-bahamondes-correa)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/ferbaco86/rails-capstone/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

[Roberto](https://github.com/LoboArkano) My current coding partner

[Nelson Sakwa](https://www.behance.net/sakwadesignstudio) The designer behind the base idea of the website

My Microverse Stand Up Team for support and guidance

[Unsplash.com](https://unsplash.com/photos/bbokzTQjB9o) for some background pictures

## 📝 License

This project is [MIT](https://github.com/ferbaco86/rails-capstone/blob/develop/LICENSE) licensed.
