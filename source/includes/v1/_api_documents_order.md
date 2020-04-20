
## Order API 

If it is the first time you come to integrate with us, please take a look at our [tutorial documents](#api-integration-step-by-step) first
This is a [sample postman collection](https://documenter.getpostman.com/view/7737371/SWLZfqJ9?version=latest) that lists all the APIs we support

The table below lists APIs that can be used for product management.

| API name | Description |
| -------- | -------- |
| [Get list orders](#api-get-list-orders)| Returns a list of sales orders managed by signing in seller, base on a specific search query|
| [Order detail](#api-get-order-detail)| Returns detail information including product items of a sales order, base on order code.|
| [Get warehouses](#api-get-warehouses)| Returns detail information of warehouse of Tiki that seller registries for backorder model.|
| [Confirm order items](#api-confirm-order-items)| Seller confirm available status and location of each item in the list|
| [Update delivery status](#api-update-delivery-status)| Update delivery status, base on order codes. When order delivery, we need know order delivery status, you will need update it.|
| [Print order labels](#api-print-order-labels)| Return shipping label url of sale orders, base on order codes.|
| [Created mock order](#api-create-mock-order) | Create a mock order on sandbox for testing order management flow.


### API get list orders
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/orders</h6>
	</div>
</div>

Returns a list of sales orders managed by signing in seller, base on a specific search query

```http
GET https://api.tiki.vn/integration/v1/orders?page=1&limit=2&status=queueing 
```
> Response body

```json
{
  "data": [
    {
      "order_code": "929231617",
      "coupon_code": "123",
      "status": "queueing",
      "total_price_before_discount": 200000,
      "total_price_after_discount": 200000,
      "updated_at": "2019-10-30 17:27:24",
      "purchased_at": "2019-10-30 17:27:17",
      "delivery_confirmed_at": "2019-10-30 18:57:40",
      "fulfillment_type": "dropship",
      "note": "",
      "is_rma": null,
      "tax": {
        "code": null,
        "name": null,
        "address": null
      },
      "discount": {
        "discount_amount": 10,
        "discount_coupon": 10,
        "discount_tiki_point": 0
      },
      "shipping": {
        "name": "hậu nguyễn",
        "street": "519 kim mã",
        "ward": "Phường Kim Mã",
        "city": "Quận Ba Đình",
        "region": "Hà Nội",
        "country": "VN",
        "phone": "0912611089",
        "estimate_description": "Dự kiến giao hàng vào Thứ hai, 04/11/2019"
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
          "confirmation_status": "waiting",
          "confirmed_at": "",
          "must_confirmed_before_at": "2019-10-31 12:00:00",
          "inventory_type": "instock",
          "discount": {
            "discount_amount": 10,
            "discount_coupon": 10,
            "discount_tiki_point": 0
          }
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
  ],
  "paging": {
    "total": 1,
    "per_page": 20,
    "current_page": 1,
    "last_page": 1,
    "from": 1,
    "to": 1
  }
}
```

#### **Request**

<table>
  <thead>
    <tr>
      <th style="text-align:left">Headers</th>
      <th style="text-align:left">Content-type</th>
      <th style="text-align:left">application/json</th>
      <th style="text-align:left"></th>
      <th style="text-align:left"></th>
      <th style="text-align:left"></th>
      <th style="text-align:left"></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">tiki-api</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left">Query Parameters</td>
      <td style="text-align:left">Name</td>
      <td style="text-align:left">Type</td>
      <td style="text-align:left">Mandatory</td>
      <td style="text-align:left">Example</td>
      <td style="text-align:left">Default value</td>
      <td style="text-align:left">Description</td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">status</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">N</td>
      <td style="text-align:left">&quot;queueing&quot;</td>
      <td style="text-align:left">queuing</td>
      <td style="text-align:left">
        <p>Order status:</p>
        <ul>
          <li>queueing</li>
          <li>seller_confirmed</li>
          <li>seller_canceled</li>
          <li>complete</li>
          <li>successful_delivery</li>
          <li>all</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">page</td>
      <td style="text-align:left">Integer</td>
      <td style="text-align:left">N</td>
      <td style="text-align:left">2</td>
      <td style="text-align:left">1</td>
      <td style="text-align:left">Page no of paging</td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">limit</td>
      <td style="text-align:left">Integer</td>
      <td style="text-align:left">N</td>
      <td style="text-align:left">20</td>
      <td style="text-align:left">20</td>
      <td style="text-align:left">Number of records per page</td>
    </tr>
     <tr>
          <td style="text-align:left"></td>
          <td style="text-align:left">created_from_date</td>
          <td style="text-align:left">String</td>
          <td style="text-align:left">N</td>
          <td style="text-align:left">2019-07-22 15:00:00</td>
          <td style="text-align:left"></td>
          <td style="text-align:left">query order created from date</td>
     </tr>
      <tr>
               <td style="text-align:left"></td>
               <td style="text-align:left">created_to_date</td>
               <td style="text-align:left">String</td>
               <td style="text-align:left">N</td>
               <td style="text-align:left">2019-08-22 15:00:00</td>
               <td style="text-align:left"></td>
               <td style="text-align:left">query order created to date</td>
          </tr>
  </tbody>
</table>

#### **Response:** 

| Field | Type | Description |
| :--- | :--- | :--- |
| results | List&lt;Order&gt; | Returns a list of sales orders managed by signing in seller, base on a specific search query. |
| paging | Object | Paging information |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |


### API get order detail
#### HTTP Request ####

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/orders/{order_code}</h6>
	</div>
</div>

Returns detail information including product items of a sales order, base on order code.

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
    "delivery_confirmed_at": "2019-10-30 18:57:40",
    "fulfillment_type": "dropship",
    "note": "",
    "is_rma": null,
    "discount": {
        "discount_amount": 0,
        "discount_coupon": 0,
        "discount_tiki_point": 0
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
            "inventory_type": "seller_backorder",
            "discount": {
                "discount_amount": 0,
                "discount_coupon": 0,
                "discount_tiki_point": 0
            }
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

#### **Request**

| Headers | Content-type | application/json |
| :--- | :--- | :--- |
| tiki-api | String | seller token key (contact Tiki supporter)  |

#### **Response :** 

| Field | Type | Description |
| :--- | :--- | :--- |
| root | Order | Returns detail information including product items of a sales order, base on order code. |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 404 | Not found | order code not found |

### API get warehouses
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/warehouses</h6>
	</div>
</div>
Returns detail information of warehouse of Tiki that seller registries for backorder model.

```http
GET https://api.tiki.vn/integration/v1/warehouses
```

> Response body

```json
[
    {
        "contact_email": "dsf@gmail.com",
        "contact_name": "1",
        "contact_phone": "0912345666",
        "country": {
            "code": "vn",
            "name": "Viet Nam"
        },
        "district": {
            "code": "VN034019",
            "name": "Quận Bắc Từ Liêm"
        },
        "name": "kho hà nội",
        "region": {
            "code": "VN034",
            "name": "Hà Nội"
        },
        "street": "ewqeqw",
        "ward": {
            "code": "VN034019006",
            "name": "Phường Minh Khai"
        },
        "warehouse_id": 902
    },
    {
        "contact_email": "fhds@gmail.com",
        "contact_name": "lan",
        "contact_phone": "0989777666",
        "country": {
            "code": "vn",
            "name": "Viet Nam"
        },
        "district": {
            "code": "VN039007",
            "name": "Quận 10"
        },
        "name": "kho 3-hcm",
        "region": {
            "code": "VN039",
            "name": "Hồ Chí Minh"
        },
        "street": "cmt8",
        "ward": {
            "code": "VN039007001",
            "name": "Phường 01"
        },
        "warehouse_id": 900
    }
]
```

#### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |  |

#### **Response**

| Field | Type | Description |
| :--- | :--- | :--- |
| root | Array object | List of warehouse object |


#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |

### API confirm order items
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/orders/confirmItems</h6>
	</div>
</div>

```http
POST https://api.tiki.vn/integration/{version}/orders/confirmItems
```
> request body **Seller delivery**

```json
{
  "order_code": "419060832",
  "warehouse_id": 882,
  "item_ids": [94792486, 94792487],
  "delivery_commitment_time": "2019-11-03 23:59:59",
  "tracking_number": "419060832"
}
```

> Response body

```json
{
    "code": 200,
    "data": []
}
```
Seller confirm available status and location of each item in the list

#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Body Parameters | Name | Type | Mandatory | Description |
|  | order_code | String | Y | order code |
|  | item_ids | Array Integer | Y | list of item_id of a specific backorder that seller want to confirm,  |
|  | warehouse_id | String | Y | The id identifies your warehouse in the Tiki system |
|  | delivery_commitment_time(*) | String | Y | Delivery commitment time, String datetime with format Y-m-d H:i:s. |
|  | tracking_number(*) | String | N | maybe equal order code, tracking_number is code for tracking order via 3rd party system or anything like this  |

**Note:** We use this endpoint to confirm available item only, if an item is absent, it will be confirmed as not able to sell by this time.

So if you want to reject all of item in this order, just send an empty **item_ids** list

* **delivery_commitment_time** is required
* **tracking_number** is required for **cross_border** order

#### **Response :** 

| Field | Type | Description |
| :--- | :--- | :--- |
| code | String | Seller confirm order |
| data | Array object |  |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | Params in body request invalid. See detail response |

### API Update delivery status

#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/orders/updateDeliveryStatus</h6>
	</div>
</div>

```http
POST https://api.tiki.vn/integration/{version}/orders/updateDeliveryStatus
```

Update delivery status, base on order codes. When order delivery, we need know order delivery status, you will need update it.

> Request body

```json
{
    "order_code": "327965376-5vHl1b",
    "update_time":"2019-11-23 23:59:59",
    "status": "ready_for_delivery"
}
```

> Response body

```json
{
    "message": "success"
}
```

#### **Request**

| Headers         | Content-type | application/json                          |           |                                          |                       |
|:--------------- |:------------ |:----------------------------------------- |:--------- |:---------------------------------------- |:--------------------- |
|                 | tiki-api     | seller token key (contact Tiki supporter) |           |                                          |                       |
| Body Parameters | Name         | Type                                      | Mandatory | Description                              | Example               |
|                 | order_code   | String                                    | Y         | Order code of seller delivery.           | "20939384"            |
|                 | status       | String                                    | Y         | Status of delivery, status in options(*) | successful_delivery   |
|                 | update_time  | String                                    | Y         | String datetime with format Y-m-d H:i:s. | "2019-06-22 18:12:17" |


**Status options:**

* transferring_to_foreign_warehouses
* has_come_to_foreign_warehouses
* rotating_to_vietnam
* customs_clearance
* customs_clearance_complete
* item_arrived_in_vietnam
* ready_for_delivery
* on_delivery
* successful_delivery

#### **Response**  

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| message | String | "success" |  |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | request not valid |

### API print order label
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/orders/{order_code}/print</h6>
	</div>
</div>

Notes: Sorry, this endpoint is not available on sandbox environment. You can see the example response to know how to
implement on your end.

```http
GET https://api.tiki.vn/integration/{version}/orders/{order_code}/print
```

Return shipping label url of sale orders, base on order codes.

> Response body

```json
{
    "shipping_label_url": "http://uat.tikicdn.com/ts/print/1b/67/52/d54614ae10e18b2112c38845641a693d.html"
}
```

#### **Request**

<table>
  <thead>
    <tr>
      <th style="text-align:left">Headers</th>
      <th style="text-align:left">Content-type</th>
      <th style="text-align:left">application/json</th>
      <th style="text-align:left"></th>
      <th style="text-align:left"></th>
      <th style="text-align:left"></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">tiki-api</td>
      <td style="text-align:left">seller token key ( contact Tiki supporter )</td>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><b>Path Parameters</b>
      </td>
      <td style="text-align:left"><b>Name</b>
      </td>
      <td style="text-align:left"><b>Type</b>
      </td>
      <td style="text-align:left"><b>Mandatory</b>
      </td>
      <td style="text-align:left"><b>Example</b>
      </td>
      <td style="text-align:left"><b>Description</b>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">order_code</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Y</td>
      <td style="text-align:left">&quot;<code>20939384&quot;</code>
      </td>
      <td style="text-align:left">order_code of order you want to print</td>
    </tr>
  </tbody>
</table>

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| shipping_label_url | String | "[http://uat.tikicdn.com/ts/print/1b/67/52/d54614ae10e18b2112c38845641a693d.html](http://uat.tikicdn.com/ts/print/1b/67/52/d54614ae10e18b2112c38845641a693d.html)" | Shipping label url |


#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | request not valid |


### API create mock order
#### HTTP Request ####
<div class="api-endpoint">
    <div class="endpoint-data">
        <i class="label label-get">POST</i>
        <h6>https://api-sandbox.tiki.vn/integration/{version}/orders</h6>
    </div>
</div>

This endpoint allow you to create mock order to test on sandbox environment. You need to specify 
*fulfillment_type*, *payment_method* and *item list* of the order. More than that, you can add addition 
information like shipping, discount, coupon, note to testing with your UI.

After created mock order. You can use the *order_code* return in response to testing order management flow like 
confirm items, update delivery status ...

```http
POST https://api.tiki.vn/integration/{version}/orders
```

> Request body

```json
{
	"fulfillment_type": "cross_border",
	"payment_method": "visa",
	"items": [
		{
			"product_name": "Bluetooth mouse",
			"original_sku": "X33322",
			"price": 1000,
			"qty": 1,
			"inventory_type": "instock"
		},
		{
			"product_name": "Highland coffee",
			"original_sku": "Y33311",
			"price": 2000,
			"qty": 2,
			"inventory_type": "instock"
		}
	],
	"coupon_code": "DISCOUNTXX",
	"discount_coupon": 13,
	"discount_tiki_point": 23,
	"shipping": {
		"name": "Nguyen Van A",
    	"street": "Số 52 Út Tich",
    	"ward": "Phường Tân Chánh Hiệp",
    	"city": "Quận 12",
    	"region": "Hồ Chí Minh",
    	"country": "VN",
    	"phone": "098XXXXXXX",
    	"email": "xxxx@yyy.com",
    	"estimate_description": "Dự kiến giao hàng vào Thứ ba, 19/11/2019",
    	"shipping_fee": 0
	},
	"tax": {
		"code": "XXX",
		"name": "tax_name",
		"address": "Ha noi"
	},
	"note": "note message"
}
```

> Response body

```json
{
  "order_code": "1666",
  "coupon_code": "DISCOUNTXX",
  "status": "queueing",
  "total_price_before_discount": 5000,
  "total_price_after_discount": 4964,
  "created_at": "2020-04-20 16:33:17",
  "updated_at": "2020-04-20 16:33:17",
  "purchased_at": null,
  "fulfillment_type": "cross_border",
  "note": "note message",
  "deliveryConfirmed": null,
  "delivery_confirmed_at": null,
  "is_rma": null,
  "tax": {
    "code": "XXX",
    "name": "tax_name",
    "address": "Ha noi"
  },
  "discount": {
    "discount_amount": 36,
    "discount_coupon": 13,
    "discount_tiki_point": 23
  },
  "shipping": {
    "name": "Nguyen Van A",
    "street": "Số 52 Út Tich",
    "ward": "Phường Tân Chánh Hiệp",
    "city": "Quận 12",
    "region": "Hồ Chí Minh",
    "country": "VN",
    "phone": "098XXXXXXX",
    "email": "xxxx@yyy.com",
    "estimate_description": "Dự kiến giao hàng vào Thứ ba, 19/11/2019",
    "shipping_fee": 0
  },
  "items": [
    {
      "id": 89575,
      "product_id": 4181,
      "product_name": "Bluetooth mouse",
      "sku": "175565",
      "original_sku": "X33322",
      "qty": 1,
      "price": 1000,
      "confirmation_status": "waiting",
      "confirmed_at": null,
      "must_confirmed_before_at": "2020-04-20 16:34:44",
      "warehouse_code": null,
      "inventory_type": "instock",
      "serial_number": null,
      "imei": null,
      "discount": null,
      "fees": null,
      "fee_total": 0,
      "seller_id": 0
    },
    {
      "id": 46482,
      "product_id": 10765,
      "product_name": "Highland coffee",
      "sku": "113875",
      "original_sku": "Y33311",
      "qty": 2,
      "price": 2000,
      "confirmation_status": "waiting",
      "confirmed_at": null,
      "must_confirmed_before_at": "2020-04-20 16:34:44",
      "warehouse_code": null,
      "inventory_type": "instock",
      "serial_number": null,
      "imei": null,
      "discount": null,
      "fees": null,
      "fee_total": 0,
      "seller_id": 0
    }
  ],
  "payment": {
    "payment_method": "visa",
    "updated_at": "2020-04-20 16:33:17",
    "description": "Đã thanh toán qua VISA"
  },
  "handling_fee": null,
  "collectable_total_price": null
}
```

#### Header

| Key   | Description
| -------------- | --------------
| tiki-api | seller token key (contact Tiki supporter)

#### Request body

Name | Type | Mandatory | Example | Description
| -- | ---- | --------- | ------- | -----------
fulfillment_type | String | Y | cross_border | The fulfillment type of order
payment_method | String | Y | visa/cod | The payment type of order
items | List (Mock Item) | Y | See in bellow for each item fields | The items list in order.
_product_name | String | Y | Bluetooth mouse | The name of item product
_original_sku | String | Y | X33322 | Your original sku
_price | Integer | Y | 1000 | The item price
_qty | Integer | Y | 1 | Quantity of item.
_inventory_type | String | Y | instock | Inventory type of item. See [Inventory type](#inventory-type) for more types.
coupon_code | String | N | DISCOUNT_10 | The discount coupon applied for the order
discount_coupon | Integer | N | 10 | The discount coupon in VND applied for the order
discount_tiki_point | Integer | N | 10 | The discount tiki xu in VND applied for the order
shipping | Object | N | See in example | The shipping information of customer
tax | Object | N | See in example | The tax information
note | String | N | note message | The order's note message


#### Response body

| Field | Type | Example | Description
| ----- | ---- | ------- | -----------
root | Order | Returns detail information the created order.


#### **Exception Case**

| HTTP Code | Message | Description 
| --------- | ------- | -----------
| 500 | Internal server error | Having error in server, can't serving
| 400 | Bad request | Request not valid, check error message
| 403 | Forbidden | Only available on sandbox environment
| 401 | Unauthorized | Your tiki-api token is not valid
| 429 | Too Many Requests | Your rate limit is exceed



