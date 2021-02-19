# About Rails Engine

Rails Engine is a Ruby on Rails API built from scratch.  Modeled after the little-esty-shop web application where statictics for merchants and their sales/items inventory is readily available.  [Little-Esty-Project](https://github.com/turingschool-examples/little-esty-shop)
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->




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

![Schema](https://github.com/jlfoxcollis/rails-engine/main/schema.png)

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
* [JQuery](https://jquery.com)
* [Rails](https://rubyonrails.org/)
* [Ruby](https://www.ruby-lang.org/en/)
* [Brakeman](https://github.com/presidentbeef/brakeman)



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
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Pages](https://pages.github.com)
* [Animate.css](https://daneden.github.io/animate.css)
* [Loaders.css](https://connoratherton.com/loaders)
* [Slick Carousel](https://kenwheeler.github.io/slick)
* [Smooth Scroll](https://github.com/cferdinandi/smooth-scroll)
* [Sticky Kit](http://leafo.net/sticky-kit)
* [JVectorMap](http://jvectormap.com)
* [Font Awesome](https://fontawesome.com)
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
