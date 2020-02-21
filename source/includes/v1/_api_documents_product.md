# API Documents
## Product API

If it is the first time you come to integrate with us, please take a look at our [tutorial documents](#api-integration-step-by-step) first
This is a [sample postman collection](https://documenter.getpostman.com/view/7737371/SWLZfqJ9?version=latest) that lists all the APIs we support

The table below lists APIs that can be used for product management.

| API name | Description |
| -------- | -------- |
| [Get categories](#get-categories)| Return the summary list of categories in integration system |
| [Get category detail](#get-category-detail-include-attribute)| Retrieve detail of a single categories with its attributes|
| [Create Product Request](#create-product-request)| Create new a product request|
| [Tracking latest product request](#tracking-latest-product-request)| Tracking latest request |
| [Tracking a product request](#tracking-a-product-request)| Retrieve detail of a single request|
| [Replay a product request](#replay-a-product-request)| Replay process of a single request from the beginning |
| [Update variant price/quantity/active](#update-variant-price-quantity-active)| Update price/quantity/active of a product intermediately|
| [Update product market_price/image/images](#update-market-price-images)| Update market_price/image/images via update product request|
| [Get latest products](#get-latest-products)| Get all of product (approved request) order by created_at desc (latest product)|
| [Get a product](#get-a-product)| Get a product with product_id from TIKI system|
| [Get a product by original sku](#get-a-product-by-original-sku)| Get a product by original sku|
| [Get latest product request 's info](#get-latest-product-request-info)| Get all of product requests order by created_at desc (latest request)|
| [Get a product request info](#get-a-product-request-info)| Get a request with request_id from TIKI system|
| [Get a product request info by track id](#get-a-product-request-by-track-id)| Get a product match with seller original sku|
| [Delete a product request](#delete-a-product-request)| Delete a created product request base on request_id of TIKI system|


### Get categories
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/categories</h6>
	</div>
</div>


Return the summary list of categories in integration system

```http
GET https://api.tiki.vn/integration/v1/categories?name=book&primary=1
```

```json
[
  {
    "id": 218,
    "name": "Medical Books",
    "parent": 320,
    "primary": 1
  },
  {
    "id": 275,
    "name": "Guidebook series",
    "parent": 32,
    "primary": 1
  },
  {
    "id": 2458,
    "name": "Macbook",
    "parent": 8095,
    "primary": 1
  },
  {
    "id": 6225,
    "name": "Bookmark",
    "parent": 18328,
    "primary": 1
  },
  {
    "id": 8780,
    "name": "IELTS Books",
    "parent": 14900,
    "primary": 1
  },
  {
    "id": 8781,
    "name": "TOEIC Books",
    "parent": 14900,
    "primary": 1
  },
  {
    "id": 9295,
    "name": "Picture books",
    "parent": 11018,
    "primary": 1
  }
]
```

#### **Request**

| Headers          | Content-type | application/json |           |                                                            |             |
|:---------------- |:------------ |:---------------- |:--------- |:---------------------------------------------------------- |:----------- |
| Path Parameters  | Name         | Type             | Mandatory | Example                                                    | Description |
| version          | String       | Y                | v1        | version of API                                             |             |
| Query Parameters | Name         | Type             | Mandatory | Example                                                    | Description |
| |lang             | String       | N                | en        | Filter by language en/vi (**default is en - english**) |             |
| |name             | String       | N                | book      | Filter name by keyword (case insensitive)              |             |
| |parent           | Integer      | N                | 8         | Filter children of this parent_id only   |
| |primary | Integer | N | 1 | Filter product pushable category |  |

#### **Response :** 

| Field | Type | Description |
| :--- | :--- | :--- |
| root | List&lt;**Category**&gt; | the summary list of category filtered by request params |


#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |

---------------------------------------------------------------------------------------------------------------

### Get category detail (include attribute)

#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/categories/{id}</h6>
	</div>
</div>

Retrieve detail of a single categories with its attributes

```http
GET https://api.tiki.vn/integration/v1/categories/218
```

```json
{
  "id": 218,
  "name": "Children's Books",
  "parent": 320,
  "primary": 1,
  "description": "Children's Books | international purchases buy at | Tiki.vn | Cheaper | Free shipping | 100% genuine",
  "attributes": [
    {
      "id": 498,
      "code": "author",
      "display_name": "Author",
      "is_required": 1
    },
    {
      "id": 1300,
      "code": "book_cover",
      "display_name": "Cover type",
      "is_required": 0
    },
    {
      "id": 799,
      "code": "bulky",
      "display_name": "Is product bulky?",
      "is_required": 0
    }
  ]
}
```

#### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Path Parameters | Name | Type | Mandatory | Example | Description |
| |version | String | Y | v1 | version of API |  |
| |id | Integer | Y | 218 | id of category (category_id) |  |

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| id | Integer | 218 | id of category |
| name | String | Children's Books | name of category |
| parent | Integer | 320 | category_id of parent category |
| primary | Integer | 1 | only primary category can have product |
| description | String | Children's Books, international purchases buy at [Tiki.vn](http://tiki.vn/) Cheaper Free shipping 100% genuine | describe the detail of this category |
| attributes | List&lt;**Attribute**&gt;(*) | see detail below | attributes list of this category |

#### **Exception Case**

> Example:

```json
{
  "errors": [
    "Category not found id: 1"
  ]
}
```

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 404 | Category not found |  |

### Create Product Request

#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/requests</h6>
	</div>
</div>

Create new product request

> Simple product example:

```json
{
  "category_id": 21458,
  "name": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch with Rhinestones",
  "description": "<style>\r\n#productDetails_techSpec_section_2{width:70%;}\r\n#prodDetails .prodDetSectionEntry {width: 50%!important;white-space: normal;word-wrap: break-word;}\r\ntable.a-keyvalue th {background-color: #f3f3f3;}\r\ntable.a-keyvalue td, table.a-keyvalue th {padding: 7px 14px 6px;border-top: 1px solid #e7e7e7;}\r\n#prodDetails th {text-align: left;}\r\ntable.a-keyvalue{border-bottom: 1px solid #e7e7e7;}\r\n</style><div id=\"prodDetails\"><table id=\"productDetails_techSpec_section_2\" class=\"a-keyvalue prodDetTable\" role=\"presentation\"><tbody><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Item Shape</th><td class=\"a-size-base\">Round</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Display Type</th><td class=\"a-size-base\">Analog</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case material</th><td class=\"a-size-base\">Metal</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case diameter</th><td class=\"a-size-base\">37 millimeters</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band Material</th><td class=\"a-size-base\">metal-alloy</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band length</th><td class=\"a-size-base\">Women&#039;s Standard</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band width</th><td class=\"a-size-base\">18 millimeters</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band Color</th><td class=\"a-size-base\">White</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Dial color</th><td class=\"a-size-base\">White</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Bezel material</th><td class=\"a-size-base\">Metal</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Brand, Seller, or Collection Name</th><td class=\"a-size-base\">Disney</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Model number</th><td class=\"a-size-base\">MK2106</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Part Number</th><td class=\"a-size-base\">MK2106</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case Thickness</th><td class=\"a-size-base\">9.3 millimeters</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Special features</th><td class=\"a-size-base\">includes a seconds-hand</td></tr></tbody></table></div><p></p><p>White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design</p><p>37-mm metal case with glass dial window</p><p>Quartz movement with analog display</p><p>Metal alloy bracelet with jewelry-clasp closure</p><p>Not water resistant</p><p><p>Great timepiece for Disney Mickey Mouse fans! This spray white bracelet watch features round case with clear rhinestone accented, genuine white Mother-Of-Pearl dial, Arabic number 12,3,9 and dots display and jewelry clasp. Cute rhinestone accented Mickey Mouse image on dial. It is also powered by quartz movement that tells you the accurate time. It is casual and fashionable that is nice for everyday wear.</p></p>",
  "market_price": 1,
  "attributes": {
    "bulky": 1,
    "origin": "my",
    "product_top_features": "White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design\n37-mm metal case with glass dial window\nQuartz movement with analog display\nMetal alloy bracelet with jewelry-clasp closure\nNot water resistant\n",
    "brand": "Disney",
    "case_diameter": "37 millimeters",
    "filter_case_diameter": "37 millimeters",
    "band_material": "metal-alloy",
    "filter_band_material": "metal-alloy",
    "brand_origin": "viet nam",
    "require_expiry_date": 1
  },
  "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsL.jpg",
  "images": [
    "https://images-na.ssl-images-amazon.com/images/I/6110JInm%2BBL.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/41FuQMh3FUL.jpg"
  ],
  "option_attributes": [],
  "variants": [
    {
      "sku": "B0055QD0EC11",
      "price": 984000,
      "market_price": 984000,
      "inventory_type": "cross_border",
      "supplier": 167797,
      "quantity": 100,
      "brand_origin": "viet nam",
      "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsL.jpg",
      "images": [
        "https://images-na.ssl-images-amazon.com/images/I/6110JInm%2BBL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/41FuQMh3FUL.jpg"
      ]
    }
  ]
}
```

> Configurable product example:

```json
{
  "category_id": 21458,
  "name": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch with Rhinestones",
  "description": "<style>\r\n#productDetails_techSpec_section_2{width:70%;}\r\n#prodDetails .prodDetSectionEntry {width: 50%!important;white-space: normal;word-wrap: break-word;}\r\ntable.a-keyvalue th {background-color: #f3f3f3;}\r\ntable.a-keyvalue td, table.a-keyvalue th {padding: 7px 14px 6px;border-top: 1px solid #e7e7e7;}\r\n#prodDetails th {text-align: left;}\r\ntable.a-keyvalue{border-bottom: 1px solid #e7e7e7;}\r\n</style><div id=\"prodDetails\"><table id=\"productDetails_techSpec_section_2\" class=\"a-keyvalue prodDetTable\" role=\"presentation\"><tbody><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Item Shape</th><td class=\"a-size-base\">Round</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Display Type</th><td class=\"a-size-base\">Analog</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case material</th><td class=\"a-size-base\">Metal</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case diameter</th><td class=\"a-size-base\">37 millimeters</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band Material</th><td class=\"a-size-base\">metal-alloy</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band length</th><td class=\"a-size-base\">Women&#039;s Standard</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band width</th><td class=\"a-size-base\">18 millimeters</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band Color</th><td class=\"a-size-base\">White</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Dial color</th><td class=\"a-size-base\">White</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Bezel material</th><td class=\"a-size-base\">Metal</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Brand, Seller, or Collection Name</th><td class=\"a-size-base\">Disney</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Model number</th><td class=\"a-size-base\">MK2106</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Part Number</th><td class=\"a-size-base\">MK2106</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case Thickness</th><td class=\"a-size-base\">9.3 millimeters</td></tr><tr><th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Special features</th><td class=\"a-size-base\">includes a seconds-hand</td></tr></tbody></table></div><p></p><p>White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design</p><p>37-mm metal case with glass dial window</p><p>Quartz movement with analog display</p><p>Metal alloy bracelet with jewelry-clasp closure</p><p>Not water resistant</p><p><p>Great timepiece for Disney Mickey Mouse fans! This spray white bracelet watch features round case with clear rhinestone accented, genuine white Mother-Of-Pearl dial, Arabic number 12,3,9 and dots display and jewelry clasp. Cute rhinestone accented Mickey Mouse image on dial. It is also powered by quartz movement that tells you the accurate time. It is casual and fashionable that is nice for everyday wear.</p></p>",
  "market_price": 1,
  "attributes": {
    "bulky": 1,
    "origin": "my",
    "product_top_features": "White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design\n37-mm metal case with glass dial window\nQuartz movement with analog display\nMetal alloy bracelet with jewelry-clasp closure\nNot water resistant\n",
    "brand": "Disney",
    "case_diameter": "37 millimeters",
    "filter_case_diameter": "37 millimeters",
    "band_material": "metal-alloy",
    "filter_band_material": "metal-alloy",
    "brand_origin": "viet nam",
    "require_expiry_date": 1
  },
  "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsL.jpg",
  "images": [
    "https://images-na.ssl-images-amazon.com/images/I/6110JInm%2BBL.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/41FuQMh3FUL.jpg"
  ],
  "option_attributes": [
    "color"
  ],
  "variants": [
    {
      "sku": "B0055QD0EC11",
      "price": 984000,
      "market_price": 984000,
      "option1": "Black",
      "inventory_type": "cross_border",
      "supplier": 167797,
      "quantity": 100,
      "brand_origin": "viet nam",
      "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsL.jpg",
      "images": [
        "https://images-na.ssl-images-amazon.com/images/I/6110JInm%2BBL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/41FuQMh3FUL.jpg"
      ]
    }
  ]
}
```

**\*Note**: To understand the relation between variant and it's product parent please read the detail from: **Variant**(*)

#### **Request**
You must complete all required attribute from category, all others can be ignored or pass null value


| Headers | Content-type | application/json |  |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| tiki-api | seller token key (contact Tiki supporter) |  |  |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |  |
| |version | String | Y | v1 | version of API |  |  |
| Body Parameters | Namespace | Field | Type | Mandatory | Example | Description |
|  | Root | **Product**(*) | Y | below | product detail to create |  |

#### **Response**

> Response body: 

```json
{
    "track_id": "c3587ec50976497f837461e0c2ea3da5",
    "state": "queuing"
}
```

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| track_id | String | `c3587ec50976497f837461e0c2ea3da5` | track_id to tracking this request |
| state | String | queuing | current state of your request |

#### **Exception Case:**

Configurable Product have invalid payload (missing option2 value & price in sku2)

> Request body

```json
{
  "category_id": 1846,
  "name": "Samsung Galaxy Note 10+",
  "description": "this is description",
  "market_price": 10000000,
  "attributes": {
    "ram": "16GB",
    "ram_type": "Built-in",
    "bus": "1666hz",
    "camera": "",
    "audio_technology": "",
    "hard_drive": "",
    "connection_port": "",
    "brand": "Samsung"
  },
  "image": "http://cdn.fptshop.com.vn/Uploads/Originals/2019/8/9/637009754161317464_samsung-galaxy-note-10-plus-1.jpg",
  "images": [
    "http://cdn.fptshop.com.vn/Uploads/Originals/2019/8/9/637009754161387464_samsung-galaxy-note-10-plus-9.jpg",
    "http://cdn.fptshop.com.vn/Uploads/Originals/2019/8/9/637009754164217464_samsung-galaxy-note-10-plus.jpg"
  ],
  "option_attributes": [
    "color",
    "storage"
  ],
  "variants": [
    {
      "sku": "sku1",
      "quantity": 21,
      "option1": "Black",
      "option2": "32GB",
      "price": 10000001,
      "inventory_type": "cross_border",
      "supplier": 239091,
      "image": "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008711602926121_SS-note-10-pl-den-1-1.png",
      "images": [
        "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008619323404785_SS-note-10-pl-den-2.png",
        "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008619327294396_SS-note-10-pl-den-4.png"
      ]
    },
    {
      "sku": "sku2",
      "quantity": 22,
      "option1": "White",
      "inventory_type": "cross_border",
      "supplier": 239091,
      "image": "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008710284136121_SS-note-10-pl-trang-1-1.png",
      "images": [
        "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008624715439429_SS-note-10-pl-trang-2.png",
        "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008624715279445_SS-note-10-pl-trang-3.png"
      ]
    }
  ]
}
```

> Response body: 

```json
{
    "errors": [
        "variants don't match with option_attributes => variants option2 missing",
        "variants should have price > 0"
    ]
}
```

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | missing header or required params |
| 401 | Unauthorized | your tiki-api token is not valid |
| 404 | Not found | Attributes not found for category_id in payload |
| 422 | Unprocessable Entity | Payload is missing or invalid field  |
| 429 | Too Many Requests | Your rate limit is exceed |

### Tracking latest product request

#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/tracking</h6>
	</div>
</div>

Tracking latest request of user (via token)


> Response body: 

```json
[
  {
    "track_id": "097c43fb664448eba4dfb410b323b615",
    "state": "approved",
    "reason": "",
    "request_id": "1121456196340384958"
  },
  {
    "track_id": "06e9fffedf3b4a179ccca85d2aa6f70b",
    "state": "awaiting_approve",
    "reason": "",
    "request_id": "1121448919994696893"
  },
  {
    "track_id": "4cd90cf9294047c9984c1a7f6a1c67de",
    "state": "approved",
    "reason": "",
    "request_id": "1121447935453136060"
  },
  {
    "track_id": "8c526ef8f8504f30ad330682d07a10a7",
    "state": "rejected",
    "reason": "{\"errors\":[{\"code\":420,\"data\":null,\"description\":\"Product code B0055QD0EC2 is not unique\",\"msg\":\"Mã seller product không duy nhất\",\"msg_eng\":\"Seller product code is not unique\"}],\"message\":\"Mã seller product không duy nhất\",\"trace_id\":null}"
  }
]
```

#### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter) |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |
| |version | String | Y | v1 | version of API |  |
| Query Parameters | Name | Type | Mandatory | Example | Description |
| |limit | Integer | N | 50 | return up to this many requests |  |
| |created_at_min | String | N | 2019-06-27 10:47:34 | Show request created after date (format as example)  |  |
| |created_at_max | String | N | 2019-06-27 10:47:34 | Show request created before date (format as example)  |  |
| |updated_at_min | String | N | 2019-06-27 10:47:34 | Show request updated after date (format as example)  |  |
| |updated_at_max | String | N | 2019-06-27 10:47:34 | Show request created before date (format as example)  |  |

#### **Response**

| Field | Type | Description |
| :--- | :--- | :--- |
| root | List&lt;Request&gt; | list filtered request match with request params |

**Entity** : Request

| Field | Type | Example | Description | Note |
| :--- | :--- | :--- | :--- | :--- |
| track\_id | String | `c3587ec50976497f837461e0c2ea3da5` | track\_id to tracking this request |  |
| state | String | processing | current state of your request |  |
| reason | String | Image does not match product name | the reason why your request is rejected | only rejected request have reason |
| request\_id | String | 1121447935453136060 | request_id when product request created successfully | once product request created successfully |


#### **State list**

| State | Description |
| :--- | :--- |
| queuing | request is in queue, waiting for processing |
| processing | request is transforming to tiki format  |
| **drafted** | TIKI product request created, ready to review |
| bot\_awaiting\_approve | TIKI reviewing request by bot |
| md\_awaiting\_approve | TIKI reviewing required document \( by category \) |
| awaiting\_approve | request waiting for approving, we need to take a look |
| **approved** | request is approved, product created successfully |
| **rejected** | request is rejected, use tracking API for more information |
| deleted | request is deleted, no more available in system |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | missing header or required params |
| 401 | Unauthorized | your tiki-api token is not valid |
| 429 | Too Many Requests | Your rate limit is exceed |

---------------------------------------------------------------------------------------------------------------

### Tracking a product request
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/tracking/{track_id}</h6>
	</div>
</div>

Retrieve detail of a single request

> Response body: 

```json
{
  "track_id": "4cd90cf9294047c9984c1a7f6a1c67de",
  "request_id": "1121447935453136060",
  "state": "approved",
  "reason": ""
}
```

#### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key \( contact Tiki supporter \) |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |
| |version | String | Y | v1 | version of API |  |
| |track\_id | String | Y | `c3587ec50976497f837461e0c2ea3da5` | track_id of request get from product API |  |

#### **Response**

| Field | Type | Example | Description | Note |
| :--- | :--- | :--- | :--- | :--- |
| track\_id | String | `c3587ec50976497f837461e0c2ea3da5` | track\_id to tracking this request |  |
| state | String | processing | current state of your request |  |
| reason | String | Image does not match product name | the reason why your request is rejected | only rejected request have reason |
| request\_id | String | 2150725160607 | request_id when product request created successfully | once product request created successfully |


#### **State list**

| State | Description |
| :--- | :--- |
| queuing | request is in queue, waiting for processing |
| processing | request is transforming to tiki format  |
| **drafted** | TIKI product request created, ready to review |
| bot\_awaiting\_approve | TIKI reviewing request by bot |
| md\_awaiting\_approve | TIKI reviewing required document \( by category \) |
| awaiting\_approve | request waiting for approving, we need to take a look |
| **approved** | request is approved, product created successfully |
| **rejected** | request is rejected, use tracking API for more information |
| deleted | request is deleted, no more available in system |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | missing header or required params |
| 401 | Unauthorized | your tiki-api token is not valid |
| 404 | Not found | track_id is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |

---------------------------------------------------------------------------------------------------------------

### Replay a product request
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/tracking/{track_id}/replay</h6>
	</div>
</div>

Replay process of a product request from the beginning

> Response body: 

```json
{
  "track_id": "4cd90cf9294047c9984c1a7f6a1c67de",
  "state": "queuing"
}
```

#### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key \( contact Tiki supporter \) |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |
| |version | String | Y | v1 | version of API |  |
| |track\_id | String | Y | `4cd90cf9294047c9984c1a7f6a1c67de` | track_id of request get from product API |  |

#### **Response**

| Field | Type | Example | Description | Note |
| :--- | :--- | :--- | :--- | :--- |
| track\_id | String | `4cd90cf9294047c9984c1a7f6a1c67de` | track\_id to tracking this request |  |
| state | String | queuing | current state of your request |  |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | missing header or required params |
| 401 | Unauthorized | your tiki-api token is not valid |
| 404 | Not found | track_id is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |

---------------------------------------------------------------------------------------------------------------

### Update variant price/quantity/active
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/products/updateSku</h6>
	</div>
</div>

Update non validate fields like price/quantity/active of a created product

```http
POST https://api.tiki.vn/integration/v1/products/updateSku
```

```json
{
  "original_sku" : "SELLER_SKU",
  "price": 100000,
  "quantity": 20,
  "active": 1
}
```

> Response body: 

```json
{
   "state": "approved"
}
```

#### **Request**

| Headers | Content-type | application/json |  |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| tiki-api | seller token key (contact Tiki supporter) |  |  |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |  |
| |version | String | Y | v1 | version of API |  |  |
| |sku | String | Y | DANG19951995 | the original sku from your side system |  |  |
| Body Parameters | Namespace | Field | Type | Mandatory | Example | Description |
| |Variant | price | Integer | N | 10000 | product 's new price |  |
|  | |quantity | String | N | 10 | product 's new quantity |  |
|  | |active | Integer | N | 1 | product 's new status (1=active / 0=inactive) |  |


#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| state | String | approved | your product is updated successfully |


#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 401 | Unauthorized | your tiki-api token is not valid |
| 403 | Forbidden | your tiki-api token do not have permission to perform |
| 422 | Unprocessable Entity | your request body have invalid value |
| 429 | Too Many Requests | Your rate limit is exceed |

> Example:

```json
{
    "errors": [
        "Price is not valid because less than ten percent listing price"
    ]
}
```

### Get latest products 
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/products</h6>
	</div>
</div>

Get all of product (approved request) order by created_at desc (latest product)

> Example

```http
GET https://api.tiki.vn/integration/v1/products
```

> Response body

```json
{
  "data": [
    {
      "sku": "4833677185901",
      "master_sku": "2629421073875",
      "master_id": 2088335,
      "super_sku": "",
      "super_id": 0,
      "name": "test product name",
      "entity_type": "seller_simple",
      "type": "simple",
      "price": 20000,
      "created_at": "2019-12-09 15:25:36",
      "created_by": "admin@tiki.vn",
      "product_id": 2088336,
      "original_sku": "YOUR_ORIGINAL_SKU_123",
      "market_price": 20000,
      "version": 5,
      "thumbnail": "https://uat.tikicdn.com/ts/product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
      "images": [
        {
          "id": 47932612,
          "url": "https://uat.tikicdn.com/ts/product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
          "path": "product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
          "position": 0,
          "width": 1200,
          "height": 1200
        }
      ],
      "categories": [
        {
          "id": 1789,
          "name": "Điện Thoại - Máy Tính Bảng",
          "url_key": "dien-thoai-may-tinh-bang",
          "is_primary": false
        },
        {
          "id": 1795,
          "name": "Điện thoại smartphone",
          "url_key": "dien-thoai-smartphone",
          "is_primary": true
        }
      ]
    }
  ],
  "paging": {
    "total": 1,
    "current_page": 1,
    "from": 0,
    "to": 20,
    "per_page": 20,
    "last_page": 1
  }
}
```
#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Body Parameters | Name | Type | Mandatory | Description |
|  | active | Integer | N | current active of products that you want to filter ( 1 = active , 0 = inactive ) |
|  | category_id | Integer | N | id of the primary category you want to filter |
|  | page | Integer | N | move to the page you choose in the data set, default 1|
|  | limit | Integer | N | number result per page, default 20 |

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| data | List<**Product**> | see more detail below | list query result |
| paging | Paging | see more detail below | page information of this query |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |


### Get a product
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/products/{product_id}</h6>
	</div>
</div>

Get a product with product_id from TIKI system

> Example

```http
GET https://api.tiki.vn/integration/v1/products/2088336
```

> Response body

```json
{
  "data": [
    {
      "sku": "4833677185901",
      "master_sku": "2629421073875",
      "master_id": 2088335,
      "super_sku": "",
      "super_id": 0,
      "name": "test product name",
      "entity_type": "seller_simple",
      "type": "simple",
      "price": 20000,
      "created_at": "2019-12-09 15:25:36",
      "created_by": "admin@tiki.vn",
      "product_id": 2088336,
      "original_sku": "YOUR_ORIGINAL_SKU_123",
      "market_price": 20000,
      "version": 5,
      "thumbnail": "https://uat.tikicdn.com/ts/product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
      "images": [
        {
          "id": 47932612,
          "url": "https://uat.tikicdn.com/ts/product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
          "path": "product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
          "position": 0,
          "width": 1200,
          "height": 1200
        }
      ],
      "categories": [
        {
          "id": 1789,
          "name": "Điện Thoại - Máy Tính Bảng",
          "url_key": "dien-thoai-may-tinh-bang",
          "is_primary": false
        },
        {
          "id": 1795,
          "name": "Điện thoại smartphone",
          "url_key": "dien-thoai-smartphone",
          "is_primary": true
        }
      ]
    }
  ],
  "paging": {
    "total": 1,
    "current_page": 1,
    "from": 0,
    "to": 20,
    "per_page": 20,
    "last_page": 1
  }
}
```
#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Path Parameters | Name | Type | Mandatory | Description |
|  | version | String | Y | version of API|
|  | product_id | Integer | Y | product_id of TIKI system |

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| data | List<**Product**> | see more detail below | list query result |
| paging | Paging | see more detail below | page information of this query |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |


### Get a product by original sku
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/products/findBy</h6>
	</div>
</div>

Get a product match with seller original sku

> Example

```http
GET https://api.tiki.vn/integration/v1/products/findBy?original_sku=YOUR_ORIGINAL_SKU_123
```

> Response body

```json
{
  "data": [
    {
      "sku": "4833677185901",
      "master_sku": "2629421073875",
      "master_id": 2088335,
      "super_sku": "",
      "super_id": 0,
      "name": "test product name",
      "entity_type": "seller_simple",
      "type": "simple",
      "price": 20000,
      "created_at": "2019-12-09 15:25:36",
      "created_by": "admin@tiki.vn",
      "product_id": 2088336,
      "original_sku": "YOUR_ORIGINAL_SKU_123",
      "market_price": 20000,
      "version": 5,
      "thumbnail": "https://uat.tikicdn.com/ts/product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
      "images": [
        {
          "id": 47932612,
          "url": "https://uat.tikicdn.com/ts/product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
          "path": "product/83/f7/55/81986fa898d5b864f08de0186ad0f4e1.jpg",
          "position": 0,
          "width": 1200,
          "height": 1200
        }
      ],
      "categories": [
        {
          "id": 1789,
          "name": "Điện Thoại - Máy Tính Bảng",
          "url_key": "dien-thoai-may-tinh-bang",
          "is_primary": false
        },
        {
          "id": 1795,
          "name": "Điện thoại smartphone",
          "url_key": "dien-thoai-smartphone",
          "is_primary": true
        }
      ]
    }
  ],
  "paging": {
    "total": 1,
    "current_page": 1,
    "from": 0,
    "to": 20,
    "per_page": 20,
    "last_page": 1
  }
}
```
#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Request Parameters | Name | Type | Mandatory | Description |
|  | original_sku | Integer | Y | The original sku from seller side |

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| data | List<**Product**> | see more detail below | list query result |
| paging | Paging | see more detail below | page information of this query |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |

### Get latest product request info
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/requests</h6>
	</div>
</div>

Get all of product requests order by created_at desc (latest request)

> Example

```http
GET https://api.tiki.vn/integration/v1/v1/requests
```

> If you want to move to the next page:

```http
GET https://api.tiki.vn/integration/v1/requests?page=2
```
  
> If you want to see more product information generated from the product request

```http
GET https://api.tiki.vn/integration/v1/requests?include=products
```
  
> If you want to filter by state: 

```http
GET https://api.tiki.vn/integration/v1/requests?state=approved
```

> Response body

```json
{
  "data": [
    {
      "request_id": "1121408707461612725",
      "state": "approved",
      "created_at": "2019-12-20 11:57:50",
      "created_by": "tran.nguyen2@tiki.vn",
      "kind": "create_product",
      "approved_at": "2019-12-20 12:11:06",
      "approved_by": "khoa.tran2@tiki.vn",
      "reasons": null,
      "products": []
    },
    {
      "request_id": "1120793560477041639",
      "state": "awaiting_approve",
      "created_at": "2019-12-18 19:13:28",
      "created_by": "tran.nguyen2@tiki.vn",
      "kind": "create_product",
      "approved_at": null,
      "approved_by": null,
      "reasons": null,
      "products": []
    }
  ],
  "paging": {
    "total": 7837,
    "current_page": 1,
    "from": 0,
    "to": 20,
    "per_page": 20,
    "last_page": 392
  }
}
```
#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Request Parameters | Name | Type | Mandatory | Description |
|  | page | Integer | N | move to the page you choose in the data set, default 1|
|  | limit | Integer | N | number result per page, default 20 |
|  | include | List\<String> | N | list addition info you want to include in this request |
|  | state | String | N | choose 1 from state list table |


#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| data | List<**Request**> | see more detail below | list query result |
| paging | Paging | see more detail below | page information of this query |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |

-----

### Update market price / images

#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/requests/updateProductInfo</h6>
	</div>
</div>

Update market_price , image ( thumbnail ) , images ( product media ) of product

> Example

```http
POST https://api.tiki.vn/integration/v1/requests/updateProductInfo
```

> Response body

```json
{
    "track_id": "650bc7a64bf7473cbb4bc322c554f754",
    "state": "queuing"
}
```
#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Path Parameters | Name | Type | Mandatory | Description |
|  | version | String | Y | version of API|

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| track_id | String | `c3587ec50976497f837461e0c2ea3da5` | track_id to tracking this request |
| state | String | queuing | current state of your request |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 404 | Not found | product_id not found |
| 429 | Too Many Requests | Your rate limit is exceed |

### Get a product request info
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/requests/{request_id}</h6>
	</div>
</div>

Get a request 's information detail with request_id from TIKI system

> Example

```http
GET https://api.tiki.vn/integration/v1/requests/1121456196340384958
```

> Response body

```json
{
  "request_id": "1121456196340384958",
  "state": "approved",
  "created_at": "2019-12-20 15:06:32",
  "created_by": "tran.nguyen2@tiki.vn",
  "kind": "create_product",
  "approved_at": "2019-12-20 15:07:07",
  "approved_by": "khoa.tran2@tiki.vn",
  "reasons": null,
  "products": [
    {
      "product_id": 2091401,
      "sku": "2886025648971",
      "name": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch with Rhinestones",
      "active": 1,
      "original_sku": "B0055QD0EC5",
      "price": 984000,
      "market_price": 984000,
      "images": [
        {
          "id": null,
          "url": "https://uat.tikicdn.com/ts/product/45/02/eb/b024dce6529a4443fb4ad58c0f914e15.jpg",
          "path": "product/45/02/eb/b024dce6529a4443fb4ad58c0f914e15.jpg",
          "position": 0,
          "width": 1335,
          "height": 2259
        },
        {
          "id": null,
          "url": "https://uat.tikicdn.com/ts/product/fa/18/d1/bd7c815ee514344cf56256eb7a3cd9d8.jpg",
          "path": "product/fa/18/d1/bd7c815ee514344cf56256eb7a3cd9d8.jpg",
          "position": 1,
          "width": 0,
          "height": 0
        }
      ],
      "categories": [
        {
          "id": 601225,
          "name": "Laptop of JD",
          "url_key": null,
          "is_primary": true
        },
        {
          "id": 601223,
          "name": "Danh mục hàng JD",
          "url_key": null,
          "is_primary": false
        },
        {
          "id": 1882,
          "name": "Điện Gia Dụng",
          "url_key": null,
          "is_primary": false
        },
        {
          "id": 2,
          "name": "Root yyy",
          "url_key": null,
          "is_primary": false
        }
      ],
      "attributes": {
        "status": {
          "attribute_code": "status",
          "value": 1,
          "input_type": null
        },
        "sku": {
          "attribute_code": "sku",
          "value": "9493225709765",
          "input_type": null
        },
        "brand": {
          "attribute_code": "brand",
          "value": 50583,
          "input_type": null
        },
        "brand_country": {
          "attribute_code": "brand_country",
          "value": 630957,
          "input_type": null
        },
        "bulky": {
          "attribute_code": "bulky",
          "value": 0,
          "input_type": null
        },
        "description": {
          "attribute_code": "description",
          "value": "<html>\n <head>\n  <style>\r\n#productDetails_techSpec_section_2{width:70%;}\r\n#prodDetails .prodDetSectionEntry {width: 50%!important;white-space: normal;word-wrap: break-word;}\r\ntable.a-keyvalue th {background-color: #f3f3f3;}\r\ntable.a-keyvalue td, table.a-keyvalue th {padding: 7px 14px 6px;border-top: 1px solid #e7e7e7;}\r\n#prodDetails th {text-align: left;}\r\ntable.a-keyvalue{border-bottom: 1px solid #e7e7e7;}\r\n</style>\n </head>\n <body>\n  <div id=\"prodDetails\">\n   <table id=\"productDetails_techSpec_section_2\" class=\"a-keyvalue prodDetTable\" role=\"presentation\">\n    <tbody>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Item Shape</th>\n      <td class=\"a-size-base\">Round</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Display Type</th>\n      <td class=\"a-size-base\">Analog</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case material</th>\n      <td class=\"a-size-base\">Metal</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case diameter</th>\n      <td class=\"a-size-base\">37 millimeters</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band Material</th>\n      <td class=\"a-size-base\">metal-alloy</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band length</th>\n      <td class=\"a-size-base\">Women's Standard</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band width</th>\n      <td class=\"a-size-base\">18 millimeters</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Band Color</th>\n      <td class=\"a-size-base\">White</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Dial color</th>\n      <td class=\"a-size-base\">White</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Bezel material</th>\n      <td class=\"a-size-base\">Metal</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Brand, Seller, or Collection Name</th>\n      <td class=\"a-size-base\">Disney</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Model number</th>\n      <td class=\"a-size-base\">MK2106</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Part Number</th>\n      <td class=\"a-size-base\">MK2106</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Case Thickness</th>\n      <td class=\"a-size-base\">9.3 millimeters</td>\n     </tr>\n     <tr>\n      <th class=\"a-color-secondary a-size-base prodDetSectionEntry\">Special features</th>\n      <td class=\"a-size-base\">includes a seconds-hand</td>\n     </tr>\n    </tbody>\n   </table>\n  </div>\n  <p></p>\n  <p>White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design</p>\n  <p>37-mm metal case with glass dial window</p>\n  <p>Quartz movement with analog display</p>\n  <p>Metal alloy bracelet with jewelry-clasp closure</p>\n  <p>Not water resistant</p>\n  <p></p>\n  <p>Great timepiece for Disney Mickey Mouse fans! This spray white bracelet watch features round case with clear rhinestone accented, genuine white Mother-Of-Pearl dial, Arabic number 12,3,9 and dots display and jewelry clasp. Cute rhinestone accented Mickey Mouse image on dial. It is also powered by quartz movement that tells you the accurate time. It is casual and fashionable that is nice for everyday wear.</p>\n  <p></p>\n </body>\n</html>",
          "input_type": null
        },
        "list_price": {
          "attribute_code": "list_price",
          "value": 984000,
          "input_type": null
        },
        "meta_description": {
          "attribute_code": "meta_description",
          "value": "#productDetails_techSpec_section_2{width:70%;}\r\n#prodDetails .prodDetSectionEntry {width: 50%!important;white-space: normal;word-wrap: break-word;}\r\ntable.a-keyvalue th {background-color: #f3f3f3;}\r\ntable.a-keyvalue td, table.a-keyvalue th {padding: 7px...",
          "input_type": null
        },
        "meta_title": {
          "attribute_code": "meta_title",
          "value": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch...",
          "input_type": null
        },
        "name": {
          "attribute_code": "name",
          "value": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch with Rhinestones",
          "input_type": null
        },
        "url_key": {
          "attribute_code": "url_key",
          "value": "disney-women-s-mk2106-mickey-mouse-white-bracelet-watch-with-rhinestones-p2091399",
          "input_type": null
        },
        "url_path": {
          "attribute_code": "url_path",
          "value": "disney-women-s-mk2106-mickey-mouse-white-bracelet-watch-with-rhinestones-p2091399.html",
          "input_type": null
        },
        "origin": {
          "attribute_code": "origin",
          "value": 10661,
          "input_type": null
        },
        "po_type": {
          "attribute_code": "po_type",
          "value": 111134,
          "input_type": null
        },
        "price": {
          "attribute_code": "price",
          "value": 984000,
          "input_type": null
        },
        "product_top_features": {
          "attribute_code": "product_top_features",
          "value": "White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design\n37-mm metal case with glass dial window\nQuartz movement with analog display\nMetal alloy bracelet with jewelry-clasp closure\nNot water resistant\n",
          "input_type": null
        },
        "require_expiry_date": {
          "attribute_code": "require_expiry_date",
          "value": 0,
          "input_type": null
        },
        "visibility": {
          "attribute_code": "visibility",
          "value": 4,
          "input_type": null
        },
        "": {
          "attribute_code": "",
          "value": null,
          "input_type": null
        },
        "image": {
          "attribute_code": "image",
          "value": "product/45/02/eb/b024dce6529a4443fb4ad58c0f914e15.jpg",
          "input_type": null
        },
        "small_image": {
          "attribute_code": "small_image",
          "value": "product/45/02/eb/b024dce6529a4443fb4ad58c0f914e15.jpg",
          "input_type": null
        },
        "thumbnail": {
          "attribute_code": "thumbnail",
          "value": "product/45/02/eb/b024dce6529a4443fb4ad58c0f914e15.jpg",
          "input_type": null
        }
      }
    }
  ]
}
```

#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Path Parameters | Name | Type | Mandatory | Description |
|  | version | String | Y | version of API |
|  | request_id | String | Y | request_id of TIKI system |

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| data | List<**Request**> | see more detail below | list query result |
| paging | Paging | see more detail below | page information of this query |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |



### Get a product request by track id
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/requests/findBy</h6>
	</div>
</div>

Get a product request match with track id from create new product

> Example

```http
GET https://api.tiki.vn/integration/v1/requests/findBy?track_id=8b85b2cbd7424f03af41ae5b4507eb01
```

> Response body

```json
{
  "data": [
    {
      "sku": "2932389999690",
      "master_sku": "2932389999690",
      "master_id": 0,
      "super_sku": "",
      "super_id": 0,
      "name": "Instock_03",
      "entity_type": "master_simple",
      "type": "simple",
      "price": 50000,
      "created_at": "2019-12-03 16:47:13",
      "created_by": "admin@tiki.vn",
      "product_id": 2087783,
      "original_sku": null,
      "request_id": "1115320939429986651",
      "state": "approved",
      "kind": "create_product",
      "approved_at": "2019-12-03 16:48:01",
      "approved_by": "admin@tiki.vn",
      "product_info": null,
      "reasons": null
    }
  ],
  "paging": {
    "total": 7837,
    "current_page": 1,
    "from": 0,
    "to": 20,
    "per_page": 20,
    "last_page": 392
  }
}
```
#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Request Parameters | Name | Type | Mandatory | Description |
|  | track_id | String | Y | track_id from create product request response |

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| data | List<**Request**> | see more detail below | list query result |
| paging | Paging | see more detail below | page information of this query |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |



### Delete a product request
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">DEL</i>
		<h6>https://api.tiki.vn/integration/{version}/requests/{request_id}</h6>
	</div>
</div>

Delete a created product request base on request_id of TIKI system

> Example

```http
DELETE https://api.tiki.vn/integration/v1/requests/1115320939429986651
```

> Response body

```json
{
    "request_id": "1115320939429986651",
    "state": "deleted"
}
```
#### **Request**

| Headers | Content-type | application/json |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key (contact Tiki supporter)  |  |  |
| Path Parameters | Name | Type | Mandatory | Description |
|  | request_id | String | Y | the request_id you want to delete |

#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| request_id | String| 1115320939429986651 | the request_id you just deleted |
| state | String | deleted| the new state of this request |

#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | your request is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |

