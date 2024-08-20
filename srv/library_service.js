const cds = require("@sap/cds");
const {Books} =  cds.entities('School.library');

module.exports = (srv)=>{
    srv.on('READ','Books',async (req,res)=>{
        const { SELECT } = cds.ql;
        const af=req.query.SELECT;
        if(typeof af.from.ref[0].where=="undefined"){
            var tempres = await SELECT.from(Books);
            tempres= tempres.filter(row=>row.stock!=20);
            return tempres;
        }
        else{
            console.log(af.from.ref[0].where[2].val);
            console.log(af.from.ref[0].where[6].val);
            const result = await SELECT.from(Books).where({
                ID : af.from.ref[0].where[2].val,
                stock : af.from.ref[0].where[6].val
                
            });
            return result;
        }
    })
    srv.after('READ','Books',(each)=>{
        if (each.stock <= 10){
            return each.title += '--Special Edition';
        }
    })
    srv.after('READ','Books',(each)=>{
        if(each.stock <=10){
            // return ...each,stock:stock*10
            return each.price_amount=each.price_amount*27;
        }
    })


    
    // update book / post / put 
    srv.on('CREATE','UpdateBooks',async (req,res)=>{
        let id=req.data.ID;
        let stocks = req.data.stock;
        
        try {
            const result = await cds.transaction(req).run(
                UPDATE(Books).set({ stock: stocks }).where({ ID: id})
            );
            
            if (result.length === 0) {
                req.error(404, `Book with ID ${id} not found.`);
            } else {
                return { message: "Success" };
            }
        } catch (err) {
            console.error(err);
            req.error(500, 'Error while updating the book.');
        }
    })
    
    // create book / POST
    srv.on('CREATE','InsertBooks',async (req,res)=>{
        const id=req.data.ID;
        const stocks=req.data.stock;
        try{
            const result = await cds.transaction(req).run(
                INSERT.into(Books).into(Books).entries({
                    ...req.data,
                    ID:id,
                    stock:stocks
                })
            )

            if(result.length === 0){
                req.error(404,`Cannot add Book`);
            }
            else{
                return {message: "Updated"}
            }
        }catch(err){
            console.error(err);
            req.error(500, 'Error while Creating the book.')
        }
        // return req.data;
    });
    
    //delete book/ delete
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
