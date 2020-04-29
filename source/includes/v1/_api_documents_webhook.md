
## Webhook API

All the following APIs require authentication (either using the API Key or our OAuth2 system).

### Register webhook

**Request**

`POST /v1/webhooks`

**Body**

<div class="center-column"></div>
```json
{
    "uri": "https://example.com/your/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

We highly recommend you to register only HTTPS endpoints.

**Response**

* `200 OK`

<div class="center-column"></div>
```json
{
    "seller_id": your/seller/id,
    "uri": "https://example.com/your/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

* `400 Bad Request`

<div class="center-column"></div>
```json
{
    "error": {
        "message": "Invalid URI"
    }
}
```

* `409 Conflict`

<div class="center-column"></div>
```json
{
    "error": {
        "message": "Webhook for this event has been registered. Please update it instead."
    }
}
```

### Get webhook

**Endpoint**

 `GET /v1/webhooks`

**Response**

* `200 OK`

<div class="center-column"></div>  
```json
{
  "data": [
    {
        "uri": "https://example.com/your/product/request/rejected/endpoint",
        "event": "product:request:rejected"
    },
    {
        "uri": "https://example.com/your/product/request/approved/endpoint",
        "event": "product:request:approved"
    }
    ...
  ]
}
```

The webhooks list could be empty.

### Update webhook

**Endpoint**

`PUT /v1/webhooks`

**Body**

<div class="center-column"></div>
```json
{
    "uri": "https://example.com/new/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

**Response**

* `200 OK`

<div class="center-column"></div>
```json
{
    "uri": "https://example.com/new/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

* `400 Bad Request`

<div class="center-column"></div>
```json
{
    "error": {
        "message": "Invalid URI"
    }
}
```

* `404 Not Found`

### Unregister webhook

**Endpoint**

`DELETE /v1/webhooks?event=product:request:approved`

**Response**

* `200 OK`
* `404 Not Found`

### Grant credentials to Tiki

**Endpoint**

`PUT /v1/webhooks/credentials`

**Body**

<div class="center-column"></div>
```json
{
    "id": "some random string to identify us",
    "secret": "another random string as the secret"
}
```

When our system delivers events to your system, we will use Basic Authentication with your granted credentials in the event Http Header.