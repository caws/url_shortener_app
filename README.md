# shortener_app

A flutter app that allows you to create short urls and keep track of
the amount of people who clicked on them.

This project uses the BLoC pattern with a little twist.

The twist here is that I'm using an AppProvider class to hold all the 
other blocs/services before the widgets in the widget tree.

But why?

This structure allows me to have access to blocs from anywhere in 
the app, thus all changes that occur in any of the blocs are quickly 
reflected everywhere in the app via the streams.

## Getting Started

Clone the repository, get the dependencies and you're good to go.

## Why

The main objective of this project is to have a base project structure
that I can use for other medium-sized projects.

## Screenshots

<a href="https://ibb.co/Wpd9nyQ"><img src="https://i.ibb.co/BK7DLZm/Captura-de-tela-de-2019-10-16-23-45-12.png" alt="Captura-de-tela-de-2019-10-16-23-45-12" border="0" width=300></a>
<a href="https://ibb.co/zbX3WBn"><img src="https://i.ibb.co/CvbjpY1/Captura-de-tela-de-2019-10-16-23-44-54.png" alt="Captura-de-tela-de-2019-10-16-23-44-54" border="0" width=300></a>
<a href="https://ibb.co/njx6kK0"><img src="https://i.ibb.co/zZqQft5/Captura-de-tela-de-2019-10-16-23-44-44.png" alt="Captura-de-tela-de-2019-10-16-23-44-44" border="0" width=300></a>
<a href="https://ibb.co/s56DkLb"><img src="https://i.ibb.co/HNxM1mB/Captura-de-tela-de-2019-10-16-23-39-44.png" alt="Captura-de-tela-de-2019-10-16-23-39-44" border="0" width=300></a>
<a href="https://ibb.co/Cw834XZ"><img src="https://i.ibb.co/b6mMYyZ/Captura-de-tela-de-2019-10-16-23-39-21.png" alt="Captura-de-tela-de-2019-10-16-23-39-21" border="0" width=300></a>