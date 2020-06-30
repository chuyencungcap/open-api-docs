
## Webhook API

All the following APIs require authentication (either using the API Key or our OAuth2 system).

### Common objects

#### Webhook Object

**Definition**: Represent a webhook with an event name and an endpoint where you want to receive the event payloads of this event type.

|     | Key     | Type   | Description 
| --- | ---     | ----   | ---
|     | `uri`   | String | The endpoint where you want to receive the webhook event
|     | `event` | String | the webhook event name

#### Generic Error

**Definition**: Represent a common error message

```json
{
    "error": {
        "id": "123e4567-e89b-12d3-a456-426677440000",
        "message": "Invalid URI"
    }
}
```

|     | Key       | Type        | Description 
| --- | ---       | ----        | ---
| `error`
|     | `id`      | UUID String | The unique Id of each error that occurs
|     | `message` | String      | The detailed error message

### Register webhook

**Request**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/integration/v1/webhooks</h6>
	</div>
</div>

> Register webhook

> Body example

```json
{
    "uri": "https://example.com/your/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

**Request Header**

| Key            | Type                       | Mandatory | Description 
| ---            | ----                       | ---       | ---
| `Content-Type` | String                     | Y         | `application/json`

**Request Body**

| Type                       | Mandatory | Description 
| ----                       | ---       | ---
| [Webhook](#webhook-object) | Y         | The webhook that you want to register

We highly recommend you to register only HTTPS endpoints.

> `200 OK` response

```json
{
    "uri": "https://example.com/your/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

> `400 Bad Request` response

```json
{
    "error": {
        "message": "Invalid URI"
    }
}
```

> `409 Conflict` response

```json
{
    "error": {
        "message": "Webhook for this event has been registered. Please update it instead."
    }
}
```

**Success Response**

| Http Status       | Body                       | Description 
| ---               | ---                        | ---
| `200 OK`          | [Webhook](#webhook-object) | The webhook that you registered

**Failure Response**

| Http Status       | Body                            | Description 
| ---               | ---                             | ---
| `400 Bad Request` | **None**
| `409 Conflict`    | [Generic Error](#generic-error) | The detailed error

### Get webhook

**Request**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/integration/v1/webhooks</h6>
	</div>
</div>

**Success Response**

> Get webhook 

> `200 OK` response

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

| Http Status | Key    | Type                               | Description 
| ---         | ---    | ----                               | ---
| `200 OK`    | `data` | List of [Webhook](#webhook-object) | A list of registered webhooks

The webhooks list could be empty.

### Update webhook

**Request**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">PUT</i>
		<h6>/integration/v1/webhooks</h6>
	</div>
</div>

> Update webhook

> Example body

```json
{
    "uri": "https://example.com/new/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

**Request Headers**

| Key            | Type                       | Mandatory | Description 
| ---            | ----                       | ---       | ---
| `Content-Type` | String                     | Y         | `application/json`

**Request Body**  

| Type                       | Mandatory | Description 
| ----                       | ---       | ---
| [Webhook](#webhook-object) | Y         | The webhook that you want to update

Because for each event, you can only register 1 URI to receive event payloads, 
therefore the `event` property in the webhook object is enough for us to update your webhook.

> `200 OK` response

```json
{
    "uri": "https://example.com/new/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

> `400 Bad Request` response

```json
{
    "error": {
        "message": "Invalid URI"
    }
}
```

**Success Response**

| Http Status       | Body                            | Description 
| ---               | ---                             | ----            
| `200 OK`          | [Webhook](#webhook-object)      | The webhook that you updated

**Failure Response**

| Http Status       | Body                            | Description 
| ---               | ---                             | ----            
| `400 Bad Request` | [Generic Error](#generic-error) | The detailed error
| `404 Not Found`   | **None**


### Unregister webhook

**Request**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">DELETE</i>
		<h6>/integration/v1/webhooks?event=product:request:approved</h6>
	</div>
</div>

**Query Component**

| Key      | Type   | Mandatory | Description 
| ---      | ----   | ---       | ---
| `event`  | String | Y         | The event that you want to remove webhook

**Response**

* `200 OK` - You unregistered the webhook succcessfully
* `404 Not Found` - The webhook of this event not found

### Grant credentials to Tiki

When our system delivers events to your system, we will use Basic Authentication with your granted credentials in the event Http Header.
In conjunction with the use of HTTPS, you can protect your endpoint from malicious events.

**Request**

`PUT /v1/webhooks/credentials`

> Grant credentials

> Example body

```json
{
    "id": "some random string to identify us",
    "secret": "another random string as the secret"
}
```
**Request Headers**

| Key            | Type    | Mandatory | Description 
| ---            | ----    | ---       | ---
| `Content-Type` | String  | Y         | `application/json`

**Request Body**

| Key            | Type    | Mandatory | Description 
| ---            | ----    | ---       | ---
| `id`           | String  | Y         | An unique ID for you to identify us <br>when we are deliverying event payloads to your endpoints
| `secret`       | String  | Y         | A random string as a secret
