using School.library as bmdb from '../db/library';
using BookService as BookService from './library_service';

extend service BookService with @(path:'newser',impl:'srv/new_library_service.js') {
    //get custom entity using sql query
    @readonly entity CustomBooks as select from bmdb.Books{
        // title,
        // author.author,
        // genre,
        // stock,
        // details.description,
        *,
        price.amount||' '||price.currency as Price:String
    }

    //get all data by excluding single entity
    // @readonly entity CustomBookss as select from bmdb.Books{
    //     *
    // }excluding{
    //     details_ID
    // }
};