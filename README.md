# AMU-EDT

## A little story time

Our project came from the inconsistency of our existing scheduler which is sometimes struggling to work.

We also wanted to challenge ourselves to see if we're able to create a new prototype using only web technologies and also make it free of charge and also open-source (except for the senstives data).

In order to do that, we focused ourselves to develop a solution based on our degree year

## Instructions
1️⃣ Import the ```amu_edt.sql``` file into phpmyadmin (or other sql server)

2️⃣ ⚠ You'll have to run amu-edt-serv first in order to make our API available by using
```npm start```

3️⃣ Then you can launch amu-edt with :
```npm run dev``` for developement mode or :
```npm build``` and then ```npm start ``` 

4️⃣ After launching amu-edt you'll be able to access the running site with : http://localhost:3000

5️⃣ You'll be redirected to our login page. Only registered account can login

![image](https://user-images.githubusercontent.com/37662517/119713364-e8b1be80-be61-11eb-824d-92187ecdc62f.png)

Depending if you're a schooling manager or an AMU administrator you'll have a different view.

If you're role is student/teacher, you'll not have access to our modal to schedule courses as you can see in the attached screeshot

![image](https://user-images.githubusercontent.com/37662517/119714310-04699480-be63-11eb-90ee-00eb91410b93.png)

6️⃣ When you're logged in you'll have the choice to view the schedule by day or by week by clicking "Semaine" or "Jour" in the navbar

7️⃣ This component is here to help you navigate through weeks or days

![image](https://user-images.githubusercontent.com/37662517/119714522-4266b880-be63-11eb-9d10-1dedfc06500f.png)

Each arrow has is own indication:

The bigger one : to move to the previous or next week
The smaller one : to move to the previous or next day

8️⃣ You can also find more information about your class like your room or the teacher by mouse over

![image](https://user-images.githubusercontent.com/37662517/119714807-91ace900-be63-11eb-8ff1-086438a60749.png)

## Evolutions / To-Do LIST

- Update a class directly by the interface
- Handling all the student / personal / teachers.... (linking them to their schedules)
- Add / update / delete a teaching unit
- Work on the design to make it more responsive and enven more mobile friendly
- Display 2 schedules at the same time


## Design

[color palette](https://coolors.co/0065bd-3db7e4-f0ab00-f2f3f4-bdc2c7-677079-001514)

[Inspiration](https://dribbble.com/shots/9089543-Schedule-Dashboard-Design)
