67-272: Baking Factory
---

Hello, thanks for checking out my project. I, Matthew Kern, have created this repository from the phase 5 starter code (on gitlab using multiple branches, I promise) for the Application Design and Development class at Carnegie Mellon University (67-272). This project was created in 5 phases, each of which built on the previous one. The starter code for each phase was essentially the solution of the previous phase so, although this was bases off of the starter code, I essentially built this myself over the course of one semester. Due to the size of the project and the compressed time scale, I will admit to failing a few convensions and style guidelines in some places and appologize for any inconvenience, although I think the overal quality of the work is still impressive which is why I am posting it. Please do reach out to me at mjkern@andrew.cmu.edu if you have any questions, and please do not use this code for your own homework/assignments (while I do have permission to post this code I still would like to avoid academic integrity issues). The remainder of the readme is essentially left as I submitted it for grading.

Some Notes:

- Your db:populate script may or may not mark empoyees as active or inactive. For reporting purposes, employees with a null field are generally treated as inactive by my application, but this is not an ideal way to handle it for a number of reasons. I would encourage you to make sure that all users are either active or inactive, but if you don't I would ask for some a little ui/ux leaway where relavent. See my piazza post if you're interested.
- I used the chartkick gem in addition to many that were recommended by prof h. It is awesome - would highly recommend
- Generally customers only see inactive items when viewing their past orders. Trying to order inactive items will fail, and can cause problems with the shipping list as well.

Other Stuff:

To set this up, clone this repository, run the `bundle install` command to ensure you have all the needed gems and then create the database with `rake db:migrate`.  If you want to populate the system with fictitious, but somewhat realistic data, you can run the `rake db:populate` command.  The populate script will create:
- 120 customers
- over 600 orders
- a menu of 5 types of breads, 3 varieties of muffins and 1 type of pastry

Many objects are created with some element of randomness so you will get slightly different results each time it is run.  However, employee-type users are fixed.  In terms of employee-type users there are two admins -- Alex (username: 'alex') and Mark (username: 'mark') -- and a shipper (username: 'shipper') and a baker (username: 'baker').  All customers have a username which is 'user' with a sequential set of numbers concatentated. (user1 - user120 should exist for you to log in as and experiment.)  All users in the system have a password of 'secret'.

Note: the images in this website are not my own, namely...
- the logo can be found here (https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Bread_-_The_Noun_Project.svg/100px-Bread_-_The_Noun_Project.svg.png) and was created by the noun project. It is used according to the creative commons liscense (https://creativecommons.org/licenses/by/4.0/deed.en)
