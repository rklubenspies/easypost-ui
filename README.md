## EasyPost Interface by Robert Klubenspies

Based on EasyPost's Example UI for Buying Shipments found at https://github.com/EasyPost/example-ui-for-buying-shipments.

It uses Docker containerization to provide development and production environments.

### API Keys
You'll need to obtain your [Test and Production API Keys](https://www.easypost.com/account#/api-keys) and create `.env.dev` and `.env.prod` files for them. The format for the API key in each file is: `EASYPOST_API_KEY=XXX123`

The test key goes in `.env.dev` and the production key goes in `.env.prod`.

### Docker Usage
Docker and Docker Compose are used to run the app, manage all dependencies, and provide an auto-reloading development environment. You must have Docker and Docker Compose installed on your machine. A bash script is provided as a shortcut to invoke docker-compose.

* To run the application in development mode (does not buy postage), `./run dev`.
* To run the application in PRODUCTION mode (which BUYS POSTAGE), `./run prod`.

When invoked via the bash script, Docker Compose will load the API key from the appropriate .env file, mount the local development directory to the container, install the required gems, and start the appropriate web server to run the application.

Run via `./run` the application runs at http://localhost:4567/

### Known Issues
**EasyPost::Error: SHIPMENT.POSTAGE.NOT_ALLOWED:** If the system throws an error `EasyPost::Error: SHIPMENT.POSTAGE.NOT_ALLOWED (422): Unable to complete shipment purchase. Please contact support@easypost.com.` when attempting to purchase postage in production for the first time, you must contact EasyPost Support to have your account activated.
