module.exports=srv=>{
    srv.after("READ",'GetStudents',(req,res)=>{
        console.log("get students");
    });
    srv.after("READ",'GetCourses',(req,res)=>{
        console.log("get courses");
    });
    srv.after("READ",'GetEnrollments',(req,res)=>{
        console.log("get enrollments");
    });
    srv.after("READ",'GetContents',(req,res)=>{
        console.log("get contents");
    });
}