# APIs examples

This directory holds OpenAPI & AsyncAPI contract file examples for
“standalone” APIs (single contract file) which are deployed to
[bump.sh](https://bump.sh) to generate elegant and always up-to-date
API documentation.

The files are automatically deployed to Bump.sh:

- Bump official documentation: https://developers.bump.sh/
- Twitter API v2 documentation: https://bump.sh/demo/doc/twitter-api-v2
- Payfit Partner API documentation: https://bump.sh/demo/doc/payfit-partner
- Intercom API documentation: https://bump.sh/demo/doc/intercom
- Clever-Cloud API documentation: https://bump.sh/demo/doc/clever-cloud
- Pipedrive API documentation: https://bump.sh/demo/doc/pipedrive
- Greenly API documentation: https://bump.sh/demo/doc/greenly

## How to add an API here?

In order for the spec files to be deployed automatically you need to follow the following file naming convention:

```
<bump-doc-slug>-[openapi|asyncapi]-source.[json|yml]
```

You also need to add a Bump.sh token in the `.github/workflows/bump.yml` file, the variable key name also needs to be of the form `<BUMP_DO_SLUG>_BUMP_TOKEN`. Then add the token value in the [Github secrets of the current repo](https://github.com/bump-sh/examples/settings/secrets/actions), of course.
