// const functions = require("firebase-functions");

// exports.api = functions.https.onRequest((request, response) => {
//     switch(request.method){
//      case 'GET':
//          response.send("Get Request");
//          break;
//      case 'POST':
//          const body = request.body;
//          response.send(body);
//          break;
//      case 'PUT':
//          response.send("Update Request");
//          break;
//      case 'DELETE':
//          response.send("Delete Request");
//          break;
//      default:    
//          response.send("DefaultRequest");                  
 
//     }
//    });
const axios = require('axios');

function handleRequest(req, res) {
    switch (req.method) {
        case 'GET':
            handleGet(req, res);
            break;
        case 'POST':
            handlePost(req, res);
            break;
        case 'PUT':
            handlePut(req, res);
            break;
        case 'DELETE':
            handleDelete(req, res);
            break;
        default:
            res.status(405).send('Method Not Allowed');
    }
}

async function payMongo(req, res) {

    try{

        const headers = {
            Accept: "*/*",
            "Content-Type": "application/json",
            "Authorization": "Basic c2tfdGVzdF9haWJVdkJycG9vc3BXdHFmbmQ1dXI4VVk6",

          };
      
        const data = req.body;
    
        console.log("Response Data", data.title);
    
        await axios({
            method: "POST",
            headers,
            url: "https://api.nstack.in/v1/todosss",
            data: data,
          });
    
        res.status(201).json({
            status: 'success',
            message: 'Successfully added',
            data: data
        });
    }catch(error){

        // if (error.response) {
        //     // Get status code from the error response
        //     console.error('Error Status Code:', error.response.status); // Example: 500
        //     console.error('Error Response:', error.response.data);
        //   } else if (error.request) {
        //     // No response received from server (network or client error)
        //     console.error('Request made, but no response:', error.request);
        //   } else {
        //     // Other errors
        //     console.error('Error:', error.message);
        //   }
        console.log('ERROR',error);
        return res.status(500).json({ status: res.status, message: error.message });
    }
    

  
    //res.status(201).send(`POST request successful with data: ${ JSON.stringify( data)}`);
}

async function handleGet(req, res) {
    try {

        console.log('API',process.env.API_KEY);
        //const response = await axios.get('https://jsonplaceholder.typicode.com/todos/2');

    const headers = {
      Accept: "*/*",
      "Content-Type": "application/json",
    };

    const response = await axios({
      method: "GET",
      headers,
      url:  "https://api.nstack.in/v1/todos" //"https://api.nstack.in/v1/todos/?page=1&limit=10",
    
    });

    res.status(200).json({
        status: 'success',
        message: 'Todo List',
        data: response.data
    });
       // res.status(200).json(response.data);
        
    } catch (error) {
        res.status(500).send('Error fetching data');
    }
}

async function handlePost(req, res) {

    try{

        const headers = {
            Accept: "*/*",
            "Content-Type": "application/json",
          };

        const data = req.body;

        console.log("Response Data", data.title);

        await axios({
            method: "POST",
            headers,
            url: "https://api.nstack.in/v1/todos",
            data: data,
          });

        res.status(201).json({
            status: 'success',
            message: 'Successfully added',
            data: data
        });
    }catch(error){

        // if (error.response) {
        //     // Get status code from the error response
        //     console.error('Error Status Code:', error.response.status); // Example: 500
        //     console.error('Error Response:', error.response.data);
        //   } else if (error.request) {
        //     // No response received from server (network or client error)
        //     console.error('Request made, but no response:', error.request);
        //   } else {
        //     // Other errors
        //     console.error('Error:', error.message);
        //   }
        console.log('ERROR',error);
        return res.status(500).json({ status: res.status, message: error.message });
    }
    

  
    //res.status(201).send(`POST request successful with data: ${ JSON.stringify( data)}`);
}

async function handlePut(req, res) {
    const headers = {
        Accept: "*/*",
        "Content-Type": "application/json",
      };
  
    const data = req.body;

    console.log(req.body);

    await axios({
        method: "PUT",
        headers,
        url: "https://api.nstack.in/v1/todos/"+ data.id,
        data: data,
      });

    res.status(200).json({
        status: 'success',
        message: 'Successfully updated',
        data: data
    });
    //res.status(200).send(`PUT request successful with data: ${JSON.stringify(data)}`);
}

function handleDelete(req, res) {
    res.status(200).send('DELETE request successful');
}

module.exports = { handleRequest };




