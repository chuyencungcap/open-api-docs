
# Authentication and Authorization

At the moment we only support client type `confidential` as described in The OAuth 2.0 Authorization Framework [#section-2.1](https://tools.ietf.org/html/rfc6749#section-2.1). Therefore, in order to integrate with our Authorization Code Flow, you will need to 

* Build a *client app* with both *frontend* and *backend*
* The frontend will be in charged of requesting users' consent
* The backend will be in charged of keeping the client credentials (a.k.a client_id/client_secret pair) to request tokens from our token endpoint

## Recommendation

We strongly recommend your team not to write your own code to interact with OAuth 2.0. Use open source & battle-tested libraries instead. Here are some examples:

* NodeJS
  * [passport](http://www.passportjs.org/)
  * [simple-oauth2](https://github.com/lelylan/simple-oauth2)
* Golang
  * [golang/oauth2](https://github.com/golang/oauth2)
* PHP
  * [oauth2-client](https://github.com/thephpleague/oauth2-client)
* Java
  * [Spring Security](https://spring.io/projects/spring-security)

For a full list of client libraries go [here](https://oauth.net/code/). If you still want to do that on your own, follow the next section carefully.

## Integration flow

### 1. Ask user to start the flow

Your frontend will ask the user (i.e. seller) to allow access to user's data in Tiki System (for your client app to manage their store).

### 2. Start the flow

If user accepts the request, `redirect` user agent (i.e. the browser) to our [/sc/oauth2/auth](/sc/oauth2/auth) endpoint

> Http request to authorization endpoint

```
GET /sc/oauth2/auth HTTP/1.1
Accept: application/json
Host: https://api-sandbox.tiki.vn/
```

* **Authentication**: `None`
* **Query components**:
  * `response_type` Must be `code`
  * `client_id` Your Client Id
  * `redirect_uri` Your registered redirection URI
  * `scope` The scope you want to request from user
  * `state` Some random string for security reason
 
> Query component example

```
?response_type=code&client_id=f8es8ejks9aed8ok&redirect_uri=http%3A%2F%2Fyour.registered.redirection.uri&scope=offline%20all&state=RJvROw5fLpM2OaTs
```

* Remember to url-encode all the query components

See [Authorization Request](https://tools.ietf.org/html/rfc6749#section-4.1.1) for more details. Right now we did not define concrete scopes, therefore we accept scope `all` along with `openid` and `offline`. 

* `all` means you are requesting access to all resources of the authorizing seller
* `all` does NOT include `openid` and `offline`
* `offline` is neccessary for your client app to obtain a `refresh_token`.

### 3. User login and allow/deny your access requests on Tiki

User will be authenticated against our system (Tiki) and be asked to grant your client app access rights. *No action required on your side*.

### 4. User agent is redirected back to your client app

After [Login & Consent](#3-user-login-and-allowdeny-your-access-requests-on-tiki) has completed, our system will redirect user agent back to the `redirect_uri` that your app specified above.

> If user allows, your system will receive these components

```
?code=wwxdZmftI2r0Xn5gbwXmd3mVjQCeWxh7RHDs5_OaNSI...&scope=offline all&state=RJvROw5fLpM2OaTs
```

* If user allows, the redirection URI has these parameters in the query component:
  * `code` parameter will be used to **request for tokens**
  * `scope` parameter contains all the **authorized scopes** for your client app
  * `state` parameter for security reason

> If user denies, your system will receive these components

```
?error=access_denied&error_code=403&error_hint=User denied the access request...
```

* If user denies, the redirection URI has these parameters in the query component:
  * `error` is the error name
  * `error_code` represents the error status code (404, 403, 401, ...).
  * `error_hint` contains further information on the nature of the error.

User agent will then send the request to your backend at `redirect_uri`. Your `backend` should be able to handle above redirection URI and recognize the query component.

### 5. Ask for tokens

> Example token request

```
POST /sc/oauth2/token HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Accept: application/json
Host: https://api-sandbox.tiki.vn/
```

Then your `backend` will ask for tokens by performing a POST to our [/sc/oauth2/token](/sc/oauth2/token) endpoint with `x-www-form-urlencoded` body.

> Example token request authorization header for
> client_id = e5edc0e43g3zb6c3
> client_secret = xNTZVvEn5WwA_esLe_laIWlXyISGjTfO

```
Authorization: Basic ZTVlZGMwZTQzZzN6YjZjMzp4TlRaVnZFbjVXd0FfZXNMZV9sYUlXbFh5SVNHalRmTw==
```

* **Authentication**

  * Required
  * At the moment, we only support BasicAuth in request header

* **Body** - You need to send the following `required` parameters

  * `grant_type` Must be `authorization_code`
  * `code` The `code` parameter you received from the [redirection](#4-user-agent-is-redirected-back-to-your-client-app)
  * `redirect_uri` Your registered redirection URI
  * `client_id` Your Client Id

> Example token request body

```
grant_type=authorization_code&code=wwxdZmftI2r0Xn5gbwXmd3mVjQCeWxh7RHDs5_OaNSI...&redirect_uri=http%3A%2F%2Flocalhost%3A8080&client_id=kiotviet
```

* **Response** - You will get the following
  * `access_token` The token for later authorization
  * `expires_in` Token time-to-live in `seconds`
  * `id_token` 
  * `refresh_token` The token to be used with `refresh_token` grant type
  * `scope` Authorized scopes (i.e. user-granted scopes)
  * `token_type`

> Example token request response

```json
{
    "access_token": "4wx_Zpe_VVkZ2oka8pFSeeRt8C_sJNIucA7oIDcsl5g.8IPUATsK2TcxmOPE4zF5OasGJerD8BEIQ...",
    "expires_in": 3600,
    "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6InB1YmxpYzpkMzJjNjIxOC00NWIwLTQ1MWQtOTRlNS1lOWFkNz...",
    "refresh_token": "IJGpF1yHr35VeKuqB81jBKOmacbgYfEjOLgHWl6q0qw.MK_3Rxo_OJWPRZ0S_Q2zGzJuxFu2vIHUE...",
    "scope": "offline all",
    "token_type": "bearer"
}
```

See [Token Endpoint](https://tools.ietf.org/html/rfc6749#section-3.2) for more details.

From now your `backend` can use the `access_token` to perform BearerAuth when calling Tiki. This `access_token` is supported by the following APIs:

* Open API

Again, `refresh_token` is only returned if you requested for scope  `offline` when initiating this flow. 

### 6. Refresh token

> Example refresh token request body

```
grant_type=refresh_token
refresh_token=IJGpF1yHr35VeKuqB81jBKOmacbgYfEjOLgHWl6q0qw.MK_3Rxo_OJWPRZ0S_Q2zGzJuxFu2vIHUE...
redirect_uri=http://your.registered.redirection.uri/
client_id=your_client_id
```

When your `access_token` is expired, use the `refresh_token` to get a new one.
You  need to make a request to token endpoint. Almost the same as [Ask for tokens](#5-ask-for-tokens), except for the body.

* Replace `grant_type=code` by `grant_type=refresh_token`
* Replace `code=...` by `refresh_token=your.last-received.refresh-token`
