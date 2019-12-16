# Product Endpoint
## Let's get started
Sellers can create **products** to sell on TIKI. A product can be sold by many sellers. Sellers offer their price and quantity for a product on TIKI.

There are two kinds of product at TIKI: simple product and variable products. 

* **Simple products** are the products that has attributes and only one instance/variant
* **Variable products** are the products that has many variants.

Variable products has many variants. Example: an iPhone has many variants differ by colors.

They are called **option_attribute**s. Tiki support up to 2 option attributes ( size, color , capacity , ... )

![](https://i.imgur.com/EaZ1z0c.png)


Each product belong to a specific **category** in a hierarchy. Example : iPhone belong to Cellphones → Smartphones → Apple → iPhone

Normally , only some category is **primary** that you can put products into it. In this case, the **primary category** is iPhone.

Each product has basic attributes: 

* Name: the name of product that is displayed on TIKI
* Price: the sell price of a product
* Market price : the price before discount of a product
* Description: describe the information of products
* Category: the primary category that products are belong. You must choose over Tiki Information APIs carefully
* Image: the avatar of product on TIKI
* Images: the image gallery of product on TIKI
* The other attributes are based on the category of products, like RAM/CPU/Screen. That's why you need to choose category carefully at first
![](https://i.imgur.com/A2x7oeo.png)

* **Price** and **market price** use the **currency** which seller set with TIKI supporter when registry.

With variable products:

* A variable product has many **variants** and each variant maybe has its own attribute (examples : name, color...) 
* Variants differ by maximized two attributes. Example: a T Shirt has many variants that differ by color and size
* The attributes that are used to differentiate two variants, are named **option attributes**. Example a T Shirt differ two variants by color and size but a phone differ by RAM & screen size.

## Sequence diagram

![](https://i.imgur.com/9qFwq2i.png)
1. Client get/search tiki categories
2. Select tiki category, your product will map to tiki category
3. Using categoryId, get list attributes by categoryId
4. Mapping from your attribute to tiki attribute by code
5. After mapping success, you call API create product

## Entity


> **Entity** example:

```json
{
    "id": 218,
    "name": "Medical Books",
    "parent": 320,
    "primary": 1
}
```

| Field   | Type    | Example       | Description                            |
| ------- | ------- | ------------- | -------------------------------------- |
| id      | Integer | 218           | id of category                         |
| name    | String  | Medical Books | name of category                       |
| parent  | Integer | 320           | category_id of parent category         |
| primary | Integer | 1             | only primary category can have product |




### Attribute
> **Attribute** example:

```json
{
      "id": 498,
      "code": "author",
      "display_name": "Author",
      "is_required": 1
}
```

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| id | Integer | 498 | id of attribute |
| code | String | author | attribute code use to put into the attributes branch in payload |
| display_name | String | Author | the display name of this attribute |
| is_required | Integer | 1/0 | user must complete all of required attribute in payload |



### Product
> **Product** example:

```json
{
  "category_id": 1846,
  "name": "Laptop Dell Vostro 17 XPPP",
  "description": "this is description",
  "market_price": 12222222,
  "attributes": {
    "ram": "8GB",
    "ram_type": "Nvidia",
    "bus": "1333hz",
    "camera": "32MP",
    "audio_technology": "",
    "hard_drive": "1TB",
    "connection_port": "",
    "card_reader": "",
    "brand": "Dell Vostro"
  },
  "image": "https://www.laptopvip.vn/images/laptopvip_cache/e393b8aa5ec204efbea7582fc83a97ad/2/2/2249/original/2990378119/laptop-dell-xps-15-9570-05.png",
  "images": [
    "https://www.laptopvip.vn/images/companies/1/san-pham/untitled%20folder/dell%20xps%209570/800x530xdell-xps-15-2-in-1-review-front-display-1200x9999.jpg",
    "https://www.laptopvip.vn/images/companies/1/san-pham/untitled%20folder/dell%20xps%209570/x39b57caa-31ac-4872-9411-62bc6b15bffd.png"
  ],
  "option_attributes": [],
  "variants": [
    {
      "sku": "sku1",
      "price": 20000,
      "quantity": 20,
      "inventory_type" : "cross_border",
      "supplier" : 239091
    }
  ]
}
```

| Field | Type | Mandatory | Description |
| :--- | :--- | :--- | :--- |
| category_id | Integer | Y | TIKI categoryId you mapped before |
| name | String | Y | the name of product |
| description | String | Y | the description of product |
| market_price | Integer | N | the price of product before discount |
| attributes | List&lt;Attribute&gt; | Y | list of attributes retrieve from category\_id  |
| image(*) | String | Y | the avatar url of product |
| images(*) | List&lt;String&gt; | Y | list urls of product gallery |
| option_attributes(*) | List&lt;String&gt; | Y | list of attribute code to config product \( up to 2 \) |
| variants | List&lt;Variant&gt; | Y | list of variants, simple product have only 1 |



**\*Note**:

+ if product type is simple (only one variant) then **option_attributes** must be empty list instead of null value because option attributes is a required field.

+ **images** do not accept null value, please put empty list if product don't have any image. The avatar from **image** will be added to **images** later so you don't need to add it 2 times.

Even you do that, we will check duplicate image by url.

\*For the best user experience, TIKI only display image have size greater than 500x500 pixel in the media gallery and lower than 700 width pixel inside description

### Variant

| Field | Type | Mandatory | Override rule(*) | Description |
| :--- | :--- | :--- | :--- | :--- |
| sku | String | Y | No | variant 's sku from source side |
| price | Integer | Y | No | variant 's sell price |
| market_price | Integer | N | Replace | variant 's market price \( price before discount \) |
| option1 | String | N | No | attribute code of the first option attribute |
| option2 | String | N | No | attribute code of the first second attribute |
| inventory\_type\(\*\) | String | N | No | inventory type of this variant |
| quantity | Integer | Y | No | number of products available for sell |
| supplier\(\*\) | Integer | Y | No | see detail below |
| name | String | N | Replace | name of this variant |
| description | String | N | Replace | description of this variant |
| attributes | List&lt;Attribute&gt; | N | Merge  | list specific/addition attribute for this variant |
| image | String | N | Replace | avatar url of this variant |
| images | String | N | Replace | list urls of variant product gallery |

**\*Note**:

+ **option1**, **option2** is required corresponding with the number of option attributes start from 1.

    The unused option value maybe null or empty or even don't need to appear.That's why it's mandatory still equal "no"  

+ **Override rule** describe how transform system will treat your request if any field is conflict between variant and parent product.

    By default child product will inherit all of member from its parent.

* No : Field can't not override 
* Replace : Field of variant will replace the parent one.
* Merge : **attributes** will merged from both side.

+ **inventory_type** must be one of below values and have to be in registered list. If you don't put value in product request, then the latest method will be picked up.

+ **supplier** is an integer constant describe the location of seller 's storage.Each seller can have some **supplier** but each product must be stored in a fixed **supplier**

If seller is in Vietnam, please register your supplier list in TIKI **Seller Center** system

If seller is abroad, you have only one supplier, please contact TIKI supporter to get this value.

**\*\) List inventory_type :**

> Example:

```json
{
      "sku": "sku1",
      "quantity": 21,
      "option1": "Black",
      "option2": null,
      "price": 10000001,
      "inventory_type" : "cross_border",
      "supplier" : 239091,
      "image": "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008711602926121_SS-note-10-pl-den-1-1.png",
      "images": [
        "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008619323404785_SS-note-10-pl-den-2.png",
        "https://cdn.fptshop.com.vn/Uploads/Originals/2019/8/8/637008619327294396_SS-note-10-pl-den-4.png"
      ]
}
```

| inventory_type | customer | description |
| :--- | :--- | :--- |
| cross_border | for Global seller | products is transported from abroad |
| instock | for Vietnamese seller | products in TIKI storage, TIKI pack, TIKI deliver |
| backorder | for Vietnamese seller | products in seller storage, TIKI pack, TIKI deliver |
| seller_backorder | for Vietnamese seller | products in seller storage, seller pack, seller deliver |
| drop_ship | for Vietnamese seller | products in seller storage, seller pack, TIKI deliver  |



## Get categories

### HTTP Request ###
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

### **Request**

| Headers          | Content-type | application/json |           |                                                            |             |
|:---------------- |:------------ |:---------------- |:--------- |:---------------------------------------------------------- |:----------- |
| Path Parameters  | Name         | Type             | Mandatory | Example                                                    | Description |
| version          | String       | Y                | v1        | version of API                                             |             |
| Query Parameters | Name         | Type             | Mandatory | Example                                                    | Description |
| |lang             | String       | N                | en        | Filter by language en/vi (**default is en - english**) |             |
| |name             | String       | N                | book      | Filter name by keyword (case insensitive)              |             |
| |parent           | Integer      | N                | 8         | Filter children of this parent_id only   |
| |primary | Integer | N | 1 | Filter product pushable category |  |

### **Response :** 

| Field | Type | Description |
| :--- | :--- | :--- |
| root | List&lt;**Category**&gt; | the summary list of category filtered by request params |


### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |

---------------------------------------------------------------------------------------------------------------

## Get category detail (include attribute)

### HTTP Request ###
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

### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Path Parameters | Name | Type | Mandatory | Example | Description |
| |version | String | Y | v1 | version of API |  |
| |id | Integer | Y | 218 | id of category (category_id) |  |

### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| id | Integer | 218 | id of category |
| name | String | Children's Books | name of category |
| parent | Integer | 320 | category_id of parent category |
| primary | Integer | 1 | only primary category can have product |
| description | String | Children's Books, international purchases buy at [Tiki.vn](http://tiki.vn/) Cheaper Free shipping 100% genuine | describe the detail of this category |
| attributes | List&lt;**Attribute**&gt;(*) | see detail below | attributes list of this category |

### **Exception Case**

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

## Create Product

### HTTP Request ###
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
  "category_id": 1846,
  "name": "Laptop Dell Vostro 17 XPPP",
  "description": "this is description",
  "market_price": 12222222,
  "attributes": {
    "ram": "8GB",
    "ram_type": "Nvidia",
    "bus": "1333hz",
    "camera": "32MP",
    "audio_technology": "",
    "hard_drive": "1TB",
    "connection_port": "",
    "card_reader": "",
    "brand": "Dell Vostro"
  },
  "image": "https://www.laptopvip.vn/images/laptopvip_cache/e393b8aa5ec204efbea7582fc83a97ad/2/2/2249/original/2990378119/laptop-dell-xps-15-9570-05.png",
  "images": [
    "https://www.laptopvip.vn/images/companies/1/san-pham/untitled%20folder/dell%20xps%209570/800x530xdell-xps-15-2-in-1-review-front-display-1200x9999.jpg",
    "https://www.laptopvip.vn/images/companies/1/san-pham/untitled%20folder/dell%20xps%209570/x39b57caa-31ac-4872-9411-62bc6b15bffd.png"
  ],
  "option_attributes": [],
  "variants": [
    {
      "sku": "sku1",
      "price": 20000,
      "quantity": 20,
      "inventory_type": "cross_border",
      "supplier": 239091
    }
  ]
}
```

> Configurable product example:

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
    "color"
  ],
  "variants": [
    {
      "sku": "sku1",
      "quantity": 21,
      "option1": "Black",
      "option2": null,	
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
      "price": 10000002,
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

**\*Note**: To understand the relation between variant and it's product parent please read the detail from: **Variant**(*)

### **Request**
You must complete all required attribute from category, all others can be ignored or pass null value


| Headers | Content-type | application/json |  |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| tiki-api | seller token key (contact Tiki supporter) |  |  |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |  |
| |version | String | Y | v1 | version of API |  |  |
| Body Parameters | Namespace | Field | Type | Mandatory | Example | Description |
|  | Root | **Product**(*) | Y | below | product detail to create |  |

### **Response**

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

### **Exception Case:**

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

## Tracking history

### HTTP Request ###
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

### **Request**

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

### **Response**

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


### **State list**

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

### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | missing header or required params |
| 401 | Unauthorized | your tiki-api token is not valid |
| 429 | Too Many Requests | Your rate limit is exceed |

---------------------------------------------------------------------------------------------------------------

## Tracking a request
### HTTP Request ###
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

### **Request**

| Headers | Content-type | application/json |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  | tiki-api | seller token key \( contact Tiki supporter \) |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |
| |version | String | Y | v1 | version of API |  |
| |trace\_id | String | Y | `c3587ec50976497f837461e0c2ea3da5` | trace_id of request get from product API |  |

### **Response**

| Field | Type | Example | Description | Note |
| :--- | :--- | :--- | :--- | :--- |
| trace\_id | String | `c3587ec50976497f837461e0c2ea3da5` | trace\_id to tracking this request |  |
| state | String | processing | current state of your request |  |
| reason | String | Image does not match product name | the reason why your request is rejected | only rejected request have reason |
| tiki\_sku | String | 2150725160607 | TIKI sku when product created successfully | only approved request have tiki\_sku |


### **State list**

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

### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
| 400 | Bad request | missing header or required params |
| 401 | Unauthorized | your tiki-api token is not valid |
| 404 | TraceId not found | traceId is invalid |
| 429 | Too Many Requests | Your rate limit is exceed |

---------------------------------------------------------------------------------------------------------------

## Update variant price/quantity/active
### HTTP Request ###
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

### **Request**

| Headers | Content-type | application/json |  |  |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| tiki-api | seller token key \( contact Tiki supporter \) |  |  |  |  |  |
| Path Parameters | Name | Type | Mandatory | Example | Description |  |
| |version | String | Y | v1 | version of API |  |  |
| |sku | String | Y | DANG19951995 | the original sku from your side system |  |  |
| Body Parameters | Namespace | Field | Type | Mandatory | Example | Description |
| |Variant | price | Integer | N | 10000 | product 's new price |  |
|  | |quantity | String | N | 10 | product 's new quantity |  |
|  | |active | Integer | N | 1 | product 's new status (1=active / 0=inactive) |  |


### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| state | String | approved | your product is updated successfully |


### **Exception Case**

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