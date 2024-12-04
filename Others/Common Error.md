# Commonly Asked Ports and Error Codes in DevOps Interviews

## **Commonly Used Ports**

| **Port Number** | **Protocol/Service**        | **Description**                                                                 |
|------------------|-----------------------------|---------------------------------------------------------------------------------|
| 22               | SSH                        | Secure Shell for remote login and command execution.                           |
| 80               | HTTP                       | HyperText Transfer Protocol for web traffic.                                   |
| 443              | HTTPS                      | Secure version of HTTP using SSL/TLS encryption.                               |
| 3389             | RDP                        | Remote Desktop Protocol for remote desktop access.                             |
| 21               | FTP                        | File Transfer Protocol for transferring files.                                 |
| 20               | FTP (Data)                 | FTP data transfer port.                                                        |
| 25               | SMTP                       | Simple Mail Transfer Protocol for email delivery.                              |
| 53               | DNS                        | Domain Name System for resolving domain names to IP addresses.                 |
| 3306             | MySQL                      | Default port for MySQL database communication.                                 |
| 1433             | MSSQL                      | Microsoft SQL Server database communication.                                   |
| 5432             | PostgreSQL                 | Default port for PostgreSQL database communication.                            |
| 8080             | HTTP (Alternative)         | Often used as an alternative HTTP port for web services.                       |
| 8443             | HTTPS (Alternative)        | Secure web traffic for alternative services or APIs.                           |
| 110              | POP3                       | Post Office Protocol for retrieving email from a mail server.                  |
| 995              | POP3S                      | Secure version of POP3.                                                        |
| 143              | IMAP                       | Internet Message Access Protocol for retrieving emails.                        |
| 993              | IMAPS                      | Secure version of IMAP.                                                        |
| 389              | LDAP                       | Lightweight Directory Access Protocol for directory services.                  |
| 636              | LDAPS                      | Secure LDAP over SSL/TLS.                                                      |
| 9092             | Apache Kafka               | Communication port for Kafka brokers.                                          |

---

## **Commonly Encountered Error Codes**

| **Error Code** | **Description**                                      | **Possible Cause**                                                                 |
|-----------------|------------------------------------------------------|-----------------------------------------------------------------------------------|
| 200             | OK                                                   | Request was successful.                                                          |
| 201             | Created                                              | Resource was successfully created.                                               |
| 400             | Bad Request                                          | Client sent an invalid or malformed request.                                     |
| 401             | Unauthorized                                         | Authentication is required or has failed.                                        |
| 403             | Forbidden                                            | Client does not have permission to access the resource.                          |
| 404             | Not Found                                            | Resource could not be found on the server.                                       |
| 408             | Request Timeout                                      | Server timed out waiting for the client’s request.                               |
| 409             | Conflict                                             | Request conflicts with the current state of the resource.                        |
| 500             | Internal Server Error                                | Generic server error.                                                            |
| 502             | Bad Gateway                                          | Server received an invalid response from an upstream server.                     |
| 503             | Service Unavailable                                  | Server is temporarily unable to handle the request (e.g., overload or maintenance). |
| 504             | Gateway Timeout                                      | Server did not receive a timely response from the upstream server.               |
| 10054           | Connection Reset by Peer                             | Connection was forcibly closed by the remote server.                             |
| 11001           | Host Not Found                                       | Domain name could not be resolved to an IP address.                              |
| 12029           | Connection to Server Failed                          | Network connectivity issues or server unreachable.                               |
| 0x80070005      | Access Denied                                        | Permissions issue, commonly encountered in Windows-based systems.                |
| 0x80004005      | Unspecified Error                                    | General failure without a specific description.                                  |
| ECONNREFUSED    | Connection Refused                                   | Server is not accepting connections on the specified port.                       |
| ETIMEDOUT       | Connection Timed Out                                 | Connection attempt to the server timed out.                                      |
| ENOENT          | No Such File or Directory                            | Specified file or path does not exist.                                           |

---
## **Abbreviations**
- **RDBMS** stands for Relational Database Management System

These ports and error codes are commonly encountered in real-world scenarios and are frequently asked in DevOps interviews. Being familiar with their usage and troubleshooting them is essential for success.
