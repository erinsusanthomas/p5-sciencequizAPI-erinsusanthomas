ScienceQuiz API :: Spring 2021
===

The technical challenge we have for you in this phase is to build a basic API for the Science Quiz project you have been developing in 67-272 this semester.  This will cover a number of skills discussed in class related to controllers, routing and serialization.

This project is being released on Sunday, April 25, 2021 via our course Github Classroom and must be completed and posted back to your private repository on classroom no later than **11:59pm on May 4th, 2021**.  It should not take long to complete it.

Getting Started
---
Having downloaded the starter code for the API, you need to first install the gem libraries we've specified with `bundle install`.  You will not need, nor should you use, any other gems other than the ones given to you.  The starter code has all the models, services, lib extensions and the used in the phase 3 and 4 code for the final project (just no controllers, routes or serializers).

Second, we have provided a script to build your dev and test databases and prepopulate them with the testing context data (also used to generate the samples provided).  To do this, simply run `rails db:contexts` on the command line (assuming you are in the main directory for the project).

Verify that everything is in working order by running the tests for the models provided: `rails test:models`.  If the tests do not run or do not all pass, contact Prof. Houda via email and post a private question on piazza so you can get assistance from someone as soon as possible.


Requirements
---
You mission, should you choose to accept it, is to create 5 endpoints for a Science Quiz API.  Those endpoints are:

- GET http://localhost:3000/organizations
- GET http://localhost:3000/organizations/{id}
- POST http://localhost:3000/organizations
- PATCH http://localhost:3000/organizations/{id}
- DELETE http://localhost:3000/organizations/{id}


You must create custom routes to generate these endpoints (no `resources :model` allowed) and write custom controllers that only contain the custom actions required.  Do NOT use rails scaffolding -- we have specific tests to test for this and if you did this, you will drop to 50 percent credit as the ceiling immediately; part of the learning assessment here is your ability to write these things for yourselves.


API Documentation
---
Now that you have created the API you will need to document it. Documentation is crucial for RESTful API's since there are no views tied to the application, which means there is no way for users to know what endpoints exist and what capabilities the API has. Good thing that there is an easy to way autogenerate some nice Documentation using Swagger for your API. We added the gem, initializer and api-swagger docs under `public` for you. All you need to do is to document your API endpoints. Again here, Again you are only going to  document Organizations Controller. Make sure you document all the endpoints specified above.  

Custom Serialization
---

Now that we have created the barebone API for Science Quiz and documented its Organization endpoints, you will have to create a serializer with which we can customize the Organization JSON objects returned for each request. 
You will use the [fast_json api](https://github.com/Netflix/fast_jsonapi) for serialization.

A sample from each of these endpoints is provided to you in the `samples` directory under `docs/phase_5`.  These outputs were generated with the context data running the script referenced above.  At the top of each sample is the cURL command used to generate the json output (see note below on pretty printing the output; this is for your convenience and not strictly necessary).  

Note that our testing data will differ slightly from the data we populate the database with in the `db:contexts` script and we may use different ID numbers in the endpoint call.  This will ensure that you don't simply return the sample text in the method, but actually generated it properly using serializers and controllers.

You will have to follow the content of each sample to create the customized serialisation for any Organization object.

Constraints
---
You are free to use your notes, look at the PATS API code posted online, and look at the labs we did for API building.  You may look at the online API for Rails at [apidock.com](https://apidock.com). Most importantly, you cannot share code or converse with any present or past student in the class regarding this assignment while it is ongoing.  _More constraints are spelled out in the Academic Integrity statement that you must complete to get credit for this assignment,_ so be sure to read and electronically sign this pledge.


Completing the Assignment
---
The assignment must be completed and posted on your private repository (same place you retrieved this code from) no later than **11:59pm EDT on May 4th, 2021**.  The code must be on the main branch (no other branches will be graded). At the due time, all student repositories will be locked and you will have no further access. Do not attempt to zip your code and email it to Prof. Houda or to Preeetha after the deadline.

Partial credit is available, of course, and you will get credit for as many of the endpoints you can correctly complete in the time allowed. 

---
Post Script on JSON Formatting
---
Pretty printing json as you see it in the samples is not particularly hard, but not how json comes by default. 
All you need to do is to run the following code, and use `prettyjson` each time you need it.
 
`alias prettyjson="python3 -m json.tool"`


That said, it might be easier for many of you to use Chrome extension [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa) that I also used in lecture for pretty printing your json and making it more readable. There should be no issue running these endpoints in the browser, as was done in lecture several times.


