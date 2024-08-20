using School.library as bmdb from '../db/library';

service BookService{
    entity Books as projection on bmdb.Books;
    entity Author as projection on bmdb.Authors;
    entity Books_detail as projection on bmdb.Books_detail;

    @updateonly entity UpdateBooks as projection on bmdb.Books;
    @insertonly entity InsertBooks as projection on bmdb.Books;
    @deleteonly entity DeleteBooks as projection on bmdb.Books;

}

// extend service BookService with {
//     //get custom entity using sql query
//     @readonly entity CustomBooks as select from bmdb.Books{
//         title,
//         author.author,
//         genre,
//         stock,
//         details.description,
//         price.amount||' '||price.currency as Price:String
//     }

//     //get all data by excluding single entity
//     // @readonly entity CustomBookss as select from bmdb.Books{
//     //     *
//     // }excluding{
//     //     details_ID
//     // }
// }