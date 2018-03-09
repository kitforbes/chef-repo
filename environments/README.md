# Environments

Create environments here, in either the Role Ruby DSL (`.rb`) or JSON (`.json`) files. To install environments on the server, use knife.

For example, in this directory you'll find an example environment file called `example.json` which can be uploaded to the Chef Server:

```bash
knife environment from file environments/example.json
```

For more information on environments, see the [documentation](https://docs.chef.io/environments.html).

## Index

- [Root](../README.md)
- [Cookbooks](../cookbooks/README.md)
- [Data Bags](../data_bags/README.md)
- [Roles](../roles/README.md)
