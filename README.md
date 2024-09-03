# HospitalityHotelDBSystem

The project involved the creation and management of a relational database for a hospitality hotel. The database, named HospitalityHotelDb, was designed to store and manage data related to states, rooms, bookings, and guests. The project aimed to enhance the hotel’s data management capabilities by providing a structured and efficient way to handle room bookings, guest information, and related operations.

## Tools and Technologies Used
-	Database Management System: SQL Server
-	SQL: For database creation, table management, data insertion, querying, and stored procedures.
-	SQL Views: For creating custom views of specific data.
-	SQL Procedures: For automating specific tasks within the database.

  
## Methodology
-	Database and Table Creation: The project began with the creation of the HospitalityHotelDb database, followed by the establishment of essential tables: StateMaster, Room, and Booking. The StateMaster table was designed to hold state information, while the Room and Booking tables managed room details and booking records, respectively.
-	Data Insertion: Initial data was inserted into the StateMaster, Room, and Booking tables. This data represented various states, room types, and booking records, allowing for testing and further development of the database.
-	Views and Stored Procedures: The project included the creation of a SQL view named ExpensiveBookings to filter bookings with amounts greater than $1000. Additionally, stored procedures were developed:
-	UpdateRoomPrices: Adjusted room prices by 10% for all suite rooms, except those in Lagos.
-	FetchBookingDetails: A stored procedure to fetch and display comprehensive booking details, including error handling mechanisms.

  
## Results
- The project successfully established a robust database structure that allows for efficient storage, retrieval, and management of hotel data. The advanced queries provided critical insights into guest behavior, room utilization, and booking trends. The stored procedures automated key operations, ensuring consistency and reducing manual intervention.

  
## Project Impact on Business
The implementation of the HospitalityHotelDb database system significantly improved the hotel’s ability to manage and analyze its operations. Key impacts include:
-	Enhanced Data Management: Centralized data storage allows for easy access and manipulation of critical hotel information, reducing errors and improving operational efficiency.
-	Improved Decision Making: The advanced queries and reports generated from the database enable hotel management to make informed decisions based on real-time data.
-	Increased Revenue: Automated procedures, like price adjustments, ensure that the hotel remains competitive while maximizing revenue from room bookings.
-	Customer Insights: The ability to track and analyze guest spending patterns and preferences helps tailor services to enhance guest satisfaction and retention.
