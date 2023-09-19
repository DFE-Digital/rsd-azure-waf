# WAF Rule Exclusion: HTML Input Fields that contain URLs
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

The Prepare Conversions service has a HTML Form input value that is used as a redirect/callback URL. The link is
considered off-domain because the origin of the link does not match the FQDN of the service.

This triggers rule `931130` (Possible Remote File Inclusion (RFI) Attack: Off-Domain Reference/Link) which blocks the
form POST request.

This is considered a false positive because the service is expecting off-domain URLs to be included in the form data

## Decision
_What is the change that we're proposing and/or doing?_

- Add a WAF Rule exclusion for HTTP Request argument names that match known Form Input names that are expected to include
links to off-domain URLs.

## Consequences
_What becomes easier or more difficult to do because of this change?_

Form submissions can now be successfully POSTed if they include off-domain URLs in the `return_to` form field inputs.
