You are operating a geographically dispersed replica set as outlined below:

Your network operations team has asked if you can limit the amount of outbound traffic from Site A because of some capacity issues with the traffic in and out of that site. For example, consider that this is where the majority of your users stream/download. However, due to how the application is deployed, you wish to keep your write traffic in Site A for performance, and so you have chosen not to change which server is primary.

Using replica set chaining, which of the following scenarios will minimize traffic due to MongoDB replication in and out of Site A?