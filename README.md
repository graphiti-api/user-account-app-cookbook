# Graphiti User Accounts Cookbook

This is a sample Rails application designed to be used as an example
for how to implement account creation, sign in, and authentication
using the Graphiti API framework.  The backend includes a full user
creation and authentication workflow, including thorough unit testing.
The frontend is written in VueJS and uses the Graphiti's Spraypaint
javascript client for communication to the backend.

This project contains examples of a number of common but non-obvious
scenarios that you may need to implement in the course of building a
Rails/Graphiti project:

- Resources that don't map directly to a single ActiveRecord model
  or database table
- Sending transactional emails after certain steps are completed
- Authentication without a framework like devise or warden
- Mixing authenticated and unauthenticated endpoints in an API
- Overriding standard resource scoping for a specific endpoint