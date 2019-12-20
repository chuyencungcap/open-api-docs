## Confirm an order

After customer place an order , seller have to send a confirm request to make sure your product is still available. This is a important step before delivery product to customer so please confirm it as soon as possible 

### 1. Query list order periodically to find new order to [confirm](#get-list-orders)

```json
{
    "data": [
        {
            "order_code": "554520865",
            "coupon_code": null,
            "status": "queueing",
            "total_price_before_discount": 200000,
            "total_price_after_discount": 200000,
            "updated_at": "2019-12-19 15:38:23",
            "purchased_at": "2019-12-19 15:38:23",
            "fulfillment_type": "tiki_delivery",
            "note": "",
            "deliveryConfirmed": "",
            "is_rma": null,
            "warehouse_id": 4,
            "tax": {
                "code": null,
                "name": null,
                "address": null
            },
            "discount": {
                "discount_amount": 0,
                "discount_coupon": 0
            },
            "shipping": {
                "name": "hoa nguyễn",
                "street": "ewewq",
                "ward": "Phường An Lợi Đông",
                "city": "Quận 2",
                "region": "Hồ Chí Minh",
                "country": "VN",
                "phone": "",
                "email": "",
                "estimate_description": "Dự kiến giao hàng vào Thứ hai, 23/12/2019",
                "shipping_fee": 0
            },
            "items": [
                {
                    "id": 25278755,
                    "product_id": 2090562,
                    "product_name": "Backorder 100",
                    "sku": "3685812177996",
                    "original_sku": "",
                    "qty": 1,
                    "price": 200000,
                    "confirmation_status": "waiting",
                    "confirmed_at": "",
                    "must_confirmed_before_at": "2019-12-20 10:38:00",
                    "warehouse_code": null,
                    "inventory_type": "instock",
                    "serial_number": [],
                    "imei": []
                }
            ],
            "payment": {
                "payment_method": "cod",
                "updated_at": "2019-12-19 15:38:23",
                "description": "Thanh toán tiền mặt khi nhận hàng"
            },
            "handling_fee": 0,
            "collectable_total_price": 200000
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

### 2. Each order have 1 or more items to confirm where they are
### 3. After that you use [Get warehouse endpoint](#get-warehouses) to see the list warehouse you registered before. If you don't see any match warehouse you can add the new one via **add warehouse endpoint**  or tell us to add it manually

```json
{
  "warehouse_id": 2,
  "contact_email": "adad@gmail.com",
  "contact_name": "Nguyễn",
  "contact_phone": "0932829435",
  "country": {
    "code": "vn",
    "name": "Viet Nam"
  },
  "district": {
    "code": "VN034025",
    "name": "Quận Hoàng Mai"
  },
  "name": "Nguyễn Lam",
  "region": {
    "code": "VN034",
    "name": "Hà Nội"
  },
  "seller_inventory_id": 809,
  "street": "52, Út Tịch",
  "ward": {
    "code": "VN034025005",
    "name": "Phường Hoàng Văn Thụ"
  },
  "warehouse_code": "hn"
}
```        

### 4. Via [confirm order endpoint](#confirm-order-items) , please tell us which **seller_inventory_id** and **warehouse_code** your products are stored . Note that we need to confirm available item only , if your product is out of stock , please send a confirm request with empty **item_ids**

```json
{
  "order_code": "931380328",
  "warehouse_code": "hn",
  "seller_inventory_id": 885,
  "item_ids": [25275169],
  "delivery_commitment_time":"2019-12-23 23:59:59",
  "tracking_number": "931380328"
}
```
      
## Update delivery status

If your order is **tiki_delivery** congratulation , after you confirm order items, TIKI will help you complete this order.

If your order is **seller_delivery** you still have one more steps to complete this order. You have to [update delivery status](#api-update-delivery-status) step by step whenever you reach a new status in this list 

```json
{
    "order_code": "401734337",
    "status": "successful_delivery"
}
```

Finally, your order delivery status becomes successful delivery, everything is settled.

## Print order label

Sometime while making an order , you may need to [print order label](#print-order-labels). We provide a method to do it.

![https://salt.tikicdn.com/ts/docs/3f/03/bd/6b9f2046f09d7b030c64f032a4f5d7e4.png](https://salt.tikicdn.com/ts/docs/3f/03/bd/6b9f2046f09d7b030c64f032a4f5d7e4.png)