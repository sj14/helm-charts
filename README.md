# Helm Charts

See [charts/sftp-server](/charts/sftp-server)

## Contributing

### Tests

Keep the `tests/values/*` files up to date when adjusting featues. Run `make tests` to update the golden master test files and commit the changes.

### Readme

The chart's `README.md` is auto-generated, adjust the `values.yaml` accordingly with comments and run `make helm-docs` afterwards.
