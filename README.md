# UBP - Ultimate Blog Project

This project is a simple blogging engine created with Ruby on Rails. The project's aim is to introduce the developer to Ruby on Rails and the agile development process.

## Table of Contents

* [Technologies](#technologies)
* [Setup](#setup)
* [Testing](#testing)

## Technologies

Project is created with:

* Ruby 2.7.4
* Rails 6.0.2.1

To display Images in the blog posts please Install ImageMagick and/or libvips:
```
$ brew install imagemagick vips
```

## Setup

To run this project run the following:

```
$ bundle install
$ yarn install --check-files
$ rails db:migrate
$ rails server
```

Open URL: "localhost:3000" in any browser.

## Testing

To test this project run the following:

```
$ rspec
$ rails test test
```
