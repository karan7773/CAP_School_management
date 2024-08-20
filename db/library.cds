namespace School.library;

using { cuid } from '@sap/cds/common';


entity Books : cuid{
    title : String(70);
    author : Association to Authors;
    genre : String(40);
    price : Price;
    key stock : Integer;
    details : Association to Books_detail;
}

type Price{
    amount : Integer;
    currency : String(3);
}

entity Authors : cuid{
    author : String(50)
}

entity Books_detail : cuid{
    keyline : String;
    description : String;
}

annotate Books with @(
    UI:{
        SelectionFields  : [
            
        ],
        LineItem  : [
            {
                Label : 'Title',
                Value : title
            },
            {
                Label : 'Author',
                Value : author.author
            },
            {
                Label : 'Genre',
                Value : genre
            },
            {
                Label : 'Stock',
                Value : stock 
            },
            {
                Label : 'Price',
                Value : price_amount
            }
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '',
            TypeNamePlural : '',
            Title:{
                Value : title
            },
            Description:{
                Value : author.author
            },
        },
        Facets : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'Book Details',
                ID : 'Details',
                Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target : '@UI.FieldGroup#Details',
                    },],
            }
        ],
        FieldGroup#Details : {
            $Type : 'UI.FieldGroupType',
                Data:[
                {
                    $Type : 'UI.DataField',
                    Label: 'Key Story line',
                    Value: details.keyline
                },
                {
                    $Type : 'UI.DataField',
                    Label: 'Summary',
                    Value: details.description
                }
            ]
        },
    }
);
