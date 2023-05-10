# OpenAPI & AsyncAPI example files

This directory holds [OpenAPI](https://spec.openapis.org/oas/latest.html) & [AsyncAPI](https://www.asyncapi.com/docs/reference/specification/latest) example API contract files for [standalone APIs](https://github.com/bump-sh/examples/tree/main/apis) and [API Hubs](https://github.com/bump-sh/examples/tree/main/hubs) which are deployed to [bump.sh](https://bump.sh) to generate elegant and always up-to-date API documentation.

## View example standalone API contract files and generated documentation

You can find all available examples of OpenAPI and AsyncAPI API contracts files in the [`api` folder of this repo](https://github.com/bump-sh/examples/tree/main/apis)

## View example API contract files for API Hubs and generated documentation

You can find all available examples of Hubs of OpenAPI and AsyncAPI API contracts files in the [`hubs` folder of this repo](https://github.com/bump-sh/examples/tree/main/hubs)

## What are these API contract files ?

Most of them are publicly available API contract files from real tech companies and products.
Bump created and owned API contract files are:
- [Bump ](https://github.com/bump-sh/examples/tree/main/hubs/my-train-company) is Bump.sh [publicly available demo](https://demo.bump.sh/)
- [My train Company](https://github.com/bump-sh/examples/tree/main/hubs/my-train-company) is Bump.sh publicly available demo and has its live generated documentation [available here](https://demo.bump.sh/).

## How to contribute ?

1️⃣ First, fork this repository and pull it on your local machine.
2️⃣ Create a new branch with `git checkout -b <branch-name>`.

### I want to add a **new** standalone API specification file

3️⃣ Create a new file under `./apis/`. Follow this file naming convention:

```
<bump-doc-slug>-[openapi|asyncapi]-source.[json|yml]
```

`bump-doc-slug` must be replaced by your file name.


4️⃣ `git add <path/to/file>` your new API specification file content and `git commit` the file to your new branch.
5️⃣ `git push origin <branch-name>` from your new branch and create a new pull request in this repo.
6️⃣ In the pull request description add a link to the public source of the file.


### I want to update standalone API or Hubs specification files

ℹ️ The only edits allowed are updates of the public specification files to reflect more up-to dates versions of the API contracts.

3️⃣ Locate the file you would like to edit under `./apis/` if Standalone API or repository under `./hubs` if an API portal and proceed with updating the documents.
4️⃣ `git add <path/to/file>` the updated API specification files and `git commit` the files to your new branch.
5️⃣ `git push origin <branch-name>` from your new branch and create a new pull request in this repo.
6️⃣ In the pull request description add a link to the public source of the files.


### Note to maintainers on new APIs specification files

In order for the files to be deployed automatically, we must create a new Documentation or Hub in the Bump demo organization.
The Bump documentation slug must be the same as in the new file name following this naming convention: `<bump-doc-slug>-[openapi|asyncapi]-source.[json|yml]`.
We also need to add a Bump.sh token in the `.github/workflows/bump.yml` file. The variable key name needs to be of the form `<BUMP_DOC_SLUG>_BUMP_TOKEN`.
Then add the token value in the [GitHub secrets of the current repo](https://github.com/bump-sh/examples/settings/secrets/actions).