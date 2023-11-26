// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyA6Re7qSlSePRJ3OgRZG-Nni6Rvdb1vFuQ",
  authDomain: "test-76680.firebaseapp.com",
  projectId: "test-76680",
  storageBucket: "test-76680.appspot.com",
  messagingSenderId: "36272837547",
  appId: "1:36272837547:web:92281e4691094f273878ee",
  measurementId: "G-7KTT989L5H"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);