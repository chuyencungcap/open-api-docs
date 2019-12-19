# API Guides

## Create new product request

Why is it still a request ? Because Tiki need to take a look , we have to review your product data , document , ...  both automatically and manually before bring product to the shelves.

TIKI will update your request status step by step. Once the status become approved , your product will be displayed in TIKI website immediately. 

Before creating product, please refer to these following link:
1. Authentication
2. TIKI 's product structure
3. TIKI 's product request status flow

Alright, you can create products on TIKI easily by following these steps :
1. Search TIKI categories using this endpoint → map with your original category
    - you can search categories by keyword like this or maybe travel over categories tree like this until you got a primary category because product must be in exactly one category
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
    - save the category_id to use it later
2. Get attribute from category you chosen → map with your original attribute
    - visit category detail to see its attributes like this : [https://api.tiki.vn/integration/v1/categories/20768](https://api.tiki.vn/integration/v1/categories/20768)
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

    - each category have some required attribute like `brand` . You have to complete this field base on our example . The last choice if you still not have any idea , you can fill some dummy data like "updating" because your product request will be reviewed by TIKI content
    - if you can't find some important attribute in your side but TIKI don't have, please contact TIKI supporter , we will add them into the list while we developing **create attribute endpoint**
3. Choose your inventory_type from here then ask TIKI supporter to get your supplier
4. Create product via endpoint . There are some important point need to focus please visit TIKI product structure for more detail : 
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
5. If you want to create a configurable product , please  data in option_attributes and option1,option2 field. Maybe your payload will look like this . In this case, of course your variants  : 
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
6. Some common error while create product 
    - missing supplier → supplier is a constant present for the location of your storage → please contact TIKI supporter to get this while **develop a create supplier endpoint**
    - option_attributes → TIKI support update 2 option attributes so if you need more than 2 option , please merge some of them before create product
    - missing required attribute → try to map attribute → fill dummy data like "updating"
    - image error → TIKI support image at 500x500 px at least for the best UI/UX → so please resize your invalid image if you don't want to miss them

## Tracking created request

After TIKI received your product request then you can trace its current status by the trace_id we gave you in the http response here
```json
{
    "id": "3385dfc74f3e4a6bb947766c6e9a742f",
    "state": "queuing"
}
```
When your product state is queuing , it means your request just received . You can refer request status flow here. 

- note that **drafted** is a temporary state only appear in test environment . In production your request will be redirected directly into **awaiting_approve** . Your task finish once request 's state become drafted/awaiting_approve
- while your request is on flow , it maybe become **rejected** by some reason , please check it
- if you want to close your request , use delete request endpoint to force request 's state into **deleted**

At first your request is checked automatically, you can track it by these method : 

1. Track the latest request ( include queuing , processing request )
2. Track a request using **trace_id** in create product response

After that, your request is sent to the other queue to check manually, in this phase beside the methods listed above , you can try these 

1. Query the latest request ( exclude queuing , processing request )
    - you can include product_info here
    - you can filter by state ( rejected , deleted , approved , ... )
2. Query a request by **request_id** from TIKI system
