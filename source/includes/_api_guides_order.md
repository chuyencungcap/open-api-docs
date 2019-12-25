## Get list orders

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/orders?page=1&limit=2&status=queueing</h6>
	</div>
</div>

> Example query:

```http
GET https://api.tiki.vn/integration/v1/orders?page=1&limit=2&status=queueing 
```

> List order response body

```json
{
    "data": [
        {
            "order_code": "554520865",
            "coupon_code": null,
            "status": "queueing",
            "total_price_before_discount": 200000,
            "total_price_after_discount": 200000,
            "updated_at": "2019-12-19 15:38:23",
            "purchased_at": "2019-12-19 15:38:23",
            "fulfillment_type": "tiki_delivery",
            "note": "",
            "deliveryConfirmed": "",
            "is_rma": null,
            "warehouse_id": 4,
            "tax": {
                "code": null,
                "name": null,
                "address": null
            },
            "discount": {
                "discount_amount": 0,
                "discount_coupon": 0
            },
            "shipping": {
                "name": "hoa nguyễn",
                "street": "ewewq",
                "ward": "Phường An Lợi Đông",
                "city": "Quận 2",
                "region": "Hồ Chí Minh",
                "country": "VN",
                "phone": "",
                "email": "",
                "estimate_description": "Dự kiến giao hàng vào Thứ hai, 23/12/2019",
                "shipping_fee": 0
            },
            "items": [
                {
                    "id": 25278755,
                    "product_id": 2090562,
                    "product_name": "Backorder 100",
                    "sku": "3685812177996",
                    "original_sku": "",
                    "qty": 1,
                    "price": 200000,
                    "confirmation_status": "waiting",
                    "confirmed_at": "",
                    "must_confirmed_before_at": "2019-12-20 10:38:00",
                    "warehouse_code": null,
                    "inventory_type": "instock",
                    "serial_number": [],
                    "imei": []
                }
            ],
            "payment": {
                "payment_method": "cod",
                "updated_at": "2019-12-19 15:38:23",
                "description": "Thanh toán tiền mặt khi nhận hàng"
            },
            "handling_fee": 0,
            "collectable_total_price": 200000
        }
    ],
    "paging": {
        "total": 197,
        "per_page": 1,
        "current_page": 1,
        "last_page": 197,
        "from": 1,
        "to": 1
    }
}
```

