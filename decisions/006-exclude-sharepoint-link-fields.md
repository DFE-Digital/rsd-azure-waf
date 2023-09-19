# WAF Rule Exclusion: HTML Input Fields that contain URLs
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

Some services have HTML Form inputs that ask users to include links to SharePoint folders/files. The links are
considered off-domain references because the origin of the link does not match the FQDN of the service.

This triggers rule `931130` (Possible Remote File Inclusion (RFI) Attack: Off-Domain Reference/Link) which blocks the
form POST request.

Additionally, the URL itself can occasionally trigger rules:

- `942450` # SQL Hex Encoding Identified
- `942210` # Detects chained SQL injection attempts 1/2

This is considered a false positive because the service is expecting off-domain URLs to be included in the form data,
and furthermore the user is prompted to only supply links to SharePoint URIs by the labelling and guidance in the form.

## Decision
_What is the change that we're proposing and/or doing?_

- Add a WAF Rule exclusion for HTTP Request argument names that match known Form Input names that are expected to include
links to off-domain URLs.
- WAF Rule exclusion for `942450` and `942210` to match the same HTTP argument names

## Consequences
_What becomes easier or more difficult to do because of this change?_

Form submissions can now be successfully POSTed if they include off-domain URLs in the SharePoint form field inputs.
