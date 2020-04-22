# API Changelog
*  24/04/2020: Add support update product active, price, quantity by product id
*  10/04/2020: Add support to create mock order for testing on sandbox.
*  05/03/2020: Add filter create_from_date & create_to_date filter for product API
*  04/03/2020: Add get seller information API
*  04/03/2020: Add quantity to get product detail API
*  26/02/2020: Allow every integration request to bypass drafted state automatically
*  12/02/2020: Add update market_price , image , images API
    * Add update method
    * Add tracking method
*  07/02/2020: Add filter create_from_date & create_to_date filter for order API
*  06/02/2020: Add fee to order detail when order status is completed
*  10/01/2020: Add master_id , master_sku in get request,product API 
*  06/01/2020: Add mock order method in sandbox environment
*  02/01/2020: Add replay method for product request
*  26/12/2019: Return request_id & reason in tracking method
*  17/12/2019: Add manage product request method
*  04/12/2019: Add inventory_type logic
*  26/11/2019: Add field handling_fee, shipping_fee, inventory_type
*  22/11/2019: Add updateDeliveryStatus endpoint
*  12/11/2019: Add field coupon, discount in orders endpoint
*  07/11/2019: Add tracking_number for confirmItems endpoint
*  31/10/2019: Add filter parameter for warehouse endpoint
*  28/10/2019: Add order endpoint
*  15/10/2019: Add update sku method
    * Support update price , quantity , active of approved product
    * Each variant can have its own market price now
*  14/10/2019: Add create new product endpoint
*  07/10/2019: Add rate limit for API
*  23/09/2019: Add information method
