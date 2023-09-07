# Team Management Application

## Setup

To build the docker image and create the application container, run:

```bash
docker build .
docker-compose up
```

Open a new terminal window to create the database and run the migrations:

```bash
docker-compose run web rails db:create
docker-compose run web rails db:migrate
```

Run the rails seeds to populate the database with external data:

```bash
docker-compose run web rails db:seed
```
Connect to ``localhost:3000`` in the browser to see the application running


## Development Approach


1. Reproduce the legacy structure to make the team management application more realistic
2. Create a new entity called ``Role`` and associate it with the ``Membership`` entity
3. Create new ``controllers`` to handle the new requests related to role and membership
4. In order to avoid bloated controllers, create ``actions`` to handle the business logic described in the challenge document

### Development steps

1. Model the database with all necessary relationships among the tables
2. Create ``models`` for each entity, add validations and write unit tests to them
3. Create and test each ``controller``
4. Create and test each ``action``
5. Write the ``seed.rb`` file. The database gets populated by running it
6. Dockerize the application
7. Test the application entirely with Postman

### Validations

* Role name must be unique and mustn't be blank
* Membership must be unique. A user can't join a team more than once

## Suggestions for improvement

* Paginate users and teams list to improve perfomance, since requests might become slower with the ever-increasing number of teams and users
* Assign more roles to a team member, as there might be short-handed teams for any reason
