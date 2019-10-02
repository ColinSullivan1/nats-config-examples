curl -X PUT http://127.0.0.1:9090/v1/auth/perms/guest -d '{ "publish": { "allow": ["foo.*", "bar.>"] }, "subscribe": { "deny": ["quux"] } }'
