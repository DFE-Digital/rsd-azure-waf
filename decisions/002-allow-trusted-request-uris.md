# Custom WAF Rule: Trusted Request URIs
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

Services that use Microsoft Single Sign-On have to register a callback URI in their App Registration configuration.
This callback URI is where users are redirected to after successfully completing a sign-in flow on microsoft.com.

As this URI receives `POST` data along with query fragments, it's important to ensure the traffic does not get
intercepted by WAF Rule evaluation as it can interrupt the login flow and break user sessions.

## Decision
_What is the change that we're proposing and/or doing?_

- Create a Custom WAF Rule that identifies traffic that is accessing known OIDC callback URIs
- If traffic matches this request path, the behaviour must be set to `Allow` and no further rule evaluations
must take place.

At the time of writing there are only 2 URI formats that we need to consider for this custom rule

## Consequences
_What becomes easier or more difficult to do because of this change?_

- Traffic to these known endpoints will no longer be evaluated against other WAF Rules
