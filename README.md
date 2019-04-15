## EasyPost Interface by Robert Klubenspies

Based on EasyPost's Example UI for Buying Shipments found at https://github.com/EasyPost/example-ui-for-buying-shipments.

[Test and Production API Keys](https://www.easypost.com/account#/api-keys) are coded into the .env file in the following format:
`EASYPOST_API_KEY_TEST=XXX123`
`EASYPOST_API_KEY_PROD=YYY789`

* To install dependencies before running the application, `bundle install --path vendor/bundle`.
* To run the application in development mode (does not buy postage), `bundle exec rackup`.
* To run the application in PRODUCTION mode (which BUYS POSTAGE), `bundle exec rackup -E production`.
* The application runs at <http://localhost:9292/>

**NOTE:** If the system throws an error `EasyPost::Error: SHIPMENT.POSTAGE.NOT_ALLOWED (422): Unable to complete shipment purchase. Please contact support@easypost.com.` when attempting to purchase postage in production for the first time, you must contact EasyPost Support to have your account activated.
