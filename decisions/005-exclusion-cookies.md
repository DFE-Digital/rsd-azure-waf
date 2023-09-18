# WAF Rule Exclusion: Trusted Cookies
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

A number of cookies in use across our services have tokenised values that contain character patterns that may
inadvertently match SQLi patterns within the Managed WAF rule sets. When requests that set these cookies are blocked,
functionality of the service becomes impeded or the user experience suffers, e.g. user session data is lost.

The following rules have been identified as generating false positives:

- `942440` # SQL Comment Sequence Detected.
- `942450` # SQL Hex Encoding Identified
- `942210` # Detects chained SQL injection attempts

## Decision
_What is the change that we're proposing and/or doing?_

- Create exceptions to the above listed Managed WAF Rule IDs for traffic that contains specific, known cookie names.
- Traffic matching these requirements must be excluded from the evaluation of the above rule IDs.
- All other WAF Rules will continue to be evaluated against matching traffic.

## Consequences
_What becomes easier or more difficult to do because of this change?_

End user functionality is restored and cookies can be set as expected
