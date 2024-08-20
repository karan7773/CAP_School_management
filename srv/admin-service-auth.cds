using {BookService.Books} from './library_service';

annotate Books with @(restrict:[
    {
        grant:['READ','DELETE','CREATE','UPDATE'],
        to:'admin'
    },
]);

