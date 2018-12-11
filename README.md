# MSMQ message provider for sensenet [legacy]
MSMQ  implementation for sending server-to-server messages in sensenet.

> **Please note** that in a cloud-based environment it is more advisable to use a more modern message provider like [RabbitMQ for sensenet](https://github.com/SenseNet/sn-messaging-rabbitmq).

## Installation
To get started, install the following NuGet package:

[![NuGet](https://img.shields.io/nuget/v/SenseNet.Messaging.MSMQ.svg)](https://www.nuget.org/packages/SenseNet.Messaging.MSMQ)

> This is a dll-ony package, not a full sensenet component, so you only have to install the package above in Visual Studio and configure your instance.

## Configuration
Please make these additions in every configuration file you plan to use in a load balanced environment (e.g. _web.config_ and _[web]\Tools\SnAdminRuntime.exe.config_).

### Config sections
Make sure your config file contains the necessary config section definitions at the beginning of the file:

```xml
<configSections>
    <sectionGroup name="sensenet">
      <section name="messaging" type="System.Configuration.NameValueSectionHandler" />
      <section name="providers" type="System.Configuration.NameValueSectionHandler" />
    </sectionGroup>
</configSections>
```

### Messaging providers
Please configure both the main and the security message providers.

```xml
<providers>
  <add key="ClusterChannelProvider" value="SenseNet.Communication.Messaging.MsmqChannelProvider" />
  <add key="SecurityMessageProvider" value="SenseNet.Security.Messaging.Msmq.MsmqMessageProvider" />
</providers>
```

#### Main message queues
Provide the queue names that you registered on the server (one per app domain).

```xml
<messaging>
  <add key="MsmqChannelQueueName" value=".\private$\ryan1;.\private$\ryan2" />
</messaging>
```

> **Important**: the order of the names is important: the dedicated local queue comes first. This means that web.config values on all web servers are different.

#### Security queues
Similarly to main queues, security queues also need to be in the appropriate order: local queue first.

```xml
<appSettings>
    <add key="SecurityMsmqChannelQueueName" value=".\private$\security1;.\private$\security2" />
</appSettings>
```