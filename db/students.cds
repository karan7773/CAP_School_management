namespace School.Students;
using {cuid} from '@sap/cds/common';

entity Contents : cuid {
    url : String(2048);
    date_published : Date;
    content_type : String(20);
    course : Association to Courses
}

entity Courses : cuid {
    course_name : String(100);
    course_url : String(1024);
    course_duration :  Integer;
    course_price : Decimal(5, 2);
    published_status:Boolean;
    content : Association to many Contents on content.course = $self;
    enrollment : Association to many Enrollments on enrollment.course = $self;
}

entity Enrollments : cuid{
    course : Association to Courses;
    student : Association to Students;
}


entity Students {
    key email : String(50);
    first_name : String(40);
    last_name : String(40);
    date_sign_up : Date;
    enrollment : Association to many Enrollments on enrollment.student = $self;
}


