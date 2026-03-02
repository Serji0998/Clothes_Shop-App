# 👕 Clothes Shop: Real-Time Mobile E-Commerce
> A cross-platform mobile application built with **Flutter** and **Node.js**, featuring real-time inventory updates and instant user synchronization via **Socket.io**.

---

## 🚀 Technical Highlights

* **📱 Cross-Platform UI:** Developed with **Flutter & Dart** for a smooth, native-feeling user experience on both iOS and Android.
* **⚡ Real-Time Inventory:** Implements **Socket.io** and **MongoDB Change Streams**. When a product is added or changed in the database, all connected users see the update instantly without refreshing.
* **🔐 Event-Driven Authentication:** User registration and login are handled via WebSocket events, reducing HTTP overhead.
* **📦 NoSQL Architecture:** Uses **MongoDB Atlas** with Mongoose schemas to manage flexible product catalogs and user profiles.

---

## 🛠 Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Mobile Frontend** | Flutter (Dart) |
| **Backend Runtime** | Node.js |
| **Real-Time Engine** | Socket.io |
| **Database** | MongoDB (Mongoose ODM) |
| **Server Framework** | Express.js |

---

## 🧠 Key Logic: Change Streams
A standout feature of this project is the backend integration of **MongoDB Change Streams**. 
The server "watches" the collection and automatically emits a `productUpdated` event to all clients whenever the catalog changes:

## javascript
// Server-side logic for instant updates
productChangeStream.on('change', async () => {
   const products = await Product.find();
   io.emit('productUpdated', products); 
});

# GUI

![dart 2](https://github.com/user-attachments/assets/1f641ce8-2f69-4772-9a1c-f4f8d63b5a3e)

![dart 3](https://github.com/user-attachments/assets/abab18cb-8d1b-41df-993d-2ae2bed33989)

![dart 1](https://github.com/user-attachments/assets/53e35594-1aaa-41f2-9fe0-48b255fb8e16)

![dart 4](https://github.com/user-attachments/assets/6e634049-e6e8-492e-a7d7-c889260394a1)
