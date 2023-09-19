# Custom WAF Rule: Trusted POST Arguments
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

Tokenised values contained within specific HTTP POST keys can sometimes include patterns that exist in Managed WAF rule
sets causing intermittent `Block` actions to occur. This causes interruption to end users.

## Decision
_What is the change that we're proposing and/or doing?_

- Create a Custom WAF Rule that identifies HTTP `POST` arguments that contain two distinctive selectors
- If these selectors exist in a request, the behaviour must be set to `Allow` and no further rule evaluations
must take place.

We have identified 2 POST argument keys that we can safely permit. They both are expected to contain tokenised data.

## Consequences
_What becomes easier or more difficult to do because of this change?_

- Traffic containing these POST arguments will no longer be evaluated against other WAF Rules
