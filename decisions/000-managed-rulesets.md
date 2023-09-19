# Managed WAF Rule Sets
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

A number of HTTP requests are hitting our services and we need to implement a WAF Policy. Azure offer managed rule sets
that we would like to leverage so that we do not need to write our own rules. The Azure Managed Rule sets offer much
more control and more elaborate filtering patterns to protect our apps against common attack vectors or software
vulnerabilities.

## Decision
_What is the change that we're proposing and/or doing?_

- Enable the `OWASP 3.2` Managed rule set
- Enable the `Microsoft_BotManagerRuleSet 1.0` Managed rule set

## Consequences
_What becomes easier or more difficult to do because of this change?_

The WAF will be able to log traffic patterns that match the managed rule sets, giving us greater visibility into what
public web traffic is being sent to our services.

With the WAF in 'Prevention' mode, can expect a larger proportion of requests to be blocked. This may include false
positives which we will need to carefully monitor and write exclusions for.
