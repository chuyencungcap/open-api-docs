## Seller API

If it is the first time you come to integrate with us, please take a look at our [tutorial documents](#api-integration-step-by-step) first
This is a [sample postman collection](https://documenter.getpostman.com/view/7737371/SWLZfqJ9?version=latest) that lists all the APIs we support

The table below lists APIs that can be used for product management.

| API name | Description
| -------- | -----------
| [Get seller](#get-seller) | Return your seller information
| [Update can update product setting](#update-can-update-product-setting) | Update the can_update_product setting


### Get seller
#### HTTP Request ####

```html
GET https://api.tiki.vn/integration/v1/sellers/me
```

```json
{
    "sid": "11047E39EC3D534013C587D207584D454B01C65",
    "name": "Sushi shop",
    "logo": "http://uat.tikicdn.com/ts/seller/8e/25/1b/ac9d0bd1f30f721d198ad37a519ffb9a.png",
    "active": 1,
    "can_update_product": 1,
    "registration_status": "completed"
}
```

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>https://api.tiki.vn/integration/{version}/sellers/me</h6>
	</div>
</div>

Return your seller information in the system.


#### Header

| Key | Description
| --- | -----------
| tiki-api | seller token key (contact Tiki supporter)


#### Response

| Field | Type | Example | Description
| ----- | ---- | ------- | -----------
| sid | String | 11047E39EC3D534013C587D207584D454B01C65 | The unique id of a seller
| name | String | Sushi shop | The name of seller
| logo | String | [logo URL](http://uat.tikicdn.com/ts/seller/8e/25/1b/ac9d0bd1f30f721d198ad37a519ffb9a.png) | The seller logo URL
| active | Integer | 1/0 | Your store is active/not active on TIKI
| can_update_product | Integer | 1/0 | Your account can/cannot update products via API   
| registration_status | String | completed | State of registration process


**Registration status:**

* null - Direct created seller account. Doesn't have registration data.
* draft - Finish created account
* waiting - Submitted contract. Waiting for KAM (Key Account Manager) confirm the contract
* seller_supplementing - Waiting for seller update contract
* kam_rejected - KAM rejected the contract. 
* completed - The contract get approved.

Currently, after the contract gets approved. Seller will receive an e-contract to sign and send it back to Tiki.
KAM will review if everything is good, then KAM will turn on your store. Then you ready to sell on Tiki.

![registration_flow](https://salt.tikicdn.com/ts/files/6a/60/9c/6b2f8b18f98a02c32279094a3fb45d92.png)


#### Exception Case

| HTTP Code | message | Description
| --------- | ------- | -----------
| 500 | Internal server error | having error in server, can't serving


------------------------------------------------------------------------------------------------------------------------
### Update can update product setting
#### HTTP Request ####

```html
POST https://api.tiki.vn/integration/v1/sellers/me/updateCanUpdateProduct
```

> Request body

```json
{
	"can_update_product": 0
}
```

> Response body

```json
{
    "message": "success"
}
```

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>https://api.tiki.vn/integration/{version}/sellers/me/updateCanUpdateProduct</h6>
	</div>
</div>

Change setting `can_update_product` for your account. The setting is turn on/off the permission to update products via 
API

#### Header

| Key | Description
| --- | -----------
| tiki-api | seller token key (contact Tiki supporter)


#### Request body

Name | Type | Mandatory | Example | Description
---- | ---- | --------- | ------- | -----------
can_update_product | Integer | Y | 1/0 | 1 for enable, 0 for disable


#### Response body

Field | Type | Example | Description
----- | ---- | ------- | -----------
message | String | message | Success change the setting


#### Exception Case

HTTP Code | Message | Description 
--------- | ------- | -----------
500 | Internal server error | Having error in server, can't serving
400 | Bad request | Request not valid, check error message
401 | Unauthorized | Your tiki-api token is not valid
429 | Too Many Requests | Your rate limit is exceed
