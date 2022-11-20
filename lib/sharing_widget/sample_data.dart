// const RE_DATA = [
//   {
//     "image": "lib/assets/image1.jpg",
//     "amount": "20000",
//     "Address": "Jul-Solapur",
//     "location": "Solapur",
//     "Description": "Lorem "
//   },
//   {
//     "image": "lib/assets/image1.jpg",
//     "amount": "20000",
//     "Address": "Jul-Solapur",
//     "location": "Solapur",
//     "Description": "Lorem "
//   }
// ];

// const List categoriesList = [
//   {
//     "title": "Properties",
//     "img": "lib/assets/images/icon/property.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Properties Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Properties Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Properties Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Properties Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Properties Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Mobile",
//     "img": "lib/assets/images/icon/mobiles.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Mobile Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Mobile Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Mobile Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Mobile Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Mobile Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Jobs",
//     "img": "lib/assets/images/icon/jobs.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Jobs Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Jobs Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Jobs Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Jobs Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Jobs Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Bike",
//     "img": "lib/assets/images/icon/bikes.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Bike Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Bike Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Bike Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Bike Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Bike Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Electronics & Appliance",
//     "img": "lib/assets/images/icon/elections_appliances.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Electronics Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Appliance Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Appliance Sub Categories Name of 3"},
//       {
//         "subCatId": "4",
//         "subCatName": "Electronics & Appliance Sub Categories Name of 4"
//       },
//       {"subCatId": "5", "subCatName": "Electronics Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Commercial Vehicles",
//     "img": "lib/assets/images/icon/bikes.png",
//     "SubCategories": [
//       {
//         "subCatId": "1",
//         "subCatName": "Commercial Vehicles Sub Categories Name of 1"
//       },
//       {
//         "subCatId": "2",
//         "subCatName": "Commercial Vehicles Sub Categories Name of 2"
//       },
//       {
//         "subCatId": "3",
//         "subCatName": "Commercial Vehicles Sub Categories Name of 3"
//       },
//       {
//         "subCatId": "4",
//         "subCatName": "Commercial Vehicles Sub Categories Name of 4"
//       },
//       {
//         "subCatId": "5",
//         "subCatName": "Commercial Vehicles Sub Categories Name of 5"
//       },
//     ]
//   },
//   {
//     "title": "Furniture",
//     "img": "lib/assets/images/icon/furniture.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Furniture Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Furniture Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Furniture Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Furniture Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Furniture Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Fashion",
//     "img": "lib/assets/images/icon/fashion.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Fashion Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Fashion Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Fashion Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Fashion Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Fashion Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Books, Sports & Hobbies",
//     "img": "lib/assets/images/icon/hobbies.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Books Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Sports Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Hobbies Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Books Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Hobbies Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Pets",
//     "img": "lib/assets/images/icon/pets.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Pets Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Pets Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Pets Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Pets Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Pets Sub Categories Name of 5"},
//     ]
//   },
//   {
//     "title": "Services",
//     "img": "lib/assets/images/icon/services.png",
//     "SubCategories": [
//       {"subCatId": "1", "subCatName": "Services Sub Categories Name of 1"},
//       {"subCatId": "2", "subCatName": "Services Sub Categories Name of 2"},
//       {"subCatId": "3", "subCatName": "Services Sub Categories Name of 3"},
//       {"subCatId": "4", "subCatName": "Services Sub Categories Name of 4"},
//       {"subCatId": "5", "subCatName": "Services Sub Categories Name of 5"},
//     ]
//   }
// ];

