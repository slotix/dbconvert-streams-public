# The MCP server, ready to run.
#
# The server itself is proprietary and is distributed as a published image
# rather than as source, so this file pins that image instead of building one.
# It exists because directories that index MCP servers — Glama among them —
# build each entry from a Dockerfile and start it to read its tool list.
#
# Starting it with no arguments is valid and answers introspection with the
# two core tools. Give it sources to get the rest:
#
#   docker run -i --rm slotix/stream-mcp \
#     shop=postgres://user:password@host:5432/shop \
#     lake=s3://analytics/exports?region=eu-central-1
#
# https://streams.dbconvert.com/docs/mcp/standalone
FROM slotix/stream-mcp:2.7.1
