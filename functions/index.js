

const functions = require("firebase-functions");
const axios = require('axios');
require('dotenv').config();
//const { onCall } = require("firebase-functions/v2/https");
//const admin = require('firebase-admin');
//admin.initializeApp();

// The Firebase Admin SDK to access Firestore.
const {logger} = require("firebase-functions");
const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");


initializeApp();

exports.addmessage = onRequest(async (req, res) => {
  // Grab the text parameter.

  let original = req.query
  console.log("QUERY Value", original.query);


  // Push the new message into Firestore using the Firebase Admin SDK.
  const writeResult = await getFirestore()
      .collection("messages")
      .add({original: original.query ?? "Hello"});
  // Send back a message that we've successfully written the message
  res.json({result: `Message with ID: ${writeResult.id} added.`});
});


//var serviceAccount = require("./serviceAccountKey.json");
//admin.initializeApp({
//  credential: admin.credential.cert(serviceAccount)
//});



const { handleRequest } = require('./api');

// Handle all types of HTTP requests
exports.apiFunction = functions.https.onRequest(handleRequest);





// // Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = functions.region("asia-southeast2").https.onRequest((request, response) => {
  
    functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});


exports.yourV1CallableFunction = functions.region("asia-southeast2")
  .runWith({
      enforceAppCheck: true, // Reject requests with missing or invalid App Check tokens.
  })
  .https.onCall((data, context) => {
        console.log("AppCheck");
  });

exports.payMongo = functions.region("asia-southeast2").https.onCall(async (data, context) => {
  //const { method, payload } = data;

  console.log("Post Todos" + data.amount);

  const postData = {
    "data": {
      "attributes": {
        "amount": data.amount,
        "description": data.description,
        "remarks": data.remarks
      }
    }
  }

   try {

         const headers = {
           "Accept": "*/*",
           "Content-Type": "application/json",
           "Authorization": "Basic c2tfdGVzdF9haWJVdkJycG9vc3BXdHFmbmQ1dXI4VVk6",
         };
    
    
         const result = await axios({
           method: "POST",
           headers,
           url: "https://api.paymongo.com/v1/links",
           data: postData,
         });

         console.log('Sucess',result.data);

          return JSON.stringify(result.data);
  
//           return {
//             status: 'success',
//             message: 'Todo added successfully',
//             data: data,
//           };
       // Other cases...
    
   } catch (error) {
     throw new functions.https.HttpsError(
       error.code || 'unknown',
       error.message || 'An unknown error occurred.'
     );
   }
});


exports.todoFunction = functions.region("asia-southeast2")
.runWith({
      enforceAppCheck: true, // Reject requests with missing or invalid App Check tokens.
  })
.https.onCall(async (data, context) => {
    //const { method, payload } = data;

    console.log("Post Todos" + data.title);

    const postData = {
            'title': data.title,
          'description': data.description,
          'is_completed': data.is_completed,
    }
  
     try {
 
           const headers = {
            "Accept": "*/*",
             "Content-Type": "application/json",
           };


           const result = await axios({
             method: "POST",
             headers,
             url: "https://api.nstack.in/v1/todos/",
             data: postData,
           });

           console.log('Sucess',result.data);

            return JSON.stringify(result.data);

//           return {
//             status: 'success',
//             message: 'Todo added successfully',
//             data: data,
//           };
         // Other cases...
      
     } catch (error) {
       throw new functions.https.HttpsError(
         error.code || 'unknown',
         error.message || 'An unknown error occurred.'
       );
     }
  });
  


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







