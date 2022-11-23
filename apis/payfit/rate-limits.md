The number of call to the PayFit partner API is limited per client application (and not by valid access_token).

If any of the limits configured is being reached, the API will return a 429 status code with the following JSON body:

```json
{ "message": "API rate limit exceeded" }
```

Don't worry, we will send some additional headers back to you telling what are the limits allowed, how many requests are available and how long it will take until the quota will be restored, for example:

```
RateLimit-Limit: 6
RateLimit-Remaining: 4
RateLimit-Reset: 47
```

We will also send headers telling the limits in the time frame and the number of requests remaining:

```
X-RateLimit-Limit-Minute: 10
X-RateLimit-Remaining-Minute: 9
```

or it will return a combination of more time limits, if more than one is being set:

```
X-RateLimit-Limit-Second: 5
X-RateLimit-Remaining-Second: 4
X-RateLimit-Limit-Minute: 10
X-RateLimit-Remaining-Minute: 9
```

💡 We strongly suggest that you handle this error and a add a "wait and retry" mechanism.
