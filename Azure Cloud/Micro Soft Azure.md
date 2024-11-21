# Azure Resources Overview
What is Warehouse:
A data warehouse is a centralized repository that holds structured data (database tables, Excel sheets) and semi-structured data (XML files, webpages) for the purposes of reporting, analysis, and other forms of business intelligenc

![image](https://github.com/user-attachments/assets/b48a3fe6-772b-4bb5-a49c-5097af65822b)

## 1. Azure Data Lake
- **Definition**: A data lake is a **storage repository** that holds a large amount of data in its **native**, **raw** format.
- Data lake stores are optimized for scaling their size to **terabytes** and **petabytes** of data.
- A data lake helps you store everything in its **original**, **untransformed** state. This method differs from a traditional **data warehouse**
- **Real-time Scenario**: Used for storing and analyzing large volumes of structured, semi-structured, and unstructured data, such as logs, IoT data, and social media streams.
- **Key data lake use cases include:**
1. Cloud and Internet of Things (IoT) data movement.
2. Big data processing.
3.- Analytics.
4. Reporting.
5. On-premises data movement

## 2. Azure Data Factory
- **Definition**: cloud-based data integration service provided by Microsoft. It enables businesses to create, manage, and automate data pipelines that move and transform data from various sources into a centralized data store, making it ready for analytics and business intelligenc
- **Real-time Scenario**: Used for building **ETL** (**Extract, Transform, Load**) pipelines to move and transform data for analytics or machine learning applications.
- Code free ETL as a Service
**Key Features:**
- Data Movement
- Data Transformation
- Orchestration
- Scalability
- Integration
![image](https://github.com/user-attachments/assets/028f2891-fe44-43be-af61-84a702d1be4f)
## 3. Azure Data Bricks
- **Azure Databricks** open analytics platform for building, deploying, sharing, and maintaining enterprise-grade data, analytics, and **AI** solutions at scale. The Databricks Data Intelligence Platform integrates with cloud storage and security in your cloud account, and manages and deploys cloud infrastructure
- **Real-time Scenario** Azure Databricks is particularly useful for organizations dealing with **large-scale** data processing and analytics workloads, providing a powerful and flexible platform to handle big data efficiently
![image](https://github.com/user-attachments/assets/613bfce1-d6c4-4b27-a68a-e52011ea3816)

## Azure Synapse Analytics : 
Azure Synapse Analytics is an enterprise analytics service that accelerates time to insight across data warehouses and big data systems.
3 main components:
- data integration
- enterprise data warehousing
- big data analytics.



## 4. Logic Apps
- **Definition**: Azure Logic Apps is a cloud-based service that automates workflows and business processes through connectors for various systems.
- Schedule and send email notifications using Office 365 when a specific event happens, for example, a new file is uploaded.
- Route and process customer orders across on-premises systems and cloud services.
- Move uploaded files from an SFTP or FTP server to Azure Storage.
- Monitor tweets, analyze the sentiment, and create alerts or tasks for items that need review.
- **Real-time Scenario**: Used for automating tasks such as sending emails, integrating CRM systems, or managing approvals in a business process.

## 5. Azure Backups
- **Definition**: Azure Backup is a simple and cost-effective solution for backing up and restoring data in Azure.
- **Real-time Scenario**: Used for protecting virtual machines, databases, and files against accidental deletion, corruption, or ransomware attacks.

## 6. Cosmos DB
- **Definition**: Azure Cosmos DB is a globally distributed, multi-model database service designed for high availability and low latency.
- **Real-time Scenario**: Used for building scalable applications that require high throughput and real-time response, such as online retail, gaming, and IoT applications.

## 7. Azure Active Directory (AD) B2B
- **Definition**: Azure AD Business-to-Business (B2B) allows secure collaboration with external users by granting access to internal resources.
- securely share your company's applications and services with **partners** and **guest** users using Azure AD B2B. These users can come from different organizations
- Microsoft Teams, Outlook, SharePoint, OneDrive Files, Power BI Dashboards
- **Real-time Scenario**: Used to provide secure access to contractors, vendors, or business partners without creating separate accounts for them in the organization.

## 8. Azure Active Directory (AD) B2C
- **Definition**: customer identity and access management (CIAM) solution that allows businesses to manage and secure customer identities for their applications
- **Real-time Scenario**: Used by organizations to allow customers to sign in to applications using their preferred identity provider (Google, Facebook, etc.) or custom accounts.
  Imagine you have an e-commerce platform where customers can browse products, make purchases, and manage their accounts. You want to enable customers to sign up and sign in using their existing social media accounts  Facebook or Google, enterprise accounts Microsoft or LinkedIn or local accounts (email and password).
++++++++++++++++++++++++++++++++++

## 1. Traffic Manager
- **Definition**: Azure Traffic Manager is a DNS-based traffic load balancer that enables you to distribute traffic across multiple regions and endpoints.
- **Real-time Scenario**: Used to improve application availability by routing users to the nearest or most responsive regional endpoints, useful for applications with a global user base.

## 2. Front Door
- **Definition**: Azure Front Door is a global, scalable entry point for delivering high-performance and secure web applications, offering load balancing, acceleration, and WAF capabilities.
- **Real-time Scenario**: Used for ensuring fast, secure, and reliable access to applications from anywhere in the world, typically for global websites or services.

## 3. CDN Profile
- **Definition**: Azure Content Delivery Network (CDN) profiles provide caching and content acceleration by delivering content from the closest edge server to the user.
- **Real-time Scenario**: Used for speeding up the delivery of static content like images, scripts, and videos for geographically distributed users.

## 4. Application Gateway
- **Definition**: Azure Application Gateway is a layer 7 load balancer that provides SSL termination, URL-based routing, and WAF for web applications.
- **Real-time Scenario**: Used for securing and load balancing web applications with advanced routing scenarios, such as routing based on URL paths or headers.

## 5. API Management
- **Definition**: Azure API Management is a platform for managing, securing, and monitoring APIs with built-in versioning, throttling, and access control.
- **Real-time Scenario**: Used by businesses to expose services as APIs securely, apply rate limits, and monitor usage, often in microservices architectures.

## 6. Load Balancer
- **Definition**: Azure Load Balancer is a layer 4 (TCP/UDP) load balancer that distributes incoming traffic among virtual machines or services.
- **Real-time Scenario**: Used for distributing incoming traffic for high-availability applications running on virtual machines.


## 7. Azure Spring Apps
- **Definition**: A fully managed service for deploying and scaling Spring Boot applications in Azure.
- **Real-time Scenario**: Used by developers building microservices using the Spring framework to easily deploy and scale applications without managing infrastructure.

## 8. Web Apps
- **Definition**: Azure Web Apps is a platform-as-a-service (PaaS) offering for hosting web applications, RESTful APIs, and mobile backends.
- **Real-time Scenario**: Used to quickly deploy web applications without worrying about underlying infrastructure management.

## 9. Function Apps
- **Definition**: Azure Function Apps provide a serverless compute service that allows you to run small pieces of code (functions) without managing the infrastructure.
- **Real-time Scenario**: Used for running event-driven applications, such as processing data from IoT devices or responding to HTTP requests.

## 10. Private DNS Zones
- **Definition**: Azure Private DNS Zones provide DNS resolution for resources within a virtual network without exposing DNS records to the internet.
- **Real-time Scenario**: Used to manage internal DNS resolution in hybrid or multi-region applications without using public DNS.

## 11. Virtual Network (VNet)
- **Definition**: Azure Virtual Network is a fundamental building block for private networking in Azure, allowing you to securely connect resources.
- **Real-time Scenario**: Used to create isolated, secure networks for hosting resources like virtual machines, databases, and services.

## 12. Subnet
- **Definition**: A subnet is a range of IP addresses within a VNet that divides the virtual network into smaller segments for isolating resources.
- **Real-time Scenario**: Used to logically separate and secure different workloads like web, database, and application tiers within a VNet.

## 13. Private Link
- **Definition**: Azure Private Link allows you to access Azure services securely over a private IP in your virtual network.
- **Real-time Scenario**: Used to securely connect to services like Azure Storage or SQL Database without exposing traffic to the internet.

## 14. Peering
- **Definition**: Virtual network peering connects two Azure VNets, enabling them to communicate as if they were on the same network.
- **Real-time Scenario**: Used for seamless communication between different VNets across regions or subscriptions for distributed applications.

## 15. Service Endpoint
- **Definition**: Service Endpoints provide secure, direct connectivity to Azure services over an optimized path within a VNet.
- **Real-time Scenario**: Used to improve security by allowing resources in a VNet to access Azure services (like Storage Accounts) without public internet exposure.

## 16. Private Endpoint
- **Definition**: Azure Private Endpoint allows you to connect privately to Azure services via a private IP from your VNet.
- **Real-time Scenario**: Used to enhance security for services like Azure SQL Database or Azure Storage by allowing only private, internal connections.

## 17. Storage Account
- **Definition**: Azure Storage Account is a cloud storage service that provides highly available and durable storage for blobs, files, queues, and tables.
- **Real-time Scenario**: Used for storing unstructured data, media files, or backups in a cost-effective, scalable way.
 
## 18. Network Security Group (NSG)
- **Definition**: network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.
- **Real-time Scenario**: Used for securing VMs and subnets by filtering traffic based on IP address, port, and protocol.

## 19. Application Security Group (ASG)
- **Definition**: Azure Application Security Groups (ASG) allow you to group resources based on their applications for easy management of security rules.
- **Real-time Scenario**: Used to simplify network security rule management by grouping VMs based on application roles.

## 20. Virtual Network NAT
- **Definition**: Azure Virtual Network NAT (Network Address Translation) provides outbound internet access for virtual machines in a VNet without the need for a public IP on each VM.
- **Real-time Scenario**: Used to centralize and manage outbound connectivity for resources in private VNets.

## 21. Virtual WAN
- **Definition**: Azure Virtual WAN is a networking service that provides optimized and automated branch-to-branch and branch-to-Azure connectivity through a single portal.
- **Real-time Scenario**: Used for enterprises with multiple branch offices or on-premises locations needing optimized and scalable network connections to Azure.

## 22. Network Virtual Appliance (NVA)
- **Definition**: NVAs are virtual machines that run network appliance software, such as firewalls, routers, or load balancers, in Azure.
- **Real-time Scenario**: Used for implementing custom network security solutions or traffic management for complex networking environments.

## 23. Azure AD Types
- **Definition**: Azure Active Directory (Azure AD) provides identity and access management in the cloud. Types include Basic, Premium P1, and Premium P2.
- **Real-time Scenario**: Used to manage user identities and access control for applications, with features scaling up for enterprises requiring advanced security.

## 24. Azure AD B2B
- **Definition**: Azure AD Business-to-Business (B2B) allows organizations to securely share resources and collaborate with external users.
- **Real-time Scenario**: Used when collaborating with partners, vendors, or contractors, giving them access to internal apps without creating new identities in your directory.

## 25. Azure AD B2C
- **Definition**: Azure AD Business-to-Consumer (B2C) enables customer identity and access management, allowing businesses to manage customer profiles securely.
- **Real-time Scenario**: Used for applications requiring user registration and authentication, typically for retail or service-based applications that need to manage customer access.

## 26. VNet Types
   - **VNet Peering**: Allows direct connectivity between two VNets. Used for linking VNets within the same or different Azure regions.
   - **VNet to VNet**: Allows communication between VNets over Azure's backbone. Used for connecting resources across regions.
   - **Point-to-Site**: Provides secure access to Azure VNets for individual clients via VPN. Used when remote employees need to securely access VNet resources.
   - **Site-to-Site**: Enables a secure connection between an on-premises network and an Azure VNet via VPN. Used for hybrid cloud solutions.
   - **ExpressRoute**: Provides a private, dedicated connection between on-premises infrastructure and Azure. Used for large enterprises requiring high throughput and low latency.

