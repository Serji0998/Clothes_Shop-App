//IMPORTS
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const { socket } = require("server/router");


//CREATE SERVER
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require('socket.io')(server);


//middle ware between FRONTEND AND BACKEND
app.use(express.json());


//Connection to mongoDB
//in uri replace username and password with your own mongoDB account user and pass
const uri = "mongodb+srv://username:password@"

// Create a MongoClient with a MongoClientOptions object to set the Stable API version
mongoose.connect(uri).then(()=>{
  console.log("Connected to mongoDB user Successfully!");
})
.catch((e)=>{
  console.log(e);
});


// Define a Mongoose schema and model for user data
const userSchema = new mongoose.Schema({
  username: String,
  password: String,
  phonenumber: String,
}, { versionKey: false });

// Define a Mongoose schema and model for Product data
const ProductsSchema = new mongoose.Schema({
  productName: String,
  price: String,
  description:String,
  image: String,
}, { versionKey: false });


//Define Database Collections
const User = mongoose.model('User', userSchema);
const Product = mongoose.model('Product', ProductsSchema);


// Set up the change stream on the 'Product' collection
const productChangeStream = Product.watch();

// Handle changes in the 'Product' collection
productChangeStream.on('change', async (next) => {
  try {
    // Retrieve all products from the 'Products' collection using the Product model
    const products = await Product.find();

    // Emit the 'productUpdated' event to connected clients with all products
    io.emit('productUpdated', products);
  } catch (error) {
    console.error('Error fetching products for update:', error);
  }
});

//io server events handler
io.on('connection', (socket) => {
  console.log(socket.id);

  // Handle the 'signup' event from the client
  socket.on('signup', async (userData) => {
    try {
      // Save user data to the database
      const newUser = new User(userData);
      await newUser.save();
      console.log('User signed up:', newUser);

      // Emit a response back to the client if needed
      socket.emit('signupResponse', { message: 'Signup successful' });
    } catch (error) {
      console.error('Error signing up user:', error);

      // Emit an error response back to the client if needed
      socket.emit('signupResponse', { error: 'Signup failed' });
    }
  });

  // Handle the 'searchUser' event from the client
socket.on('searchUser', async (userData) => {
  try {
    const { username, password } = userData;
    const foundUser = await User.findOne({ username });

    if (foundUser) {
      // If user is found, check if the password matches
      if (foundUser.password === password) {
        console.log('User found:', foundUser);
        socket.emit('searchUserResponse', { user: foundUser });
      } else {
        console.log('Incorrect password');
        socket.emit('searchUserResponse', { message: 'Incorrect password' });
      }
    } else {
      console.log('User not found');
      socket.emit('searchUserResponse', { message: 'User not found' });
    }
  } catch (error) {
    console.error('Error searching for user:', error);
    socket.emit('searchUserResponse', { error: 'Search failed' ``});
  }
});


// Handle the 'getProducts' event from the client
socket.on('getProducts', async () => {
  try {
    // Retrieve products from the 'Products' collection using the Product model
    const products = await Product.find();

    // Log the obtained products
    console.log('Products sent to the client:', products);

    // Emit the 'getProductsResponse' event with the obtained products
    socket.emit('getProductsResponse', products);

    // No need to emit 'productUpdated' here
  } catch (error) {
    console.error('Error fetching products:', error);

    // Emit an error response back to the client if needed
    socket.emit('getProductsResponse', { error: 'Failed to fetch products' });
  }
});
});

//LISTEN SERVER
server.listen(port,"0.0.0.0",()=>{
  console.log(`Server connected on port ${port}`);
});




