# shortener_app

A flutter app that allows you to create short urls and keep track of
the amount of people who clicked on them. This app consumes [this](https://github.com/caws/url_shortener)
Rails API.

This project uses the BLoC pattern with a little twist.

The twist here is that I'm using an AppProvider class to hold all the 
other blocs/services before the widgets in the widget tree.

But why?

This structure allows me to have access to blocs from anywhere in 
the app, thus all changes that occur in any of the blocs are quickly 
reflected everywhere in the app via the streams.

## Getting Started

Clone the repository, get the dependencies and you're good to go.
You'll also need to have a backend for this or use this sample backend project.

## Why

The main objective of this project is to have a base project structure
that I can use for other medium-sized projects.

## What will you find?

BLoC inspired pattern

    The class AppProvider contains references to all the blocs used in the app,
    this is done so that all blocs can be acessed from anywhere in the app by 
    requesting them from the context, which allows you to update different
    screens by listening to the bloc from the context.

Basic session control

    If you don't logout before closing the app, your JWT token remains stored 
    and will be used the next time you open the app until it is no longer valid. 
    If you do logout before closing the app, you'll be greeted with the login screen.

Basic API routing

    The Routes class contains the core URL references for a given API, 
    and other classes can extend it, thus adding more routes to it and allowing
    routes to be called via a method. 
    (eg.: yourHttpClient.post(AuthenticationRoutes.login(), authenticationData);). 

## Screenshots

<a href="https://ibb.co/Cw834XZ"><img src="https://i.ibb.co/b6mMYyZ/Captura-de-tela-de-2019-10-16-23-39-21.png" alt="Captura-de-tela-de-2019-10-16-23-39-21" border="0" width=300></a>
<a href="https://ibb.co/s56DkLb"><img src="https://i.ibb.co/HNxM1mB/Captura-de-tela-de-2019-10-16-23-39-44.png" alt="Captura-de-tela-de-2019-10-16-23-39-44" border="0" width=300></a>
<a href="https://ibb.co/njx6kK0"><img src="https://i.ibb.co/zZqQft5/Captura-de-tela-de-2019-10-16-23-44-44.png" alt="Captura-de-tela-de-2019-10-16-23-44-44" border="0" width=300></a>
<a href="https://ibb.co/zbX3WBn"><img src="https://i.ibb.co/CvbjpY1/Captura-de-tela-de-2019-10-16-23-44-54.png" alt="Captura-de-tela-de-2019-10-16-23-44-54" border="0" width=300></a>
<a href="https://ibb.co/Wpd9nyQ"><img src="https://i.ibb.co/BK7DLZm/Captura-de-tela-de-2019-10-16-23-45-12.png" alt="Captura-de-tela-de-2019-10-16-23-45-12" border="0" width=300></a>