# Street Food Blogger
# Introduction:
Street food is an old notion that arose from the need from quick access to light food to satisfy hunger. These are ready-to-eat foods and beverages offered by vendors 
in open public spaces, primarily on streets. However, peoples are still confused which places are better for street foods. So, I will try to make a food reviewing system 
according to places. Users will be able to see the information and give their ratings and reviews. I am planning to implement this project using PLSQL.

# Database Schema:
DISTRICTS (DistID, DistName)<br/>
AREAS (AreaID, AreaName, DistID)<br/>
FOODS (FoodID, FoodName, Price, Rating, AreaID)<br/>
REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime)

# Why Distributed Database:
Distributed database is required to implement this project to set a connection between user computer and server computer. When a user gives rating it will change the 
overall rating of that food so, it requires a connection between server computer and user.
