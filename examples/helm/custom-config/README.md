RadonDB Data Custom Config Helm Example
=======

[PostgreSQL](https://postgresql.org) is a powerful, open source object-relational database system. It has more than 15 years of active development and a proven architecture that has earned it a strong reputation for reliability, data integrity, and correctness.


TL;DR;
------

```console
$ helm install custom-config --name custom-config
```

Introduction
------------

This is an example of running the RadonDB PostgreSQL containers using the Helm project! More examples of the RadonDB Containers for PostgreSQL can be found at the [GitHub repository](https://github.com/RadonDBData/radondb-containers).

This example will create the following in your Kubernetes cluster:

 * Create a configmap named *custom-config*
 * Create a pod named *custom-config*
 * Create a service named *custom-config*
 * Create a release named *custom-config*
 * Initialize the database using the predefined environment variables

This example creates a simple PostgreSQL deployment with a single primary using custom configurations.

Installing the Chart
--------------------

The chart can be installed as follows:

```console
$ helm install custom-config --name custom-config
```

The command deploys a primary pod on the Kubernetes cluster using the custom configuration files.

> **Tip**: List all releases using `helm list`

Using the Chart
----------------------

After the database starts up you can connect to it as follows:

```console
$ psql -h custom-config -U postgres postgres
```

Uninstalling the Chart
----------------------

To uninstall/delete the `custom-config` deployment:

```console
$ helm del --purge custom-config
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

Configuration
-------------

See `values.yaml` for configuration notes. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install custom-config --name custom-config \
  --set Image.tag=centos8-13.3-4.7.1
```

The above command changes the image tag of the container to of `centos8-13.3-4.7.1`.

> **Tip**: You can use the default [values.yaml](values.yaml)

| Parameter                  | Description                        | Default                                                    |
| -----------------------    | ---------------------------------- | ---------------------------------------------------------- |
| `.name`                 | Name of release.                 | `custom-config`                                        |
| `.container.port`        | The port used for the primary container      | `5432`                                                      |
| `.container.name`        | Name for the primary container      | `custom-config`                                                      |
| `.credentials.primary`                | Password for the primary user    | `password`                                                      |
| `.credentials.root`            | Password for the root user        | `password`                                                      |
| `.credentials.user`            | Password for the standard user   | `password`                                                      |
| `.serviceType`      | The type of service      | `ClusterIP`               
| `.image.repository` | The repository on DockerHub where the images are found.    | `radondb`                                           |
| `.image.container` | The container to be pulled from the repository.    | `radondb-postgres`                                                    |
| `.image.tag` | The image tag to be used.    | `centos8-13.3-4.7.1`                                                    |
| `.resources.cpu` | Defines a limit for CPU    | `200m`                                                    |
| `.resources.memory` | Defines a limit for memory    | `512Mi`                                                    |

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install custom-config --name custom-config  \
  -f values.yaml
```

Legal Notices
-------------

Copyright 2018 - 2021 Crunchy Data Solutions, Inc.

Crunchy Data Solutions, INC. PROVIDES THIS GUIDE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF NON INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

RadonDB, Crunchy Data Solutions, Inc. and the RadonDB Hippo Logo are trademarks of Crunchy Data Solutions, Inc.
