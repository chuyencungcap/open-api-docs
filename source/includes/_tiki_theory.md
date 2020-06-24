# TIKI Theory
## TIKI product structure
Sellers can create **products** to sell on TIKI. A product can be sold by many sellers. Sellers offer their price and quantity for a product on TIKI.

There are two kinds of product at TIKI: simple product and configurable products. 

* **Simple products** are the products that has attributes and only one variant
* **Configurable products** are the products that has many variants.

Configurable products has many variants. Example: an iPhone has many variants differ by colors.

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

With configurable products:

* A configurable product has many **variants** and each variant maybe has its own attribute (examples : name, color...) 
* Variants differ by maximized two attributes. Example: a T Shirt has many variants that differ by color and size
* The attributes that are used to differentiate two variants, are named **option attributes**. Example a T Shirt differ two variants by color and size but a phone differ by RAM & screen size.

## TIKI request status flow
In order for your product to sell on TIKI website, you need to send us your product request. Depend on policy, TIKI need to take a look. Your request may pass some following status:

![](https://salt.tikicdn.com/ts/docs/d4/00/06/b0a89796eb11796a3d38194dde902214.png) 

via tracking api , you can see what is your current request 's status . Here is our full status list :

| State            | Type             | Description                                                |
|------------------|------------------|------------------------------------------------------------|
| queuing          | auto             | request is in queue, waiting for processing                |
| processing       | auto             | request is transforming to tiki format                     |
| drafted          | auto (temporary) | TIKI product request created, ready to review              |
| awaiting_approve | manual           | request waiting for approving, we need to take a look      |
| approved         | manual           | request is approved, product created successfully          |
| rejected         | auto/manual      | request is rejected, use tracking API for more information |
| deleted          | manual           | request is deleted, no more available in system            |

## Category

> category example:

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

Each product must belong to only one primary category in the category tree.

For example: Fashion -> Accessories -> Watches -> Men's watches -> Sports watches

## Attribute

> Attribute example:

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

- Only the primary category has attributes because other categories can't add products, it's so useless to have attributes.
- Each category have some required attribute like `brand` . You have to complete this field base on our example.
- But your side don't have anything to map to these or you still don't have any idea about this then I can give you a small tips.
It is you can complete required attribute with a dummy data like `updating` maybe it can bypass our automate review but I have to warn you if you abuse this TIKI content reviewer may reject your request.  

## Product
> Product example:

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

## Variant

> Variant example:

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



## Inventory type
* inventory_type must be one of below values and have to be in registered list. If you have only 
one **inventory_type**, then that method will be picked up so you can ignore this field in payload

| inventory_type | customer | description |
| :--- | :--- | :--- |
| cross_border | for Global seller | products is transported from abroad |
| instock | for Vietnamese seller | products in TIKI storage, TIKI pack, TIKI deliver |
| backorder | for Vietnamese seller | products in seller storage, TIKI pack, TIKI deliver |
| seller_backorder | for Vietnamese seller | products in seller storage, seller pack, seller deliver |
| drop_ship | for Vietnamese seller | products in seller storage, seller pack, TIKI deliver  |

* If your product have **inventory_type** is **instock** → **supplier** & **quantity** may be absent or will be ignored



## Supplier
Supplier is group of [TIKI's warehouses](#tiki-warehouse), that can transfer your product to (either by TIKI or you). That help TIKI know 
possible warehouses can expected the product transfer to when customers placed order. It can be only one warehouse 
or multiple warehouses depend on you.

<aside class="warning">
    Notes: If seller is abroad (cross_border), you have only one supplier. Please contact TIKI supporter to get this 
    value.
</aside>

Field | Type | Example | Description
----- | ---- | ------- | -----------
id | Integer | 22 | The supplier id, which you can fill in when create product
name | String | HN-SGN | The name of supplier. It is a string combine warehouse codes.



## TIKI warehouse
TIKI warehouses are the physic warehouses of TIKI to store, transfer your products to customer.

Field | Type | Example | Description
----- | ---- | ------- | -----------
name | String | Hà Nội | Name of TIKI's warehouse
code | String | hn | The warehouse code


## Order

Whenever customer place an order, TIKI and seller have to collaborate to delivery the product to customer 
as soon as possible

TIKI have 2 main fulfillment type chosen when seller create product. Each type have a different flow to confirm order 
and deliver product to customer.

* TIKI delivery (tiki_delivery) 
* Seller delivery (seller_delivery)

Via API, we provide some solution to confirm order & update delivery status step by step:

* Query list registered warehouse, specific order 
* Confirm product available status(select warehouse it belong to)
* Update delivery status (for seller delivery) 
* Print shipping order (if needed) 

<table>
  <thead>
    <tr>
      <th style="text-align:left">Field</th>
      <th style="text-align:left">Type</th>
      <th style="text-align:left">Example</th>
      <th style="text-align:left">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left">order_code</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">&quot;239545064&quot;</td>
      <td style="text-align:left">An unique key that auto generated by system</td>
    </tr>
    <tr>
      <td style="text-align:left">coupon_code</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">&quot;123&quot;</td>
      <td style="text-align:left">A coupon code apply for order.</td>
    </tr>
    <tr>
      <td style="text-align:left">status</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">&quot;complete&quot;</td>
      <td style="text-align:left">Order status, see List of <b>Order Status</b> for more details</td>
    </tr>
    <tr>
      <td style="text-align:left">total_price_before_discount</td>
      <td style="text-align:left">Long</td>
      <td style="text-align:left">598000</td>
      <td style="text-align:left">Total order amount before discounts</td>
    </tr>
    <tr>
      <td style="text-align:left">total_price_after_discount</td>
      <td style="text-align:left">Long</td>
      <td style="text-align:left">528000</td>
      <td style="text-align:left">Total order amount after applied discounts</td>
    </tr>
    <tr>
      <td style="text-align:left">updated_at</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">&quot;2019-07-02 18:56:29&quot;</td>
      <td style="text-align:left">Date-time when the order was updated</td>
    </tr>
    <tr>
      <td style="text-align:left">purchased_at</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">&quot;2019-07-02 18:56:29&quot;</td>
      <td style="text-align:left">Date-time when the order was placed</td>
    </tr>
     <tr>
          <td style="text-align:left">delivery_confirmed_at</td>
          <td style="text-align:left">String</td>
          <td style="text-align:left">&quot;2019-07-02 18:56:29&quot;</td>
          <td style="text-align:left">Date-time when the order was success delivery</td>
     </tr>
    <tr>
      <td style="text-align:left">fulfillment_type</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">&quot;cross_border&quot;</td>
      <td style="text-align:left">Order fulfillment types:
        <br />- Seller Delivery orders are fulfillment_type = <b>seller_delivery</b>
        <br
        />- Orders from abroad (Crossborder) are orders with fulfillment_type = <b>cross_border</b>
        <br
        />- Dropship orders directly from the seller (Dropship) are orders with
        fulfillment_type = <b>dropship</b>
        <br />- Tiki Delivery (Tiki Delivery) are orders with fulfillment_type = <b>tiki_delivery</b>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">note</td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">&quot;&quot;</td>
      <td style="text-align:left">delivery note</td>
    </tr>
    <tr>
      <td style="text-align:left">is_rma</td>
      <td style="text-align:left">Integer</td>
      <td style="text-align:left">0</td>
      <td style="text-align:left"> default 0, 1 is return order</td>
    </tr>
    <tr>
      <td style="text-align:left">handling_fee</td>
      <td style="text-align:left">Long</td>
      <td style="text-align:left">0</td>
      <td style="text-align:left">handling fee</td>
    </tr>
    <tr>
      <td style="text-align:left">collectable_total_price</td>
      <td style="text-align:left">Long</td>
      <td style="text-align:left">0</td>
      <td style="text-align:left">amount to be collected from customer</td>
    </tr>
    <tr>
      <td style="text-align:left"><b>discount</b>(*)</td>
      <td style="text-align:left">Object</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">discount info of order</td>
    </tr>
    <tr>
      <td style="text-align:left"><b>tax</b>(*)</td>
      <td style="text-align:left">Object</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">tax information of customer</td>
    </tr>
    <tr>
      <td style="text-align:left"><b>shipping</b>(*)</td>
      <td style="text-align:left">Object</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">shipping info</td>
    </tr>
    <tr>
      <td style="text-align:left"><b>items</b>(*)</td>
      <td style="text-align:left">Array Object</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">list of item</td>
    </tr>
    <tr>
      <td style="text-align:left"><b>payment</b>(*)</td>
      <td style="text-align:left">Object</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">payment info</td>
    </tr>
  </tbody>
</table>

### Discount 

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| discount_amount | Long | 10000 | total amount discount |
| discount_coupon | Long | 10000 | amount discount of coupon |
| discount_tiki_point | Long | 0 | amount discount of tiki point |

-> TIKI point is a currency unit that can be used for payment when buying goods online at TIKI.




### Tax

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| code | String | 1 |  |
| name | String | tax name |  |
| address | String | Ha Noi |  |

### Shipping

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| name | String | "hoàng anh" | Name of order receiver |
| street | String | "58/13  hậu giang" | Street address for order delivery |
| ward | String | "Phường 06" | The ward of delivery address |
| city | String | "Quận 6" | The district of delivery address |
| region | String | "Hồ Chí Minh" | Province, City of delivery address |
| country | String | "VN" | The country of delivery address |
| phone | String | "0784083498" | phone number |
| email | String | "xxx@google.vn" | email address |
| estimation_description | String | Expected delivery on Friday | the delivery info TIKI estimate  |
| shipping_fee | Long | 0 | shipping fee |

## Item (Order item)

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| id | Integer | 90965636 | Identifier of order line item within Tiki seller center |
| product_id | Integer | 12033331 | Product ID within Tiki seller center |
| product_name | String | "Gối Massage Cổ Hình Chữ U Xiaomi LR-S100" | Product name |
| sku | String | 341231234 | Identifier of the product within third-party system, that is added as a field of the product in Tiki system. |
| original_sku | String | "H24071" | Code of the seller SKU within Tiki Seller Center. |
| qty | Integer | 2 | Item quantity in the order |
| price | Integer | 299000 | Sales price of the product in the order |
| confirmation_status | String | "confirmed" | Confirmation status of the order item  |
| confirmed_at | String | "2019-07-03 09:18:08" | The time when the order item was confirmed |
| must_confirmed_before_at | String | "2019-07-03 09:18:08" | Order must confirm before at that time |
| **inventory_type**(*) | String | instock | is product inventory type |
| **discount**(*) | Object |  | discount info of item |

### Payment

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| payment_method | String | "cod" | the payment method of customer |
| updated_at | String | "2019-07-31 14:31:26" | the latest time payment info is updated |
| description | String | "Thanh toán tiền mặt khi nhận hàng" | the detail of payment |

## Order status

| **Value** | **Value-VN** | **Description** | **Description - VN** |
| :--- | :--- | :--- | :--- |
| queueing | cho_in | tiki received | Chờ in |
| canceled | canceled | canceled order | Đã hủy |
| complete | complete | complete order | Đơn hàng đã hoàn thành |
| successful_delivery | giao_hang_thanh_cong | successful delivery | Giao hàng thành công |
| processing | processing | order is being processing| đơn hàng đang được xử lý |
| waiting_payment | doi_thanh_toan | waiting for payment | đơn hàng đợi thanh toán |
| handover_to_partner | ban_giao_doi_tac| handover to partner | đơn hàng đã bàn giao đối tác |
| waiting_payment | doi_thanh_toan | waiting payment | đơn hàng đợi thanh toán |
| closed | closed| closed | đơn hàng đã đóng |
| packaging | dang_dong_goi | packaging | đơn hàng đang được đóng gói |
| picking | dang_lay_hang| picking  | shipper đang lấy hàng |
| shipping | dang_van_chuyen | shipping | shipper đang vận chuyển |
| paid | da_thanh_toan| paid  | đã thanh toán |
| delivered | giao_hang_thanh_cong | success delivery | giao hàng thành công  |
| holded | holded | holded |  |
| ready_to_ship | len_ke| ready to ship | đơn hàng sẵn sàng được giao |
| payment_review | payment_review | payment review |  |
| returned | returned |  | đơn hàng đã được trả |
| finished_packing | dong_goi_xong | finished packing | đơn hàng đã đóng gói xong |

Below is basic order status flows (not all status will be appear, only important ones):

- For tiki-delivery, dropship, cross-border:

![](https://salt.tikicdn.com/ts/files/76/2b/b8/2bbd5e670ec20761466ee75be0dca909.png)

- For seller-delivery:

![](https://salt.tikicdn.com/ts/files/fe/6e/ba/276223e3d9480e8a3447bd94d53f5c82.png)