// const List addLists = [
//   {
//     "id": "1",
//     "image1": "lib/assets/images/add/1bhk1.jpeg",
//     "image2": "lib/assets/images/add/1bhk2.jpeg",
//     "image3": "lib/assets/images/add/1bhk2.jpeg",
//     "amount": "5000",
//     "name":
//         "1BKH apartment for sales at tanish Shursti, Alandi-Markal Road, Alandi",
//     "subtitle": "1BHK - 650Ft2",
//     "location": "Alandi-Markal Road,",
//     "district ": "Pune",
//     "features": "yes",
//     "favorite": "yes"
//   },
//   {
//     "id": "2",
//     "image1": "lib/assets/images/add/m301.jpg",
//     "image2": "lib/assets/images/add/m302.jpg",
//     "image3": "lib/assets/images/add/m302.jpg",
//     "amount": "12000",
//     "name": "Sale Samsung Galaxy M30",
//     "subtitle": "Galaxy M30 2 year old 4gb 65gb",
//     "location": "Swargate,",
//     "district ": "Pune",
//     "features": "yes",
//     "favorite": "no"
//   },
//   {
//     "id": "3",
//     "image1": "lib/assets/images/add/iphone8-1.jpg",
//     "image2": "lib/assets/images/add/iphone8-2.jpg",
//     "image3": "lib/assets/images/add/iphone8-2.jpg",
//     "amount": "15000",
//     "name": "Iphone 8 in good condition",
//     "subtitle": "Iphone 8 in good condition",
//     "location": "Shivaji Nagar,",
//     "district ": "Solapur",
//     "features": "yes",
//     "favorite": "no"
//   },
//   {
//     "id": "4",
//     "image1": "lib/assets/images/add/BMW1.jpg",
//     "image2": "lib/assets/images/add/BMW2.jpg",
//     "image3": "lib/assets/images/add/BMW2.jpg",
//     "amount": "599999",
//     "name": "BMW 3 Series(2010)",
//     "subtitle": "2015 - 1500Km",
//     "location": "Jaysingpur",
//     "district ": "Kolhapur",
//     "features": "yes",
//     "favorite": "no"
//   },
//   {
//     "id": "5",
//     "image1": "lib/assets/images/add/2bhk1.jpeg",
//     "image2": "lib/assets/images/add/2bhk2.jpeg",
//     "image3": "lib/assets/images/add/2bhk2.jpeg",
//     "amount": "3815000",
//     "name": "# Big 1 BHK Flat at new town Home, Kharadi At 38.15 Lacs only",
//     "subtitle": "1BHK - 750Ft2",
//     "location": "Damani Nagar",
//     "district ": "Solpaur",
//     "features": "no",
//     "favorite": "no"
//   },
//   {
//     "id": "6",
//     "image1": "lib/assets/images/add/headphone1.jpg",
//     "image2": "lib/assets/images/add/headphone12.jpg",
//     "image3": "lib/assets/images/add/headphone13.jpg",
//     "amount": "1200",
//     "name": "Boat Speaker",
//     "subtitle": "Boat Speaker",
//     "location": "Shivaji Nagar",
//     "district ": "Mumbai",
//     "features": "no",
//     "favorite": "no"
//   },
//   {
//     "id": "7",
//     "image1": "lib/assets/images/add/watch1.jpg",
//     "image2": "lib/assets/images/add/watch12.jpg",
//     "image3": "lib/assets/images/add/watch13.jpg",
//     "amount": "3500",
//     "name": "Rare Antique Automatic watches",
//     "subtitle": "",
//     "location": "Rasta Path",
//     "district ": "Pune",
//     "features": "no",
//     "favorite": "yes"
//   },
//   {
//     "id": "8",
//     "image1": "lib/assets/images/add/redmi11_1.jpg",
//     "image2": "lib/assets/images/add/redmi11_12.jpg",
//     "image3": "lib/assets/images/add/redmi12.jpg",
//     "amount": "22000",
//     "name": "Redmi 11x 5g",
//     "subtitle": "",
//     "location": "Saraswati chowk",
//     "district ": "Solapur",
//     "features": "no",
//     "favorite": "no"
//   },
//   {
//     "id": "9",
//     "image1": "lib/assets/images/add/3bhk1.jpeg",
//     "image2": "lib/assets/images/add/3bhk2.jpeg",
//     "image3": "lib/assets/images/add/3bhk2.jpeg",
//     "amount": "7000",
//     "name": "2BKH Fla available on Rent 7000/- Rs",
//     "subtitle": "2BHK - 550Ft2",
//     "location": "Assra Chowk",
//     "district ": "Solapur",
//     "features": "no",
//     "favorite": "no"
//   },
// ];

// const List chartBoardList = [
//   {
//     "userName": "Sanaulla Shaikh",
//     "userImg": "lib/assets/user/sanaulla.jpg",
//     "userLastSeen": "2022-08-20",
//     "lastMessage": "Hi, I am sanaulla",
//     "messageStatus": "read",
//     "postTitle": "Iphone 8 Pro 2 year old",
//     "postImg": "lib/assets/images/add/iphone8.jpg",
//     "price" : 50000,
//     "postType": "Buy"
//   },
//   {
//     "userName": "Sameer Shaikh",
//     "userImg": "lib/assets/user/man.png",
//     "userLastSeen": "2022-08-20",
//     "lastMessage": "Hi, I am sameer",
//     "messageStatus": "read",
//     "postTitle": "Laptop i7 8gen 8gb 5 year old",
//     "postImg": "lib/assets/images/add/iphone8.jpg",
//     "price" : 80000,
//     "postType": "Sale"
//   },
//   {
//     "userName": "Abdul Kadir Shaikh",
//     "userImg": "lib/assets/user/man.png",
//     "userLastSeen": "2022-08-20",
//     "lastMessage": "Hi, I am Kadir",
//     "messageStatus": "received",
//     "postTitle": "Laptop i7 8gen 8gb 5 year old",
//     "postImg": "lib/assets/images/add/iphone8.jpg",
//     "price" : 120000,
//     "postType": "Sale"
//   },
//   {
//     "userName": "Gazala fareen shaikh",
//     "userImg": "lib/assets/user/woman.png",
//     "userLastSeen": "2020-08-01",
//     "lastMessage": "Hi, I am Gazala",
//     "messageStatus": "received",
//     "postTitle": "Mobile 8gb 64GB 1 year old",
//     "postImg": "lib/assets/images/add/iphone8.jpg",
//     "price" : 15000,
//     "postType": "Buy"
//   }
// ];


// const List chats_detils = [
//     {
//         "msg" : "Hi Sanaulla",
//         "msgDate" : "2020-08-20",
//         "msgSend" : 2,
//         "msgStatus" : "red",
//     },
//     {
//         "msg" : "Hi, How are you",
//         "msgDate" : "2020-08-21",
//         "msgSend" : 1,
//         "msgStatus" : "derived",
//     },
//     {
//         "msg" : "Hello?",
//         "msgDate" : "2020-08-22",
//         "msgSend" : 1,
//         "msgStatus" : "derived",
//     },
//     {
//         "msg" : "Hi Ganesh",
//         "msgDate" : "2020-08-10",
//         "msgSend" : 3,
//         "msgStatus" : "derived",
//     }    
// ];

// spread operator
// for (var cat in catData) ...[cardCate(cat: cat)],
//    SizedBox(
//    // color: Colors.red,
//      width: 190,
//      height: 190,
//    )
