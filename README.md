# typeorm-react-setup

**Note:** the first time you run this you need to create the volume that will be used for the database, for that case just run:

```
make setup
```

## Development

### Backend

Up and running
```
make up
```

To install a new dependency you can do it with `npm` but after you install it you will need to perform the following command so the dependency is also installed into our docker container

```
make install
```

### Frontend

Up and running
```
npm start
```
## Production

To create a new build and run it
```
make deploy
```

**Note**: Make sure you update the image tag of the `web` container
