# Authentication

Before you can interact with the Tiki API, your app must provide the necessary authentication credentials in each HTTP request that it makes to Tiki. In Tiki seller center, the API key is configured for each seller before integrate with the third party system so you must have an account in [https://sellercenter.tiki.vn/](https://sellercenter.tiki.vn/) 

## How to get tiki-api token

1. Visit Tiki Seller Center :
    - [https://sellercenter.tiki.vn/](https://sellercenter.tiki.vn/) if you want to get production api token
    - [https://sandbox-sellercenter.tiki.vn/](https://sandbox-sellercenter.tiki.vn/) if you want to get sandbox api token
2. Register new account ( if this is your first time :D )
3. Login 
4. Look at the top right corner , go to your profile setting 

    ![Authentication/Untitled.png](https://salt.tikicdn.com/ts/docs/9c/38/94/3be3f97e348f50e508f54f29a45731e3.png)

5. Cài đặt bán hàng → Kết nối với kênh bán hàng khác → Tham số kết nối 

    ![Authentication/Screen_Shot_2019-12-17_at_15.23.43.png](https://salt.tikicdn.com/ts/docs/7d/1e/07/45bd75e6a4a62b6919975e740a915ac3.png)

6. Toggle on **Tự động cập nhật SP** then copy value in **Tham số kết nối** column. It's your tiki-api token.