We only support [get list orders](#api-get-list-orders) of the last 30 days.

You must use one of the following _**status**_ to get orders:

| Status                      | Description                                | User for |
| --------------------------- | ------------------------------------------ | -------- |
| queueing                    | TIKI received order from customer, waiting for seller confirm | Get list order waiting confirm |
| seller_confirmed            | Seller has confirmed this order before | Get list order confirmed |
| seller_canceled             | Seller has canceled this order before    | Get list order canceled |
| complete                    | The order has been delivered successfully   | Get list order complete |


To get list orders you need to confirm, you use status **queueing**

With every [order](#order) there are important fields that you need to pay attention to:

| Field                       | Description                                |
| --------------------------- | ------------------------------------------ |
| total_price_before_discount | Total order amount before discounts        |
| total_price_after_discount  | Total order amount after applied discounts |
| fulfillment_type            | Order fulfillment                          |
| tax                         | tax information of customer                            |
| discount                    | discount info                              |
| discount.discount_amount    | total amount is discounted                 |
| shipping                    | info of customer such as address, email, phone |
| collectable_total_price     | amount to be collected from customer       |


* **fulfillment_type**: _fulfillment types_ is mode of operation of the order specified by TIKI.
    * **tiki_delivery**: This order will be delivery by TIKI
    * The order may be TIKI delivery or seller delivery depending on the type of product or operation you have registered with tiki
* **collectable_total_price**: total amount the shipper needs to collect from the customer
* **shipping**: info of customer such as address, email, phone:
Based on TIKI's commitment to confidentiality with customers, we can only publish personal information such as email and phone numbers if you register as seller delivery

## Get order detail

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/orders/929231617</h6>
	</div>
</div>

> Query example: 

```http
GET https://api.tiki.vn/integration/v1/orders/929231617
```

> Response body

```json
{
    "order_code": "929231617",
    "coupon_code": null,
    "status": "queueing",
    "total_price_before_discount": 200000,
    "total_price_after_discount": 200000,
    "updated_at": "2019-10-30 17:27:24",
    "purchased_at": "2019-10-30 17:27:17",
    "fulfillment_type": "dropship",
    "note": "",
    "is_rma": null,
    "warehouse_id": 17,
    "discount": {
        "discount_amount": 0,
        "discount_coupon": 0
    },
    "tax": {
        "code": null,
        "name": null,
        "address": null
    },
    "shipping": {
        "name": "hậu nguyễn",
        "street": "519 kim mã",
        "ward": "Phường Kim Mã",
        "city": "Quận Ba Đình",
        "region": "Hà Nội",
        "country": "VN",
        "phone": "0912611089",
        "estimate_description": "Dự kiến giao hàng vào Thứ hai, 04/11/2019",
        "shipping_fee": 0
    },
    "items": [
        {
            "id": 25203463,
            "product_id": 2050232,
            "product_name": "Cơm gà - dropship -hn4",
            "sku": "9956112228645",
            "original_sku": "",
            "qty": 1,
            "price": 200000,
            "confirmation_status": "seller_confirmed",
            "confirmed_at": "2019-11-01 10:07:58",
            "must_confirmed_before_at": "2019-11-01 23:59:59",
            "inventory_type": "seller_backorder"
        }
    ],
    "payment": {
        "payment_method": "cod",
        "updated_at": "2019-10-30 17:27:25",
        "description": "Thanh toán tiền mặt khi nhận hàng"
    },
    "handling_fee": 0,
    "collectable_total_price": 0
}
```

We support api [get order](#api-get-order-detail) by order_code. API returns detail information including product items of a sales order.

## Confirm an order

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/v1/orders/confirmItems</h6>
	</div>
</div>

```shell
curl --location --request POST 'https://api-sandbox.tiki.vn/integration/v1/orders/confirmItems' \
--header 'Content-Type: application/json' \
--header 'tiki-api: 55f438d1-3438-409e-b5a4-9d16e764c5b8' \
--data-raw '{
  "order_code": "929231617",
  "warehouse_code": "sgn",
  "seller_inventory_id": 903,
  "item_ids": [25205113]
}'
```

If your order is **tiki_delivery** congratulation, you don't need to confirm the order as we have supported automatic order confirmation with this type.

Before confirm order you need to determine which products are in stock.

_**Warehouse**_ contains information about the address, contact point about the location of products that you have registered with TIKI.

We support API [get warehouse](#api-get-warehouses) to see the list warehouse you registered before. If you don't see any match warehouse you can add the new one via **add warehouse endpoint**  or tell us to add it manually

> Warehouse response body

```json
[
    {
        "contact_email": "dsada@gmail.com",
        "contact_name": "Nguyễn Thị Bích a",
        "contact_phone": "0988909999",
        "country": {
            "code": "vn",
            "name": "Viet Nam"
        },
        "district": {
            "code": "VN034025",
            "name": "Quận Hoàng Mai"
        },
        "name": "Kho giáp bát hà nội",
        "region": {
            "code": "VN034",
            "name": "Hà Nội"
        },
        "seller_inventory_id": 919,
        "street": "dsa ds",
        "ward": {
            "code": "VN034025003",
            "name": "Phường Giáp Bát"
        },
        "warehouse_code": "hn",
        "warehouse_id": 2
    }
]
```        

From this response you need to note 2 main points:

* **_warehouse_code_**: region code describe where is your warehouse
* _**seller_inventory_id**_: the Tiki id of your warehouse


After customer place an order, seller have to send a [confirm order items](#api-confirm-order-items) to make sure your product is still available. 
This is a important step before delivery product to customer so please confirm it as soon as possible 

Remember the two fields that I told you to save to confirm your order. Please provide **_warehouse_code_** & _**seller_inventory_id**_ with _**order_code**_ & your list of available order item id.
You need these select item for confirm and add item to **item_ids**

**Example1**: your order has 5 items as _[1, 2, 3, 4, 5]_ but only 2 items _[1, 3]_ of them are in stock. Just add these 2 item id to the _**item_ids**_, we will implicitly assume that the other 3 items are no longer available. Now the _item_ids=[1, 3]_


**Example2** if all of your items is not available then give us an empty _**item_ids**_ list. Now _item_ids=[]_

_**Note**_: Don't worry, TIKI has supported all products in one order, then it will be in stock.

## Update delivery status
 
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/v1/orders/updateDeliveryStatus</h6>
	</div>
</div>

```shell
curl --location --request POST 'https://api-sandbox.tiki.vn/integration/v1/orders/updateDeliveryStatus' \
--header 'Content-Type: application/json' \
--header 'tiki-api: 55f438d1-3438-409e-b5a4-9d16e764c5b8' \
--data-raw '{
    "order_code": "401734337",
    "update_time":"2020-11-23 23:59:59",
    "status": "successful_delivery"
}'
```

If your order is **tiki_delivery** congratulation, TIKI will help you complete this order.

When you are seller delivery you need to update the status of the order, so that tiki updates to the system and sends information to customers.

You have to [update delivery status](#api-update-delivery-status) step by step whenever you reach a new status in this list 

You need map from your delivery status to _**tiki delivery status**_:

* transferring_to_foreign_warehouses
* has_come_to_foreign_warehouses
* rotating_to_vietnam
* customs_clearance
* customs_clearance_complete
* item_arrived_in_vietnam
* ready_for_delivery
* on_delivery
* successful_delivery 

Finally, your order delivery status becomes **successful delivery**, everything is settled.

## Print order label
[This API](#print-order-labels) is used when you are **seller delivery**, it is used to print order label for shipping.

```shell
curl --location --request GET 'https://api-sandbox.tiki.vn/integration/v1/orders/905205190/print' \
--header 'tiki-api: 55f438d1-3438-409e-b5a4-9d16e764c5b8'
```

> Response example:

```json
{
    "shipping_label_url": "https://uat.tikicdn.com/ts/print/0d/71/f7/c68cf4ba4b29d1f79bac442a2ec2aa42.html"
}
```

Example order label:
![](https://salt.tikicdn.com/ts/files/f7/84/3c/cb757daf4fe9ea796ca611d8894cf242.png)
