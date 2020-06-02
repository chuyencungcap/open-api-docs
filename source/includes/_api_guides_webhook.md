
# Webhook

Open API Webhooks allows sellers subscribe to various events related to products and orders.

## Supported events

At this first version, you can subcribe to the following product request events:

* `product:request:approved` When your product request has been approved
* `product:request:rejected` When your product request has been rejected. Reject reasons are included in the event payload.
* `product:request:locked` When your product request has been rejected for 2 or 3 times, your product request is locked.

## Integration

### 1. Subcribe to webhook events

Assume that you want to subscribe to product rejected events, make a `POST` to:

**Request**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/integration/v1/webhooks</h6>
	</div>
</div>

**Body**

<div class="center-column"></div>
```json
{
    "uri": "https://example.com/your/product/request/rejected/endpoint",
    "event": "product:request:rejected"
}
```

<br>
Please refer to [Register webhook](#register-webhook) for more details.

### 2. Grant us credentials

You need to protect the registered URIs to prevent malicious events. Therefore your systems may want to authenticate us. Right now we only support Basic Authentication, i.e. seller will need to grant us a (id, secret) credentials to authenticate with their system. And it is your responsible to verify us. 

To grant us a pair (id, secret):

**Request**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">PUT</i>
		<h6>/integration/v1/webhooks/credentials</h6>
	</div>
</div>

**Body**

<div class="center-column"></div>
```json
{
    "id": "iyofim3eru0bkiwz",
    "secret": "BuqicB1kwcy4Tl9dikqPB7FkPwdDh8fd"
}
```

<br>
Please refer to [Grant credentials to Tiki](#grant-credentials-to-tiki) for more details.

### 3. Handle events

* Your system must be able to handle HTTP POST to the registered URI. In our example, that is `/your/product/request/rejected/endpoint`
* What will be delivered to seller system?
   
**Request**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/your/product/request/rejected/endpoint</h6>
	</div>
</div>

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
