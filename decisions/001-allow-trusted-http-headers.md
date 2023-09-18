# Custom WAF Rule: HTTP Availability Check
## Status
_What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?_

`accepted`

## Context
_What is the issue that we're seeing that is motivating this decision or change?_

There are a number of WAF log entries that follow repeatable patterns that we know to originate from trusted sources so
want to ensure that there is a sufficient override/bypass rule in place for these types of requests.

These particular requests have a custom HTTP Header that can be one of a list of known values. These Headers are set by
Application Insights for a HTTP Availability Check. The value of this HTTP Header must match the name of the associated
Container App.

If the traffic matches this specific pattern we do not wish to evaluate further WAF rules against it.

## Decision
_What is the change that we're proposing and/or doing?_

- Create a Custom WAF Rule that identifies traffic that is providing the HTTP Header `X-AppInsights-HttpTest` and
test the value against a list of known Container App resource names.
- If traffic matches this known list of resources, the behaviour must be set to `Allow` and no further rule evaluations
must take place.

## Consequences
_What becomes easier or more difficult to do because of this change?_

- This custom rule will also get logged in the WAF Logs so we can see when traffic is being matched against the policy
- It reduces any additional WAF pattern evaluation burden for these trusted requests.
