67-272: Bread Express
---
I, Matthew Kern, have created this repository from the pahse 5 starter code.

Some Notes that I actually would like you to read:

- Your db:populate script may or may not mark empoyees as active or inactive. For reporting purposes, employees with a null field are generally treated as inactive by my application, but this is not an ideal way to handle it for a number of reasons. I would encourage you to make sure that all users are either active or inactive, but if you don't I would ask for some a little ui/ux leaway where relavent. See my piazza post if you're interested.
- I used the chartkick gem in addition to many that were recommended by prof h. It is awesome - would highly recommend

Other stuff that I don't care if you read:

To set this up, clone this repository, run the `bundle install` command to ensure you have all the needed gems and then create the database with `rake db:migrate`.  If you want to populate the system with fictitious, but somewhat realistic data, you can run the `rake db:populate` command.  The populate script will create:
- 120 customers
- over 600 orders
- a menu of 5 types of breads, 3 varieties of muffins and 1 type of pastry

Many objects are created with some element of randomness so you will get slightly different results each time it is run.  However, employee-type users are fixed.  In terms of employee-type users there are two admins -- Alex (username: 'alex') and Mark (username: 'mark') -- and a shipper (username: 'shipper') and a baker (username: 'baker').  All customers have a username which is 'user' with a sequential set of numbers concatentated. (user1 - user120 should exist for you to log in as and experiment.)  All users in the system have a password of 'secret'.

Note: the images in this website are not my own, namely...
- the logo can be found here (https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Bread_-_The_Noun_Project.svg/100px-Bread_-_The_Noun_Project.svg.png) and was created by the noun project. It is used according to the creative commons liscense (https://creativecommons.org/licenses/by/4.0/deed.en)
