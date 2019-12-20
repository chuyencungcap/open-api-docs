# API Integration step by step

## Create new product request

#### I need to create product , Why TIKI called it is a "request" ?
Because TIKI product data is different from your original data so we need to transform it a bit. Base on [TIKI 's product structure](#tiki-product-structure) each variant will be become a brand new Tiki product. It means 1 request made from 1 product from your side can create one or more product in Tiki side.

![](https://i.imgur.com/EaZ1z0c.png)

Tiki need to take a look , we have to review your product data, document,...  both automatically and manually before bring product to the shelves. Maybe it can be rejected by some reason, please check via [tracking method](#tracking-a-request), fix it then create a new one. 

![](https://salt.tikicdn.com/ts/docs/b4/63/37/1a065637ded38bbd3373eee0c4832961.png) 

TIKI will update your request status step by step. Once the status become approved , your product will be displayed in TIKI website immediately. 


### Alright, you can create products on TIKI easily by following these steps:
![](https://i.imgur.com/9qFwq2i.png)

### 1. [Search TIKI categories using this endpoint](#get-categories) → map with your original category

`GET https://api.tiki.vn/integration/v1/categories`

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
* Each category have some required attribute like `brand` . You have to complete this field base on our example . The last choice if you still not have any idea , you can fill some dummy data like `updating` because your product request will be reviewed by TIKI content
* if you can't find some important attribute in your side but TIKI don't have, please contact TIKI supporter , we will add them into the list while we developing **create attribute endpoint**

### 3. Ask Tiki supporter for your inventory_type and supplier

**inventory_type** is a selected value describe Where are you come from ? How are you and Tiki committed to delivery product ? 

**supplier** is an integer constant describe the location of seller 's storage. Each seller can have some supplier but each product must be stored in a fixed supplier

You must provide these value to the payload when creating request. 

Note : In the case you have only one inventory type, TIKI will choose it as default value so you can ignore this field

### 4. [Create product request via endpoint](#create-product-request) . There are some important point need to focus please visit [TIKI product structure](#tiki-product-structure) for more detail : 

>POST https://api.tiki.vn/integration/v1/requests

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
### 5. If you want to create a configurable product , please  data in option_attributes and option1,option2 field. Maybe your payload will look like this . In this case, of course your variants  : 
   
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

### 6. Some common error while create product 
- missing supplier → supplier is a constant present for the location of your storage → please contact TIKI supporter to get this while **develop a create supplier endpoint**
- option_attributes not valid → TIKI support 2 option attributes at most so if you need more than 2 option , please merge some of them before create product
- missing required attribute → try to map attribute → fill dummy data like "updating"
- image error → TIKI support image at 500x500 px at least for the best UI/UX → so please resize your invalid image if you don't want to miss them

## Tracking created request

After TIKI received your product request then you can trace its current status by the **trace_id** we gave you in the http response from [create product request](#create-product-request)

```json
{
    "id": "3385dfc74f3e4a6bb947766c6e9a742f",
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

`GET https://api.tiki.vn/integration/v1/tracking`

- [Track a request](#tracking-a-request) using **trace_id** in [create product response](#create-product-request)

`GET https://api.tiki.vn/integration/v1/tracking/{trace_id}`

After that, your request is sent to the other queue to check manually, in this phase beside the methods listed above , you can try these to tracking or query, manage your requests

1. [Query the latest request](#get-latest-requests) ( exclude queuing , processing request )
  - you can include product_info here
  - you can filter by state ( rejected, deleted, approved,... )
  
`GET https://api.tiki.vn/integration/v1/requests`

`GET https://api.tiki.vn/integration/v1/requests?include=product_info`
    
`GET https://api.tiki.vn/integration/v1/requests?state=approved`
   
2. [Query a request by request_id](#get-a-request) from TIKI system, you can get them through TIKI seller center or our latest request method

3. [Query a request by trace_id](#get-a-request) from [create product request](#create-product-request) response

## Delete a request

If you want to rejected your request by yourself or maybe you don't want to see it in the query list anymore. So we provide you a method to do it.

- [Find a request](#tracking-created-request) from the list then choose by **request_id** or choose it directly by the **trace_id**

`GET https://api.tiki.vn/integration/v1/requests/`

`GET https://api.tiki.vn/integration/v1/requests/findBy?trace_id={trace_id}`

- [Use its request_id to send delete request]((#delete-a-request))

`DEL https://api.tiki.vn/integration/v1/requests/{request_id}`

So easy right ?

![](https://salt.tikicdn.com/ts/docs/83/68/f8/1e17d3443855741ccefb3a5e51a4000a.png)

## Manage your product

After all , your requests are approved , they become TIKI product :D And now you want to manage them ? "How many product do I have? Where are they ?" So we have some method for you :

- [Get all of your product](#get-list-products) : 

    `GET https://api.tiki.vn/integration/v1/products`

- [Get your product by TIKI product_id](#get-a-product)  :

    `GET https://api.tiki.vn/integration/v1/products/{product_id}`

- [Get your product by your original_sku](#get-a-product-by-original-sku) : 

    `GET https://api.tiki.vn/integration/v1/products/findBy?original_sku={original_sku}`

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
   

## Update product information

Unfortunately, we only can provide method to [update price, quantity, active]((#update-variant-price-quantity-active)) but we have a good new for you that your request will be approved automatically.
Note that in this API you have to use your original sku from your system to update this product: 

`POST https://api.tiki.vn/integration/v1/products/{original_sku}/updateSku `

```json
{
    "price": 13000,
    "quantity":100,
    "active":1
}
```

We will continue supporting some other method in the near future , please contribute us for the best user experience