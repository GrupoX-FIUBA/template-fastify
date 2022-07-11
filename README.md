# Template repository for Fastify microservices

This is a template to use as a starting point for Fastify (Node.js) microservice repositories. Once configured, it will run the tests on every pull request to `main`, and will automatically deploy to corresponding the Kubernetes cluster when a push to `main` occurs.

## To Do after fork/create-from-template

1. Go to the repository settings, _Actions secrets_ and create the following _repository secrets_:
	- `APP_NAME`: the name of the service (preferably `service-X`).
	- `DB_USER`: the name of the database user.
	- `DB_PASS`: the password for the database user.
2. Create the following _Organization secrets_, replacing `XYZ` with your service name:
	- `XYZ_SERVICE_URL`: the URL you will publicly access to your service (Ask the Kubernetes manager).
	- `XYX_SERVICE_API_KEY`: a random API Key to limit access to your service.
3. Open `package.json` and modify the name and description of the project. The name must be lowercase and can't contain special chars except `-` and `_`.
4. In `.github/workflows/deploy.yml`, replace `X_SERVICE_API_KEY` with the name of the secret you just create, and `xdb` with the name of the database (preferably something like `musicdb`).
5. Replace all `SERVICE-` with your service name in `docker-compose.yml`.
6. If needed, create the user and database for postgres:
	- Connect to the postgres instance (via Kubernetes).
	- `CREATE USER user-name WITH PASSWORD 'user-password';`.
	- `CREATE DATABASE db-name WITH OWNER 'user-name';`.


There's a very simple example of a Fastify app with tests.

## Local development

To run the application there are two options. In either case, you can stablish a `DEBUG=1` environment variable to see the log (_i.e._ `DEBUG=1 npx nodemon app.js`).

### With Node

- Install the dependencies: `npm install`.
- Run the app in port 8000 with `npx nodemon server.js` or with `PORT=xxxx npx nodemon server.js` to use a specific `xxxx` port.

### With Docker

Run `docker-compose up` to start the app. Also, you can specify the port with the environment variable: `PORT=xxxx docker-compose up`.

## Tests

Again, there are two options. Note that the Node option is naturally faster.

### With Node

- Run the tests with `npm test`.
- Run the linter with `npx eslint . --ext .js,.jsx,.ts,.tsx`

### With Docker

Run the tests and linter with:

```bash
docker-compose run --rm fastify sh -c "NODE_ENV=development npm install && npm test && npx eslint . --ext .js,.jsx,.ts,.tsx"
```

## Docs

The documentation is generated automatically by Fastify (with Swagger). It's available in the server at `/docs`.
