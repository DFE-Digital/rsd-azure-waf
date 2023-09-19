# Change action to 'Log' for SQLi Rules
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

The following Rule IDs have weighted anomaly scores which means that each time the pattern is tripped, a number is
tallied. If that rule is tripped multiple times and the tally exceeds a set threshold of severity, the request is
blocked by the WAF. This is done to reduce the number of false positives.

- `942420`
- `942421`
- `942430`
- `942431`
- `942432`

There is a strong discussion on [GitHub](https://github.com/SpiderLabs/owasp-modsecurity-crs/issues/317) where engineers
are highlighting the false positive rate with these weighted rules.

Notably;
>The first two rules, 'SQL Injection Character Anomaly Usage' 942420/942430 (old ids: 981173/981172), are some of the
>most controversial rules in CRS2 (in my opinion). They cause a lousy user experience due to very high false positives
>in many web applications. So we should think carefully what to do with them.

In our WAF Logs we are seeing a considerable number of requests getting blocked by these rules, of which we have
determined to be false positives.

## Decision
_What is the change that we're proposing and/or doing?_

Add a WAF Rule override for the 'Action' of the following WAF Rule IDs to 'Log' instead of 'Anomaly'

- `942420`
- `942421`
- `942430`
- `942431`
- `942432`

This means we can still monitor for requests that are hitting this traffic pattern but they wont be blocked.

## Consequences
_What becomes easier or more difficult to do because of this change?_

With the information in the logs we can make further, better educated decisions on excluding traffic with more specific
patterns if we need to.
