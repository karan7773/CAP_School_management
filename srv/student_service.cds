using School.Students as structures from '../db/students';

service MyService {

    @readonly entity GetStudents as projection on structures.Students;
    @readonly entity GetCourses as projection on structures.Courses;
    @readonly entity GetEnrollments as projection on structures.Enrollments;
    @readonly entity GetContents as projection on structures.Contents;

}
//testing navigation
//http://localhost:4004/odata/v4/my/GetStudents('alice.jones@example.com')/enrollment(d23c678d-4312-47f9-9147-cf12a5d45be9)/course/content
// or
//http://localhost:4004/odata/v4/my/GetStudents/alice.jones@example.com/enrollment/d23c678d-4312-47f9-9147-cf12a5d45be9/course/content

annotate MyService.GetStudents with @(
    UI:{
        SelectionFields  : [],
        LineItem  : [
            {
                Label : 'Email',
                Value : email
            },
            {
                Label : 'First Name',
                Value : first_name
            },
            {
                Label : 'Last Name',
                Value : last_name
            },
            {
                Label : 'Signup Date',
                Value : date_sign_up
            }
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '',
            TypeNamePlural : '',
            Title:{
                Value : first_name
            },
            Description:{
                Value : email
            }
        },
        Facets  : [
            {
                $Type:'UI.ReferenceFacet',
                Label:'Personal Info',
                Target : '@UI.FieldGroup#PersonalStudentInfo'
            },
            {
                $Type:'UI.ReferenceFacet',
                Label:'Enrollment Info',
                Target : 'enrollment/@UI.LineItem'
            }
        ],
        FieldGroup#PersonalStudentInfo : {
            $Type : 'UI.FieldGroupType',
            Data:[
                {
                    Label : 'Email',
                    Value : email
                },
                {
                    Label : 'First Name',
                    Value : first_name
                },
                {
                    Label : 'Last Name',
                    Value : last_name
                },
                {
                    Label : 'Signup Date',
                    Value : date_sign_up
                }
            ]
        }
    }
);

annotate MyService.GetEnrollments with @(
    UI:{
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '',
            TypeNamePlural : '',
            Title :{
                Value:course.course_name
            },
            Description:{
                Value: course.ID
            }
        },
        LineItem  : [
            {
                Label:'Enrollment ID',
                Value: ID 
            },
            {
                Label : 'Course ID',
                Value : course.course_name
            }
        ],
        Facets  : [
            {
                $Type:'UI.ReferenceFacet',
                Label:'Course Info',
                Target:'course/@UI.FieldGroup#CourseDetails'
            }
        ],
    }
);

annotate MyService.GetCourses with @(
    UI:{
        
        FieldGroup#CourseDetails  : {
            $Type : 'UI.FieldGroupType',
            Data:[
                {
                    Label:'Course name',
                    Value:course_name
                },
                {
                    Label:'Course URL',
                    Value:course_url
                },
                {
                    Label:'Course Duration in Hrs',
                    Value:course_duration
                },
                {
                    Label:'Course Price in USD',
                    Value:course_price
                },
            ]
        },
    }
);
