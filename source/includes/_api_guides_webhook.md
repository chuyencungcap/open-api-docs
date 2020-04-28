
# Webhook

Open API Webhooks allows sellers subscribe to various events related to products and orders.

## Supported events

At this first version, you can subcribe to the following product request events:

* `product:request:approved`
* `product:request:rejected`
* `product:request:locked`

## Integration

### 1. Subcribe to webhook events

Assume that you want to subscribe to product rejected events, make a `POST` to:

**Request**

`POST /v1/webhooks`

**Header**

Add your authorization option (either using API Key or OAuth2's token)

**Body**

<div class="center-column"></div>
```json
{
    "uri": "https://example.com/your/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

### 2. Grant us credentials

You need to protect the registered URIs to prevent malicious events. Therefore your systems may want to authenticate us. Right now we only support Basic Authentication, i.e. seller will need to grant us a (id, secret) credentials to authenticate with their system. And it is your responsible to verify us. 

To grant us a pair (id, secret):

**Request**

`PUT /v1/webhooks/credentials`

**Body**

<div class="center-column"></div>
```json
{
    "id": "iyofim3eru0bkiwz",
    "secret": "BuqicB1kwcy4Tl9dikqPB7FkPwdDh8fd"
}
```

### 3. Handle events

* Your system must be able to handle HTTP POST to the registered URI. In our example, that is `/your/product/request/rejected/endpoint`
* What will be delivered to seller system?
   
**Request**

`POST /your/product/request/rejected/endpoint`

**Header** 

Includes the Basic Authentication with the granted (id, secret) above

<div class="center-column"></div>
```
Authorization: Basic aXlvZmltM2VydTBia2l3ejpCdXFpY0Ixa3djeTRUbDlkaWtxUEI3RmtQd2REaDhmZA==
```

**Body**

<div class="center-column"></div>
```json
{
    "id": "123e4567-e89b-12d3-a456-426655440000",
    "event": "product:request:rejected",
    "payload": {
        "event": "product:request:rejected",
        "event_time": "2020-02-02 12:00:00",
        "request_id": "1154523837593192401",
        "state": "rejected",
        "product_id": "2162835",
        "product_sku": "7062617941818",
        "list_reasons": [
        {
            "reason_data": null,
            "reject_description": "The very detailed reason why your product is rejected",
            "reason_id": 9,
            "reason_name": "Hình sản phẩm quá nhỏ, không chiếm 80% khung hình" 
        }
        ],
        "reason": null
    }
}
```

* Notes:
  * You can verify us via the Authorization header
  * `payload` could be empty
  * `payload` format depends on the event
