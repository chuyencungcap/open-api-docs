
# Seller Registration

## 1. Present the Tiki Seller Registration

You can either embed this registration page into your website or direct user to this registration page. 

* Remember to provide a `callback` parameter, therefore we know where to redirect seller after the registration.
* For example on `sandbox` environment:

    [https://api-sandbox.tiki.vn/icp/sellers/register?callback=https%3A%2F%2Fyour.desired.callback%2Furi](https://api-sandbox.tiki.vn/icp/sellers/register?callback=https%3A%2F%2Fyour.desired.callback%2Furi)

## 2. Handle the callback

After sellers have completed their registration, they will be redirected to the website provided by `callback` parameter, with the registered seller identity:

    [https://your.desired.callback/uri?seller_id=285235&store_name=Their%20Store%20Name](https://your.desired.callback/uri?seller_id=285235&store_name=Their Store Name)

Your server should be able to recognize `seller_id` and `store_name` parameter.