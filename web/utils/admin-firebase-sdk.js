/*
************    ****    ************        ************    ************              ****          ************
****            ****    ****        ****    ****            ****        ****      ****    ****      ****
****            ****    ****        ****    ****            ****        ****    ****        ****    ****
************    ****    ****************    ************    ************        ****        ****    ************
****            ****    ****    ****        ****            ****        ****    ****************            ****
****            ****    ****        ****    ****            ****        ****    ****        ****            ****
****            ****    ****        ****    ************    ************        ****        ****    ************
*/
const admin_firebase_sdk = require("firebase-admin");
const serviceAccount = require("../uploads/svdkhp-firebase-adminsdk-8gd6f-f8404ded43.json");
admin_firebase_sdk.initializeApp({
    credential: admin_firebase_sdk.credential.cert(serviceAccount)
});
const firebaseDB = admin_firebase_sdk.firestore();
module.exports = { admin_firebase_sdk, firebaseDB };