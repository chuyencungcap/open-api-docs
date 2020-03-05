## Seller API

If it is the first time you come to integrate with us, please take a look at our [tutorial documents](#api-integration-step-by-step) first
This is a [sample postman collection](https://documenter.getpostman.com/view/7737371/SWLZfqJ9?version=latest) that lists all the APIs we support

The table below lists APIs that can be used for product management.

| API name | Description |
| -------- | -------- |
| [Get seller](#get-seller)| Return your seller information |


### Get seller
#### HTTP Request ####
<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/sellers/me</h6>
	</div>
</div>

Return your seller information in the system.

```html
GET https://api.tiki.vn/integration/v1/sellers/me
```

```json
{
    "id": "11047E39EC3D534013C587D207584D454B01C65",
    "name": "Sushi shop",
    "logo": "http://uat.tikicdn.com/ts/seller/8e/25/1b/ac9d0bd1f30f721d198ad37a519ffb9a.png",
    "active": 1,
    "can_update_product": 1
}
```

#### Header

| Key   | Description |
| :--- | :--- |
| tiki-api | seller token key (contact Tiki supporter) |


#### **Response**

| Field | Type | Example | Description |
| :--- | :--- | :--- | :--- |
| id    | String    | 11047E39EC3D534013C587D207584D454B01C65 | The seller id
| name  | String    | Sushi shop | The name of seller
| logo  | String    | [logo URL](http://uat.tikicdn.com/ts/seller/8e/25/1b/ac9d0bd1f30f721d198ad37a519ffb9a.png)    | The seller logo URL
| active    | Integer   | 1/0   | Your account is active/not active on TIKI
| can_update_product    | Integer   | 1/0   | Your account can/cannot update products via API   


#### **Exception Case**

| HTTP Code | message | Description |
| :--- | :--- | :--- |
| 500 | Internal server error | having error in server, can't serving |
