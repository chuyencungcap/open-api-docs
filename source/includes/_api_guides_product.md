# API Integration step by step

## Create new product request

#### I need to create product , Why TIKI called it is a "product request" ?
![](https://i.imgur.com/EaZ1z0c.png)

Because Tiki need to review your product data, document... both automatically and manually before bringing your products to the shelves.

TIKI product data is different from your original data so we need to transform it a bit. Base on [TIKI 's product structure](#tiki-product-structure) each variant will be become a brand new Tiki product. It means 1 product request made from 1 product from your side can create one or more product in Tiki side.

TIKI will update your request status step by step. Once the status become 'approved', your products will be displayed in TIKI website immediately.
Maybe it can be rejected by some reason such as image invalid,attribute not found,... please check via [tracking method](#tracking-product-request),
fix it then create a new one because product request was rejected can't be updated anymore

![](https://salt.tikicdn.com/ts/docs/d4/00/06/b0a89796eb11796a3d38194dde902214.png)

TIKI will update your product request status step by step.
Once the status become approved , your product will be displayed in TIKI website immediately.

### Alright, you can create products on TIKI easily by following these steps:
![](https://salt.tikicdn.com/ts/docs/55/46/b0/63787d50bb047afeec1be984be0da3a7.png)

### Create product request flow
![](https://salt.tikicdn.com/ts/docs/a5/40/83/5d84ed60bd9e4250f09aca83431f453b.jpeg)

### 1. [Search TIKI categories using this endpoint](#get-categories) → map with your original category

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/categories</h6>
	</div>
</div>

> search categories example:

```http
GET https://api.tiki.vn/integration/v1/categories
```

> sample categories

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
    - by keyword [https://api.tiki.vn/integration/v1/categories?name=book&primary=1](https://api.tiki.vn/integration/v1/categories?name=book&primary=1)
    - travel over categories tree : [https://api.tiki.vn/integration/v1/categories?parent=17166](https://api.tiki.vn/integration/v1/categories?parent=17166)

- Until you got a primary category have `"primary": 1` in response.
It's the smallest unit used to classify products at TIKI, one product belong to exactly one primary category.
- Save the **category_id** to use it later

### 2. Get attribute from primary category you chosen → map with your original attribute

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/categories/{category_id}</h6>
	</div>
</div>

> Get category detail example:

```http
GET https://api.tiki.vn/integration/v1/categories/20768
```

> sample category details

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
* Note that only the primary category has the attribute to make the product request
* Each category have some required attribute like `origin` have `"is_required": 1`. You have to complete this field base on our example.
* But your side don't have anything to map to these or you still don't have any idea about this then I can give you a small tips.
It is you can complete required attribute with a dummy data like `updating` maybe it can bypass our automate review but I have to warn you if you abuse this TIKI content reviewer may reject your product request.

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

> Create product request example

```http
POST https://api.tiki.vn/integration/v1/requests
```

> sample request body ( simple product - only 1 sku )

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
            "quantity": 100
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

There are two kinds of product at TIKI: simple product and configurable products.

* **Simple products** are the products that has attributes and only one instance/variant
* **Configurable products** are the products that has many variants.

Configurable products has many variants. Example: an iPhone has many variants differ by colors.
They are called **option_attributes**.

![](https://i.imgur.com/EaZ1z0c.png)

### 5. If you want to create a configurable product

> configurable product request body ( configurable product - 2 or more sku )

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

With configurable products:

* A configurable product has many **variants** and each variant maybe has its own attribute (examples : name, color...)
* The attributes that are used to differentiate two variants, are named **option attributes**. Example a T Shirt differ two variants by color and size but a phone differ by RAM & screen size.

Please fill data in option_attributes and option1,option2 field.
Tiki support up to 2 option attributes ( size, color , capacity , ... )
so if you have products with more than 2, combine them or create separate products before making a product request.

Example : you are selling iPhone by

- Model : 7, 8, XS, XS max, ..
- Color : Black , White , Gold , ...
- Storage : 32GB , 64GB , 128GB

You can combine 3 single attributes into 2 aggregate attributes `model` and` color + storage`
or split each iPhone model into 1 product containing 2 option attributes `color` and `storage`.

- option1 is the value for the first option in `option_attributes` ( `XL` for `size` )
- option2 is the value for the last option in `option_attributes` ( `red` for `color` )

Example : Product is iPhone have `"option_attributes":["color","storage"]` so your variant should be

- "option1" : "Black" , "option2" : "32GB"
- "option1" : "Black" , "option2" : "64GB"
- "option1" : "White" , "option2" : "32GB"
- "option1" : "White" , "option2" : "64GB"
- "option1" : "White" , "option2" : "128GB"

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

+ **Override rule** describe how transform system will treat your product request if any field is conflict between variant and parent product.

    By default child product will inherit all of member from its parent.

* No : Field can't not override
* Replace : Field of variant will replace the parent one.
* Merge : **attributes** will merged from both side.

### 6. How do I know when a product request is made successfully?

Once you click send product request you will be received a response immediately

![](https://salt.tikicdn.com/ts/docs/61/a1/d7/54a3cf5b283860b924aec851e2fdd748.png)

This response means that your product request has been queued for processing.
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

After all , your product request 's status maybe become `drafted` or `awaiting_approve`.
Note that during the testing phase we temporarily change your state to `drafted` to double check both sides before we actually do it.
After both TIKI and seller confirm testing completed we will set the state to automatically skip `drafted` and switch to `awaiting_approve` from then on.
`awaiting_approve` means that your request is pending review by the team of TIKI content.

![](https://salt.tikicdn.com/ts/docs/b0/ce/15/3ba9f951e6dcca74fcdcf6c1b3f2e0b2.png)

Your job is done, normally you will receive results after 2 to 3 hours of work.
By the time the status of the product request becomes approved, your product is ready on the TIKI website

### 7. Some common error while create product request

- missing supplier → supplier is a constant present for the location of your storage → please contact TIKI supporter to get this while **develop a create supplier endpoint**
- option_attributes not valid → TIKI support 2 option attributes at most so if you need more than 2 option , please merge some of them before create product
- missing required attribute → try to map attribute → fill dummy data like "updating"
- image error → TIKI support image at 500x500 px at least for the best UI/UX → so please resize your invalid image if you don't want to miss them

## Tracking product request

After TIKI received your product request then you can track its current status by the **track_id** we gave you in the http response from [create product request](#create-product-request)

> create product request response

```json
{
    "track_id": "3385dfc74f3e4a6bb947766c6e9a742f",
    "state": "queuing"
}
````

When your product request state is queuing , it means your request just received . You can refer [product request status flow](#tiki-product-request-status-flow) here.

![](https://salt.tikicdn.com/ts/docs/b4/63/37/1a065637ded38bbd3373eee0c4832961.png)

- note that **drafted** is a temporary state only appear in test environment . In production your product request will be redirected directly into **awaiting_approve** . Your task finish once request 's state become drafted/awaiting_approve
- while your request is on flow , it maybe become **rejected** by some reason , please check it
- if you want to delete your product request by yourself, use [delete request](#delete-a-request) to force request 's state into **deleted**

At first your request is checked automatically, you can track it by these method.
After that, your product request is sent to the other queue to check manually, you can tracking its current state via these method.
Once your product request is created we will provide its `request_id` for you

![](https://salt.tikicdn.com/ts/docs/92/93/a1/59563dc9ae0fbac431af147eedddf79f.png)

- [Track the latest product request](#tracking-latest-product-request)

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/tracking</h6>
	</div>
</div>

- [Track a product request](#tracking-a-product-request) using **track_id** in [create product response](#create-product-request)

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/tracking/{track_id}</h6>
	</div>
</div>

`track_id` will expire after 30 days. The tracking method is used to track the current state of the request in each campaign.
If you want to manage requests made in the past, take a look at the [manage product request](#manage-product-request) method below

## Replay product request

> Replay product request example

```http
POST https://api.tiki.vn/integration/v1/tracking/4cd90cf9294047c9984c1a7f6a1c67de/replay
```

> Replay product request response

```json
{
  "track_id": "4cd90cf9294047c9984c1a7f6a1c67de",
  "state": "queuing"
}
```

Your request has been rejected because of some unexpected reason like this :

![](https://salt.tikicdn.com/ts/docs/d8/51/45/f3f2936a0677eab338fb0b3830a1a1a7.jpeg)

maybe the network is unstable, the transform method doesn't work properly, ... you can try [replay it once again](#replay-a-product-request)

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>https://api.tiki.vn/integration/v1/tracking/{track_id}/replay</h6>
	</div>
</div>

The state will return to `queuing` exactly like creating a product request but keep the `track_id`

## Manage product request

### 1. [Query the latest request info](#get-latest-product-request-info) (created successfully request only)

> Get latest product request example

```http
GET https://api.tiki.vn/integration/v1/requests
```

> sample product request

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

> Get a product request example

```http
GET https://api.tiki.vn/integration/v1/requests/1121456196340384958
```

> request detail example

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
        "origin": {
          "attribute_code": "origin",
          "value": 10661,
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
        }
      }
    }
  ]
}
```

  - you can include product information here to get the full information of these product request but maybe the query will be slower.
  `products` contains product data after transform via TIKI system so maybe you might look a bit strange but we will try to display the data on TIKI as closely as possible to the original data.
  - you can filter by state ( rejected, deleted, approved,... ) for easier access to your own purposes

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests</h6>
	</div>
</div>

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests?include=products</h6>
	</div>
</div>

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests?state=approved</h6>
	</div>
</div>

### 2. [Query a product request by request_id](#get-a-product-request-info) from TIKI system

You can get `request_id` through TIKI seller center or our latest product request method

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests/{request_id}</h6>
	</div>
</div>

### 3. [Query a product request by track_id](#get-a-product-request-by-track-id) from [create product request](#create-product-request) response

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/requests/findBy?track_id={track_id}</h6>
	</div>
</div>

## Delete a request

If you want to reject your request by yourself because you pushed wrong data
or you want to delete old request before to create a new one
or maybe you don't want to see it in the query list anymore. So we provide you 2 method to do it.

- Delete by request_id

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-delete">DELETE</i>
		<h6>https://api.tiki.vn/integration/v1/requests/{request_id}</h6>
	</div>
</div>

- Delete by track_id

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-delete">DELETE</i>
		<h6>https://api.tiki.vn/integration/v1/requests/findBy?track_id={track_id}</h6>
	</div>
</div>

- You can [Find a request](#manage-product-request) from the list then choose its **request_id** or choose it directly by the **track_id**

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

Then change the request method from GET to DELETE to [delete request](#delete-a-request)

So easy right ?

![](https://salt.tikicdn.com/ts/docs/83/68/f8/1e17d3443855741ccefb3a5e51a4000a.png)

## Manage product

> Get latest products example

```http
GET https://api.tiki.vn/integration/v1/products
```

> sample latest products

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

for the best performance we provide summary of product only, we also provide some filter method by 

- `category_id` -> category of product
- `active` -> current active status of product ( 1 = active | 0 = inactive)
- `created_from_date` -> products `created_at` will be >= this time
- `created_to_date` -> products `created_at` will be <= this time

*Note : API use yyyy-MM-dd HH:mm:ss datetime format 
Example : `2020-03-05 11:27:24` ~ 11:27:24 am , 5th March 2020 

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/products?active={active}</h6>
	</div>
</div>

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/products?category_id={category_id}</h6>
	</div>
</div>

### 2. [Get your product by TIKI product_id](#get-a-product)  :

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/products/{product_id}</h6>
	</div>
</div>

this API will show you product detail contain its attribute and inventory

### 3. [Get your product by your original_sku](#get-a-product-by-original-sku) :

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/v1/products/findBy?original_sku={original_sku}</h6>
	</div>
</div>

## Update product information

At the present time we provide several solutions to update product information.
Based on the product structure and TIKI policy related to product management, attributes, categories, legal, etc. 
Depending on the field you want to update, you need to use the corresponding API, to avoid unnecessary confusion.
Please read carefully and use the correct API endpoint you need

----------------------

> Update price, quantity, active example

```http
POST https://api.tiki.vn/integration/v1/products/updateSku
```

> Update price , quantity, active request body

```json
{
    "original_sku" : "SELLER_SKU",
    "price": 13000,
    "quantity":100,
    "active":1
}
```

This API use to [update price, quantity, active](#update-variant-price-quantity-active).
Your request will be approved automatically.
Note that in this API you have to use your original sku from your system to update this product.
You can update price only , active only or mix them up depend on your choice, ...

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>https://api.tiki.vn/integration/v1/products/updateSku</h6>
	</div>
</div>

----------------------

> Update market_price , image , images example

```http
POST https://api.tiki.vn/integration/v1/requests/updateProductInfo
```

> Update market_price , image , images request body

```json
{
    "product_id": 2138351,
    "market_price": 7000000,
    "image": "https://images-na.ssl-images-amazon.com/images/I/71rBcMwMq4L._SS500_.jpg",
    "images": [
        "https://images-na.ssl-images-amazon.com/images/I/31%2BtDPe1XfL._SS500_.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/61vGd9wTrxL._SS500_.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/61sTz%2BhRd4L._SS500_.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/41gOwCRsQ7L._SS500_.jpg"
    ]
}
```

This API use to [update market_price , image thumbnal or list images media](#update-market-price-images).
base on TIKI policy , those is shared value among all seller that seller this product so we need to review it
your request will be created as update product request.

- You can tracking update product request via [tracking endpoint](#tracking-product-request)
- You can [get request detail](#get-a-product-request-info) as normal product request 

The good news for you is the flow of updating product is simpler and faster than the flow of creating new product.
The flow of state is almost like creating new product, but different from the last two.
Just by the time you drink a cup of coffee, your product has been updated

* `update_product_awaiting_approve` instead of `awaiting_approve`
* `update_product_approved` instead of `approved`

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>https://api.tiki.vn/integration/v1/requests/updateProductInfo</h6>
	</div>
</div>

> Update market_price , image , images example

```http
POST https://api.tiki.vn/integration/v1/requests/updateProductInfo
```

> Update market_price , image , images request body

```json
{
    "product_id": 2138351,
    "market_price": 7000000,
    "image": "https://images-na.ssl-images-amazon.com/images/I/71rBcMwMq4L._SS500_.jpg",
    "images": [
        "https://images-na.ssl-images-amazon.com/images/I/31%2BtDPe1XfL._SS500_.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/61vGd9wTrxL._SS500_.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/61sTz%2BhRd4L._SS500_.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/41gOwCRsQ7L._SS500_.jpg"
    ]
}
```