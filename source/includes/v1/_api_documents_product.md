# API Documents
## Product API
The table below lists APIs that can be used for product management.

| API name | Description |
| -------- | -------- |
| [Get list products](#get-categories)| Get all of product (approved request) order by created_at desc (latest product)     |
| [Get category detail](#get-category-detail-include-attribute)| Retrieve detail of a single categories with its attributes|
| [Create Product](#create-product)| Create new product|
| [Tracking history](#tracking-history)| Tracking latest request of user (via token)|
| [Create Product](#create-product)| Create new product|
| [Tracking a request](#tracking-a-request)| Retrieve detail of a single request|
| [Update variant price/quantity/active](#update-variant-price-quantity-active)| Update non validate fields like price/quantity/active of a created product|
| [Get list products](#get-list-products)| Get all of product (approved request) order by created_at desc (latest product)|
| [Get a product](#get-a-product)| Get a product with product_id from TIKI system|
| [Get a product by original sku](#get-a-product-by-original-sku)| Get a product by original sku|
| [Get list requests](#get-list-requests)| Get all of product requests order by created_at desc (latest request)|
| [Get a request](#get-a-request)| Get a request with request_id from TIKI system|
| [Get a request by original sku](#get-a-request-by-original-sku)| Get a product match with seller original sku|
| [Delete a request](#delete-a-request)| Delete a created product request base on request_id of TIKI system|


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

### Create Product

#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/products</h6>
	</div>
</div>

Create new product

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
    "trace_id": "c3587ec50976497f837461e0c2ea3da5",
    "state": "queuing"
}
```

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| trace_id | String | `c3587ec50976497f837461e0c2ea3da5` | trace_id to tracking this request |
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

### Tracking history

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
    "trace_id": "c3587ec50976497f837461e0c2ea3da5",
    "state": "processing",
    "reason": null,
    "tiki_sku": null
  },
  {
    "trace_id": "c3587ec50976497f83edfgsdfgsdfgf5",
    "state": "rejected",
    "reason": "Image does not match product name",
    "tiki_sku": null
  },
  {
    "trace_id": "c3587ec50976497f837463gfsdfgbsfg",
    "state": "approved",
    "reason": null,
    "tiki_sku": "2150725160607"
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
| trace_id | String | `c3587ec50976497f837461e0c2ea3da5` | trace\_id to tracking this request |  |
| state | String | processing | current state of your request |  |
| reason | String | Image does not match product name | the reason why your request is rejected | only rejected request have reason |
| tiki_sku | String | 2150725160607 | TIKI sku when product created successfully | only approved request have tiki\_sku |


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

### Tracking a request
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/tracking/{trace_id}</h6>
	</div>
</div>

Retrieve detail of a single request

> Response body: 

```json
{
  "trace_id": "c3587ec50976497f837461e0c2ea3da5",
  "state": "rejected",
  "reason": "Image does not match product name",
  "tiki_sku": null
}
```

#### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key \( contact Tiki supporter \) |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |
| |version | String | Y | v1 | version of API |  |
| |trace\_id | String | Y | `c3587ec50976497f837461e0c2ea3da5` | trace_id of request get from product API |  |

#### **Response**

| Field | Type | Example | Description | Note |
| :--- | :--- | :--- | :--- | :--- |
| trace\_id | String | `c3587ec50976497f837461e0c2ea3da5` | trace\_id to tracking this request |  |
| state | String | processing | current state of your request |  |
| reason | String | Image does not match product name | the reason why your request is rejected | only rejected request have reason |
| tiki\_sku | String | 2150725160607 | TIKI sku when product created successfully | only approved request have tiki\_sku |


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
| 404 | TraceId not found | traceId is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |

---------------------------------------------------------------------------------------------------------------

### Update variant price/quantity/active
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/products/{sku}/updateSku</h6>
	</div>
</div>

Update non validate fields like price/quantity/active of a created product

```http
GET https://api.tiki.vn/integration/v1/products/DANG19951995/updateSku
```

```json
{
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

### Get list products
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


###Get list requests
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
  
> If you want to see product_info data:

```http
GET https://api.tiki.vn/integration/v1/requests?include=product_info
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



### Get a request
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/requests/{request_id}</h6>
	</div>
</div>

Get a request with request_id from TIKI system

> Example

```http
GET https://api.tiki.vn/integration/v1/requests/1115320939429986651
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



### Get a request by original sku
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/requests/findBy</h6>
	</div>
</div>

Get a product match with seller original sku

> Example

```http
GET https://api.tiki.vn/integration/v1/requests/findBy?original_sku=YOUR_ORIGINAL_SKU_123
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
|  | original_sku | Integer | Y | The original sku from seller side |

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



### Delete a request
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

