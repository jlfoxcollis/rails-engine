# About Rails Engine

Rails Engine is a Ruby on Rails API built from scratch.  Modeled after the little-esty-shop web application where statictics for merchants and their sales/items inventory is readily available.  [Little-Esty-Project](https://github.com/turingschool-examples/little-esty-shop)


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![Schema](https://github.com/jlfoxcollis/rails-engine/blob/main/schema.png)

Rails Engine is a backend API built to support Merchants tracking their inventory and revenue statistics.

Utilizing our JSON endpoints, a merchant can request:
* potential revenue by invoices.
* all revenue by date range.
* weekly revenue figures.
* Items with most revenue.

From a Business Intelligence standpoint, as this is public, any visitor can request:
* Total revenue between start/end date ranges.
* Revenue of a specific merchant.
* Weekly Revenue of all Merchants.
* Merchants with highest Revenue.
* Merchants who sold the most items.
* able to see all / one merchant.
* able to see all/ one item, and can create, update, and remove items.
* search for merchants and items that match a partial name.



### Built With

This project was built on the Rails framework and tested with rspec and Brakeman for security vulnerabilities.

* [Rails](https://rubyonrails.org/)
* [Ruby](https://www.ruby-lang.org/en/)
* [Brakeman](https://github.com/presidentbeef/brakeman)
* [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)



<!-- GETTING STARTED -->
## Getting Started

This project is currently not deployed with any online platforms.  So in order to utilize these data endpoints you will have to Fork/clone and test the endpoints locally.

### Prerequisites

* Ruby 2.5.3
* Rails 5.2.4.3
* Postgresql (Most recent version)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/jlfoxcollis/rails-engine.git
   ```
3. Install dependencies
   ```sh
   npm install
   bundle install
   ```
4. create DB and seed
  ```sh
  rake db:{drop,create,migrate,seed}
  ```
5. Launch local server
  ```sh
  rails s
  ```




<!-- USAGE EXAMPLES -->
## Usage

<a href="erd.pdf">

<!-- CONTACT -->
## Contact

James Fox-Collis - [Linkedin](https://www.linkedin.com/in/james-fox-collis/) - jlfoxcollis@gmail.com

Project Link: [Rails Engine Repo](https://github.com/jlfoxcollis/rails-engine)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Choose an Open Source License](https://choosealicense.com)
* [Font Awesome](https://fontawesome.com)
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
