## Get list orders

The API used when you want to get the order list from TIKI.

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
            "order_code": "929231617",
            "coupon_code": "ABC",
            "status": "queueing",
            "total_price_before_discount": 200000,
            "total_price_after_discount": 205000,
            "updated_at": "2019-10-30 17:27:24",
            "purchased_at": "2019-10-30 17:27:17",
            "fulfillment_type": "seller_delivery",
            "note": "",
            "is_rma": null,
            "warehouse_id": 17,
            "discount": {
                "discount_amount": 10000,
                "discount_coupon": 1000
            },
            "tax": {
                "code": "123",
                "name": "nguyen van A",
                "address": "Ha Noi, Vietnam"
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
                "shipping_fee": 15000
            },
            "items": [
                {
                    "id": 25203463,
                    "product_id": 2050232,
                    "product_name": "Cơm gà - dropship -hn4",
                    "sku": "9956112228645",
                    "original_sku": "123",
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
            "handling_fee": 10000,
            "collectable_total_price": 205000
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
| seller_confirmed            | Seller has confirmed this order before     | Get list order confirmed |
| seller_canceled             | Seller has canceled this order before      | Get list order canceled |
| complete                    | The order has been delivered successfully  | Get list order complete |


To get list orders you need to confirm, you use status **queueing**

With every [order](#order) there are important fields that you need to pay attention to:

| Field                       | Description                                |
| --------------------------- | ------------------------------------------ |
| total_price_before_discount | Total order amount before discounts        |
| total_price_after_discount  | Total order amount after applied discounts |
| fulfillment_type            | Order fulfillment                          |
| item.original_sku           | the seller product code of item            |
| item.must_confirmed_before_at | Orders item need to be confirmed before this time |
| tax                         | tax information of customer                |
| payment.payment_method      | Payment method                             |
| discount                    | discount info                              |
| discount.discount_amount    | total amount is discounted                 |
| shipping                    | info of customer such as address, email, phone |
| shipping_fee                | the fee for shipping       |
| handling_fee                 | the cost of order need collect if orders bulky       |
| collectable_total_price     | amount to be collected from customer       |


* **fulfillment_type**: _fulfillment types_ is mode of operation of the order specified by TIKI.
    * **tiki_delivery**: This order will be delivery by TIKI
    * **seller_delivery**: This order will be delivery by Seller (it you)
    * The order may be TIKI delivery or seller delivery depending on the type of product or operation you have registered with tiki
* **collectable_total_price**: total amount the shipper needs to collect from the customer
* **shipping**: info of customer such as address, email, phone:
Based on TIKI's commitment to confidentiality with customers, we can only publish personal information such as email and phone numbers if you register as seller delivery

**For example:**
Base on order _929231617_ you can see the parameters:

* _tax.code_ = "123": tax code of customer is "123"
* _tax.name_ = "nguyen Van A": tax name of customer is "nguyen van A"
* _tax.address_ = "Ha Noi, Vietnam"": tax address of customer is "Ha Noi, Vietnam""
* _item.original_sku_ = "123": seller product code/sku is "123"
* _item.must_confirmed_before_at_ = "2019-11-01 23:59:59": Orders item need to be confirmed before "2019-11-01 23:59:59"
* _total_price_after_discount_ = 205000: The total amount of money the user needs to pay for the order is 205000 VND
* _coupon_code_ = ABC: The coupon code that the user has used is "_ABC_" with value is _discount.discount_coupon_ = 1000 VND
* _discount.discount_amount_ = 10000: Total amount discount on the order is 10000 VND
* _fulfillment_type_ = seller_delivery: This order will be delivery by Seller
* _shipping.street_ = "519 kim mã": the street of costomer for delivery is "519 kim mã"
* _shipping.phone_ = "0912611089": the phone number of customer is "0912611089"
* _shipping.shipping_fee_ = 15000: the fee for shipping is 15000 VND
* _payment.payment_method_ = "cod": the payment method is cod, shipper needs to collect money from the user
* _handling_fee_ = 10000: the cost of order need collect if orders bulky
* _collectable_total_price_ = 205000: total amount shipper to be collected from customer


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
    "total_price_after_discount": 205000,
    "updated_at": "2019-10-30 17:27:24",
    "purchased_at": "2019-10-30 17:27:17",
    "fulfillment_type": "dropship",
    "note": "",
    "is_rma": null,
    "warehouse_id": 17,
    "discount": {
        "discount_amount": 10000,
        "discount_coupon": 0
    },
    "tax": {
        "code": "123",
        "name": "nguyen van A",
        "address": "Ha Noi, Vietnam"
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
        "shipping_fee": 15000
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
    "handling_fee": 10000,
    "collectable_total_price": 205000
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
