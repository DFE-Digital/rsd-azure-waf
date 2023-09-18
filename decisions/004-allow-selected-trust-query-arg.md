# Custom WAF Rule: Trusted query string arguments
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

There is a school called `Plymouth Cast`. When this is supplied in a `GET` request along with specific query arguments,
it is typically capitalised to `PLYMOUTH CAST`. The word `CAST` is a known SQL function so can trip the Managed WAF
rules for SQL Injection detection.

This is a false positive, and requests that include this specific value in the query string should not be evaluated
against the SQLi rules.

## Decision
_What is the change that we're proposing and/or doing?_

- Create a Custom WAF Rule that identifies HTTP `GET` requests that contain the specific query argument and a
value that contains the word `CAST`
- If these selectors exist in a request, the behaviour must be set to `Allow` and no further rule evaluations
must take place.

## Consequences
_What becomes easier or more difficult to do because of this change?_

- Traffic containing these GET arguments will no longer be evaluated against other WAF Rules
