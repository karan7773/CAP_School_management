const cds = require("@sap/cds");
const {Books} =  cds.entities('School.library');

module.exports = (srv)=>{
    srv.before("CREATE","InsertBooks",(req,res)=>{
        if(req.data.stock<=1){
            req.error(500,"stock is empty");
        }
        return "good";
    })
    srv.on('CREATE','DeleteBooks',async (req,res)=>{
        const id = req.data.ID;
        try {
            const result = await cds.transaction(req).run(
                DELETE.from(Books).where({ ID: id })
            );

            if(result.length === 0){
                req.error(404,`Cannot delete Book`);
            }
            else{
                return {message: "Deleted"}
            }
        } catch (err) {
            req.error(500, 'Error while deleting the book.');
        }
        //using promises
        // const result = await cds.transaction(req).run(
        //         DELETE.from(Books).where({
        //             ID:req.data.ID
        //         })
        //     )
        //     .then((res,rej) => {
        //         console.log(res);
        //         console.log(rej);

        //         if(typeof res !== "undefined"){
        //             return req.data
        //         }else{
        //             req.error(409,"Record not found");
        //         }
                
        //     })
        //     .catch((err) => {
        //         console.log(err);
        //         req.error(500,"Error in updating");
        //     });
        // console.log(result);
        // return result;
    })
}
