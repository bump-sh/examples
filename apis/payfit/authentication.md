# Overview

PayFit APIs can be compared to arcade games. What do they have in common? You'll need a token.

Like the pinball machines, PayFit API endpoints don't let just anyone play. In an arcade, your token proves you obtained permission to play. In your PayFit app, your token proves that your app has obtained permission to call an API method.

Whenever you build an app, you'll start by obtaining an access token.

## 1️⃣ Become a PayFit Partner

To become a PayFit partner you will need to **ask PayFit for credentials**, we only give API credentials to our approved partners.

A registered app is assigned a unique Client ID and Client Secret which will be used in the OAuth flow. The Client Secret should not be shared.

We will ask for some basic information :

- the name of your company
- the scopes you will need
- the url where we should redirect the user when he will install your PayFit app
- Your app logo in svg or png format (in a square of 256px size)


## 2️⃣ Implement Oauth to gain access to the API on behalf of users.

Implement the [oauth flow](#topic-oauth).

## 3️⃣ Discover the API

Check the PayFit API.

# Oauth

## Generate an access token with the oAuth flow

OAuth 2.0 is a protocol that lets your app request authorization to
private details of a PayFit customer without getting their password.
It's also the way by which PayFit apps are installed on a customer
account.

Your app asks for specific permission scopes and is rewarded with access
tokens upon a user's approval. The OAuth flow is your key to unlocking
access tokens. There's no path to programatically create or retrieve
app access tokens without a user's input.

This flow is meant for server-to-server communication.

------------------------------------------------------------------------

### Step 1: Create a button on your app to make the PayFit user grant access to your app


The first step is a PayFit admin user authorizing your application to
access their information on PayFit. You have to create a link to PayFit
where they can approve access, with the following GET parameters:

-   `client_id`:
    the client ID we gave you when we have established our partnership
-   `redirect_uri`:
    encoded url you submitted when we have established our partnership.
    If the user accept integration, the user will be returned to this
    url with the code parameter set to the authorization \> code.
-   `response_type`: the string `"code"`
-   `state`:
    unique string to be passed back upon completion (optional).It should
    be used to avoid forgery attacks by passing in a value that's
    unique to the user you're authenticating and checking it when auth
    completes.
-   `scope`:
    a comma-separated list of OAuth scopes, indicating which parts of
    the PayFit API you'd like your app to be able to access.

The link should contain the parameters outlined above. For this sample
application, the link would look something like this:

```html
<a href=https://oauth.payfit.com/authorize?redirect_uri=https%3A%2F%2Fmy-awesome-website.com%2Foauth&client_id=<your_client_id>&response_type=code&scope=<your_app_scopes> >Integration with PayFit </a>
```

When clicking on that link, the user will be prompted to log in to their
PayFit admin account and authorize the integration with your application
for one of their companies.

![](https://developers.payfit.com/static/oauth-example-3a865fa9e143f9a0c8b4defc25b80840.png =400x)

------------------------------------------------------------------------

### Step 2 - Users are redirected to your server with a verification code


After accepting, PayFit will generate an authorization code and the user
will be redirected to the `redirect_uri` with:

-   a code as a query parameter that you will use to obtain your first
    access token.
-   a `state`
    parameter if you provided one in the previous step. If the states
    don't match, the request may have been created by a third party and
    you should abort the process.

In the previous example, the user will be sent to a url like this:

`https://my-awesome-website.com/oauth?code=<a_useful_code>`

------------------------------------------------------------------------

### Step 3 - Exchanging a verification code for an access token

Now you can make a server-side `POST`
request to PayFit with your authorization code to
<https://oauth.payfit.com/token> with the following body:

-   `client_id`:
    your client id, used to identify your application
-   `redirect_uri`:
    same uri as before, used to identify your application
-   `code`:
    the code you received in the previous step
-   `client_secret`:
    a secret you were given when we established the partnership
-   `grant_type`:
    the string `"authorization_code"`,
    it is the type of code included.


This will return the following json payload:

```json
{  "access_token": "your_secret_token",  "token_type": "bearer"}
```

Congratulations 👏, you have now a valid `access_token`
you can use to authenticate your requests for a given company! This
token lifetime is unlimited, but will be revoked if the user uninstalls
your application from the PayFit app.

------------------------------------------------------------------------

### Step 4 - Store the token and it's corresponding PayFit company_id

Your `access_token`
is valid for the company of the user who completed the oAuth flow, you
can find the information related to the token in the introspection
endpoint `POST https://oauth.payfit.com/introspect`.

```curl
curl -X POST
  https://oauth.payfit.com/introspect
  -H 'Authorization: Bearer your_secret_token'
  -H 'Content-Type: application/json'
  -d '{ "token": "your_secret_token" }'
```

will return a JSON response with the company\_id.:

```json
{  "active": true,  "scope": "scope1 scope2",  "client_id": "your client id",  "company_id": "the_company_id",  "token_type": "bearer"}
```

Simply add the header `Authorization`
with the value `Bearer your_secret_token`
on all your requests to call the API.

You are now ready to make your first request to the API:

```curl
curl -X GET
  https://partner-api.payfit.com/companies/the_company_id
  -H 'Authorization: Bearer your_secret_token'
```

------------------------------------------------------------------------

## Handling access tokens

-   For each PayFit company, the PayFit company admin has to generate a
    different `access_token`
    that you should store in your database. You can use this token
    whenever you need to access the API on behalf of that company. You
    should store it in a database and make sure it is secured. If you
    lose the access token of a company, your user will have to perform
    again the oAuth flow so you can get another one.

-   If a customer has multiple subsidiary companies in PayFit, each
    subsidiary company should have it's own access token.

-   We allow only one token per company at a time. Generating a new
    token will invalidate all other tokens for the same company.

-   The access token won't expire, that is why we don't provide a
    `refresh token`
    that would allow to renew it. If in the future we have to introduce
    a breaking change, we will make sure you will be warned in advance.

-   If for some reason you want some access token invalidated, you can
    ask your user to re-generate another access token by replaying the
    oAuth flow.

-   The `company_id`
    corresponding to an `access_token`
    can be retrieved anytime using the oAuth introspect endpoint (see
    [Step 4](#step-4---store-the-token-and-its-corresponding-payfit-company_id))

# Scopes


OAuth scopes let you specify exactly what your PayFit app can access on a PayFit user's account. As a PayFit app developer, you specify your desired scopes in the initial OAuth authorization request. When a user is responding to your OAuth request, the requested scopes will be displayed to them when they are asked to approve your request.

## Scopes list

- `contracts:read`: List the employees contracts of a given company.
- `collaborators:securite-sociale:read`: Deprecated. Use `collaborators:social-security:read` instead.
- `collaborators:read`: Read general information of collaborators.
- `collaborators:contracts:read`: Read contract information of collaborators.
- `collaborators:management:read`: Read information about organisation and management.
- `collaborators:personal:read`: Read personal data of collaborators.
- `collaborators:social-security:read`: Read the social security identifiers of collaborators.
- `accounting:read`: Read the accounting data.
