PayFit uses conventional HTTP response codes to indicate the success or failure of an API request. In general:

- Codes in the `2xx` range indicate success.
- Codes in the `4xx` range indicate an error that failed given the information provided (e.g., a required parameter was omitted, missing authentication, etc...).
- Codes in the `5xx` range indicate an error within our servers. We will do our best to so that it never happens 😇.

💡 Please refer the openAPI specification for more details about errors on the endpoints.
