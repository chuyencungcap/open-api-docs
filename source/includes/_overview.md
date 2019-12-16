# OVERVIEW
## Introduction

TIKI Marketplace System is the platform for sellers to run marketplace business on TIKI Platform. Tiki integration system is a system which supports seller to manage their product in Tiki dynamically .

It contains some kinds of APIs:

* Information APIs: provide Tiki's information such as: categories, attributes , rules, documents , ...
* Product APIs: create new product, update price, quantity , attributes, ...
* Tracking APIs: tracing request, product in history or by trace_id
* Order APIs: to query, confirm order/delivery information 
 
These APIs are opened and sellers can use these APIs to manage their business in TIKI platform

***Note**: update/delete API or any requested API will be supported in the near future 

## Authentication

Sellers has to use a secret token to integrate with our APIs.
The secret token is provided by the TIKI supporters or sellers can acquire in seller systems.
This token is used to access every APIs except Information APIs, it is opened for everybody.

As far as security measures go, APIs are always content with having an API key as header when an endpoint is called.
In Tiki seller center, the API key is configured for each seller before integrate with the third party system.
When calling an API, the API key must be added to API headers as in example below:

```json
{
    "tiki-api": "eccf4e05-b3b0-4e9f-9044-86c0cbd1f386"
}  
```
In this example the string "eccf4e05-b3b0-4e9f-9044-86c0cbd1f386" is the API key that configured for the seller, you can find it in seller detail information screen in Tiki seller center as below:
![](https://sellercenter-api-docs.tiki.vn/images/api_key.png)

If lacks API key in API headers when calling an API you might have got an authentication error as below:
> Wrong token status: 403

```json
{
  "errors": [
    "Authentication key is not valid: xxx"
  ]
}
```

## API Base URL
API Base URL is the URL prefix of every API mentioned in this document.

Sandbox
The base URL of sanbox environment is: https://api-sandbox.tiki.vn/integration
This URL used for testing APIs before launching on production environment.

For example the method of API Search Products mentioned in this document is GET/products.
When calling this API in sanbox environment, the full URL must be GET https://api-sandbox.tiki.vn/integration/v1/products

Production
The base URL of product environment is: https://api.tiki.vn/integration
This URL used for operating real transactions.