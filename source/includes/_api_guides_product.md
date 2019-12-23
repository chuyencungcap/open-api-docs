# API Integration step by step

## Create new product request

#### I need to create product , Why TIKI called it is a "product request" ?
Because TIKI product data is different from your original data so we need to transform it a bit. Base on [TIKI 's product structure](#tiki-product-structure) each variant will be become a brand new Tiki product. It means 1 request made from 1 product from your side can create one or more product in Tiki side.

![](https://i.imgur.com/EaZ1z0c.png)

Tiki need to take a look , we have to review your product data, document,...  both automatically and manually before bring product to the shelves.
Maybe it can be rejected by some reason such as image invalid,attribute not found,... please check via [tracking method](#tracking-a-request), fix it then create a new one 
because product request was rejected can't be updated anymore

![](https://salt.tikicdn.com/ts/docs/d4/00/06/b0a89796eb11796a3d38194dde902214.png) 

TIKI will update your request status step by step.
Once the status become approved , your product will be displayed in TIKI website immediately. 


### Alright, you can create products on TIKI easily by following these steps:
![](https://salt.tikicdn.com/ts/docs/55/46/b0/63787d50bb047afeec1be984be0da3a7.png)

### 1. [Search TIKI categories using this endpoint](#get-categories) → map with your original category

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/categories</h6>
	</div>
</div>

> Category example

```json
[
    {
      "id": 17166,
      "name": "International Products",
      "parent": 2,
      "primary": 0
    },
    {
      "id": 20768,
      "name": "Snacks & Candies",
      "parent": 20766,
      "primary": 1
    },
    {
      "id": 20770,
      "name": "Pet Care",
      "parent": 20766,
      "primary": 1
    }
]
```

- You can search categories :
    - by keyword : https://api.tiki.vn/integration/v1/categories?name=book&primary=1
    - travel over categories tree : https://api.tiki.vn/integration/v1/categories?parent=17166

- Until you got a primary category because product must be in exactly one category
- Save the **category_id** to use it later
   
    
### 2. Get attribute from category you chosen → map with your original attribute

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/categories/{category_id}</h6>
	</div>
</div>

> Attribute example

```json
[
 {
   "id": 560,
   "code": "origin",
   "display_name": null,
   "is_required": 1,
   "example": "Vietnam"
 },
 {
   "id": 708,
   "code": "brand_origin",
   "display_name": null,
   "is_required": 1,
   "example": "Vietnam"
 },
 {
   "id": 1241,
   "code": "require_expiry_date",
   "display_name": null,
   "is_required": 1,
   "example": "1 or 0"
 }
]
```
* Visit category detail to see its attributes like this : [https://api.tiki.vn/integration/v1/categories/20768](https://api.tiki.vn/integration/v1/categories/20768)
* Each category have some required attribute like `origin` have `"is_required": 1`. You have to complete this field base on our example.
* But your side don't have anything to map to these or you still don't have any idea about this then I can give you a small tips.
It is you can complete required attribute with a dummy data like `updating` maybe it can bypass our automate review but I have to warn you if you abuse this TIKI content reviewer may reject your request.  

### 3. Ask Tiki supporter for your inventory_type and supplier

**inventory_type** and **supplier** are generated automatically when you sign a contract to sell product in TIKI.

In the simplest case also the most common case ( have only 1 `inventory_type` ), you just need to contact TIKI supporter to get supplier only to create new product request.
You don't even need to know what is your inventory type because we will use the type in your contract as default value.

And if you still want to learn more about TIKI system , you can refer to the following definition :

* [inventory_type](#inventory-type) is a selected value answer some question 
    * "Where are you from?"
    * "Tiki or seller have to bring product to the customer"
    * "TIKI come seller 's warehouse to take product or seller bring product to TIKI 's warehouse?"

* [supplier](#supplier) is an integer constant describe the location of seller 's warehouse. Each seller can have some supplier but each product must be stored in a fixed supplier

Note : In the case you have only one inventory type, TIKI will choose it as default value so you can ignore this field

### 4. Let's [create product request](#create-product-request).  

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>https://api.tiki.vn/integration/v1/requests</h6>
	</div>
</div>

> create simple product request ( 1 sku )

```json
 {
    "category_id": 21458,
    "name": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch with Rhinestones",
    "description": "this is description",
    "market_price": 100000,
    "attributes": {
        "bulky": 0,
        "origin": "american",
        "brand_origin" : "casio",
        "product_top_features": "White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design\n37-mm metal case with glass dial window\nQuartz movement with analog display\nMetal alloy bracelet with jewelry-clasp closure\nNot water resistant\n",
        "brand": "Disney",
        "case_diameter": "37 millimeters",
        "filter_case_diameter": "37 millimeters",
        "band_material": "metal-alloy",
        "filter_band_material": "metal-alloy"
    },
    "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsL.jpg",
    "images": [
        "https://images-na.ssl-images-amazon.com/images/I/6110JInm%2BBL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/41FuQMh3FUL.jpg"
    ],
    "option_attributes": [],
    "variants": [
        {
            "sku": "B0055QD0EC2",
            "price": 99000,
            "inventory_type": "cross_border",
            "supplier": 167797,
            "quantity": 100,
            "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsL.jpg",
            "images": [
                "https://images-na.ssl-images-amazon.com/images/I/6110JInm%2BBL.jpg",
                "https://images-na.ssl-images-amazon.com/images/I/41FuQMh3FUL.jpg"
            ]
        }
    ]
 }
```

Do you still remember these values I said you need to save before? 

They are `category_id` , `attributes`, `inventory_type` , `supplier`

You also have to provide some more field : 

* Name: the name of product that is displayed on TIKI
* Price: the sell price of a product
* Market price : the price before discount of a product
* Description: describe the information of products
* Category: the primary category that products are belong. You must choose over Tiki Information APIs carefully
* Image: the avatar of product on TIKI
* Images: the image gallery of product on TIKI
* The other attributes are based on the category of products, like RAM/CPU/Screen. That's why you need to choose category carefully at first

Look at my example here to see what is product request look like

There are two kinds of product at TIKI: simple product and configurable products. 

* **Simple products** are the products that has attributes and only one instance/variant
* **Configurable products** are the products that has many variants.

Configurable products has many variants. Example: an iPhone has many variants differ by colors.

They are called **option_attribute**s. Tiki support up to 2 option attributes ( size, color , capacity , ... )

![](https://i.imgur.com/EaZ1z0c.png)

### 5. If you want to create a configurable product 

> create configurable product request ( multi sku )

```json
{
    "category_id": 21458,
    "name": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch with Rhinestones",
    "description": "this is description",
    "market_price": 100000,
    "attributes": {
        "bulky": 0,
        "origin": "american",
        "brand_origin": "casio",
        "product_top_features": "White bracelet watch featuring rhinestone-accented bezel and mother-of-pearl dial with sparkling Mickey Mouse design\n37-mm metal case with glass dial window\nQuartz movement with analog display\nMetal alloy bracelet with jewelry-clasp closure\nNot water resistant\n",
        "brand": "Disney",
        "case_diameter": "37 millimeters",
        "filter_case_diameter": "37 millimeters",
        "band_material": "metal-alloy",
        "filter_band_material": "metal-alloy"
    },
    "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsL.jpg",
    "images": [
        "https://images-na.ssl-images-amazon.com/images/I/6110JInm%2BBL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/41FuQMh3FUL.jpg"
    ],
    "option_attributes": [
        "size",
        "color"
    ],
    "variants": [
        {
            "sku": "B0055QD0EC2",
            "price": 99000,
            "option1": "XL",
            "option2": "red",
            "inventory_type": "cross_border",
            "supplier": 167797,
            "quantity": 100,
            "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsLBY.jpg"
        },
        {
            "sku": "B0055QD0EC3",
            "price": 99000,
            "option1": "L",
            "option2": "red",
            "inventory_type": "cross_border",
            "supplier": 167797,
            "quantity": 100,
            "image": "https://images-na.ssl-images-amazon.com/images/I/715uwlmCWsLBX.jpg"
        }
    ]
}
```

Please fill data in option_attributes and option1,option2 field. Maybe your payload will look like this : 

With configurable products:

* A configurable product has many **variants** and each variant maybe has its own attribute (examples : name, color...) 
* Variants differ by maximized two attributes. Example: a T Shirt has many variants that differ by color and size
* The attributes that are used to differentiate two variants, are named **option attributes**. Example a T Shirt differ two variants by color and size but a phone differ by RAM & screen size.

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

### 6. How do I know when a product request is made successfully?

Once you click send request you will be received a response immediately

![](https://salt.tikicdn.com/ts/docs/61/a1/d7/54a3cf5b283860b924aec851e2fdd748.png)

This response means that your request has been queued for processing.
If there are not too many requests then it will probably be done right away

Then use tracking_id to track the next state of the request. Maybe you can be received an error like this
,just fix your payload based on the reason, after that send a new product request. Everything will be fine 

![](https://salt.tikicdn.com/ts/docs/a6/b4/bd/b3cc323014a3d2f4eb1a28b6c3b8898a.png)

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/tracking/{track_id}</h6>
	</div>
</div>

After all , your request 's status maybe become `drafted` or `awaiting_approve`.
Note that during the testing phase we temporarily change your state to `drafted` to double check both sides before we actually do it.
After both TIKI and seller confirm testing completed we will set the state to automatically skip `drafted` and switch to `awaiting_approve` from then on.
`awaiting_approve` means that your request is pending review by the team of TIKI content.

![](https://salt.tikicdn.com/ts/docs/b0/ce/15/3ba9f951e6dcca74fcdcf6c1b3f2e0b2.png)

Your job is done, normally you will receive results after 2 to 3 hours of work.
By the time the status of the request becomes approved, your product is ready on the TIKI website 

### 7. Some common error while create product request

- missing supplier → supplier is a constant present for the location of your storage → please contact TIKI supporter to get this while **develop a create supplier endpoint**
- option_attributes not valid → TIKI support 2 option attributes at most so if you need more than 2 option , please merge some of them before create product
- missing required attribute → try to map attribute → fill dummy data like "updating"
- image error → TIKI support image at 500x500 px at least for the best UI/UX → so please resize your invalid image if you don't want to miss them

## Tracking created request

After TIKI received your product request then you can track its current status by the **track_id** we gave you in the http response from [create product request](#create-product-request)

> create product request response body

```json
{
    "track_id": "3385dfc74f3e4a6bb947766c6e9a742f",
    "state": "queuing"
}
````

When your product state is queuing , it means your request just received . You can refer [request status flow](#tiki-request-status-flow) here.

![](https://salt.tikicdn.com/ts/docs/b4/63/37/1a065637ded38bbd3373eee0c4832961.png) 

- note that **drafted** is a temporary state only appear in test environment . In production your request will be redirected directly into **awaiting_approve** . Your task finish once request 's state become drafted/awaiting_approve
- while your request is on flow , it maybe become **rejected** by some reason , please check it
- if you want to close your request , use delete request endpoint to force request 's state into **deleted**

At first your request is checked automatically, you can track it by these method: 

- [Track the latest request](#tracking-latest-request) ( include queuing , processing request )

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/tracking</h6>
	</div>
</div>

- [Track a request](#tracking-a-request) using **track_id** in [create product response](#create-product-request)

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/tracking/{track_id}</h6>
	</div>
</div>

After that, your request is sent to the other queue to check manually, TIKI will generate `product_id` for your request.
In this phase beside the methods listed above , you can try these to tracking or query product request to manage your requests easier.

### 1. [Query the latest request](#get-latest-requests) ( exclude queuing , processing request )

> product request example 

```json
{
  "name": "Disney Women's MK2106 Mickey Mouse White Bracelet Watch with Rhinestones",
  "request_id": "1121456196340384958",
  "state": "approved",
  "product_id": 2091399,
  "sku": "9493225709765",
  "master_id": 0,
  "master_sku": "9493225709765",
  "super_id": 0,
  "super_sku": "",
  "original_sku": null,
  "type": "simple",
  "entity_type": "master_simple",
  "price": 984000,
  "created_at": "2019-12-20 15:06:32",
  "created_by": "tran.nguyen2@tiki.vn",
  "kind": "create_product",
  "approved_at": "2019-12-20 15:07:07",
  "approved_by": "khoa.tran2@tiki.vn",
  "product_info": null,
  "reasons": null
}
```

  - you can include product_info here
  - you can filter by state ( rejected, deleted, approved,... )

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests</h6>
	</div>
</div>

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests?include=product_info</h6>
	</div>
</div>

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests?state=approved</h6>
	</div>
</div>
 
### 2. [Query a request by request_id](#get-a-request) from TIKI system, you can get them through TIKI seller center or our latest request method

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests/{request_id}</h6>
	</div>
</div>

### 3. [Query a request by track_id](#get-a-request) from [create product request](#create-product-request) response

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests/findBy?track_id={track_id}</h6>
	</div>
</div>

## Delete a request

If you want to rejected your request by yourself or maybe you don't want to see it in the query list anymore. So we provide you a method to do it.

[Find a request](#tracking-created-request) from the list then choose its **request_id** or choose it directly by the **track_id**

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests</h6>
	</div>
</div>

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests/findBy?track_id={track_id}</h6>
	</div>
</div>

Use its request_id to send [delete request](#delete-a-request)

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-delete">DELETE</i>
		<h6>https://api.tiki.vn/integration/v1/requests/{request_id}</h6>
	</div>
</div>

So easy right ?

![](https://salt.tikicdn.com/ts/docs/83/68/f8/1e17d3443855741ccefb3a5e51a4000a.png)

## Manage your product

> product example

```json
 {
  "product_id": 1351493,
  "sku": "3784172855527",
  "name": "Instock SKU",
  "master_id": 1351492,
  "master_sku": "2253996985457",
  "super_id": 0,
  "super_sku": null,
  "active": 1,
  "original_sku": "AB078AVD",
  "type": "simple",
  "entity_type": "seller_simple",
  "price": 200000,
  "market_price": 250000,
  "version": 11,
  "created_at": "2019-04-11 10:50:53",
  "created_by": "admin@tiki.vn",
  "thumbnail": "https://uat.tikicdn.com/ts/product/04/48/20/781bec172c768e17101c0dc08c5e0131.jpg",
  "images": [
    {
      "id": 47914343,
      "url": "https://uat.tikicdn.com/ts/product/04/48/20/781bec172c768e17101c0dc08c5e0131.jpg",
      "path": "product/04/48/20/781bec172c768e17101c0dc08c5e0131.jpg",
      "position": 0,
      "width": null,
      "height": null
    }
  ],
  "categories": [
    {
      "id": 1801,
      "name": "Máy Ảnh - Máy Quay Phim",
      "url_key": "may-anh",
      "is_primary": false
    },
    {
      "id": 1809,
      "name": "Máy ảnh DSLR",
      "url_key": "may-anh-chuyen-nghiep-dslr",
      "is_primary": true
    }
  ]
}
```

After all , your requests are approved , they become TIKI product :D And now you want to manage them ? "How many product do I have? Where are they ?" So we have some method for you :

### 1. [Get all of your product](#get-latest-products) : 

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/products</h6>
	</div>
</div>

### 2. [Get your product by TIKI product_id](#get-a-product)  :

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/products/{product_id}</h6>
	</div>
</div>

### 3. [Get your product by your original_sku](#get-a-product-by-original-sku) : 

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/products/findBy?original_sku={original_sku}</h6>
	</div>
</div>

## Update product information
> Update price , quantity, active example

```json
{
    "price": 13000,
    "quantity":100,
    "active":1
}
```

Unfortunately, we only can provide method to [update price, quantity, active]((#update-variant-price-quantity-active)) but we have a good new for you that your request will be approved automatically.
Note that in this API you have to use your original sku from your system to update this product. You can update price only , active only or mix them up depend on your choice, ... 

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>https://api.tiki.vn/integration/v1/products/{original_sku}/updateSku</h6>
	</div>
</div>

We will continue supporting some other method in the near future , please contribute us for the best user experience